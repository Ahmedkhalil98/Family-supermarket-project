import 'package:adminapp/components/app_bar_widget.dart';
import 'package:adminapp/components/empty_page_widget.dart';
import 'package:adminapp/components/loading_widget.dart';
import 'package:adminapp/models/orders_model.dart';
import 'package:adminapp/services/api_orders_provider.dart';
import 'package:adminapp/services/order_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiOrderProvider = Provider.of<ApiOrders>(context);
    final orderDialog = Provider.of<OrderDialog>(context);
    return Scaffold(
      appBar: MyAppBar(pageTitle: "Orders"),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              FutureBuilder<OrdersModel>(
                future: apiOrderProvider.getOrders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 250.h,
                        ),
                        const LoadingWidget(),
                      ],
                    );
                  }
                  if (snapshot.hasError) {
                    return EmptyPageWidget(
                        errorText: "No Orders Yet!",
                        imageUrl: "images/emptycart.png");
                  }
                  if (snapshot.data == null) {
                    return EmptyPageWidget(
                        errorText: "No Orders Yet!",
                        imageUrl: "images/emptycart.png");
                  }
                  List<Order> orderData = snapshot.data!.orders;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                            onTap: () {
                              apiOrderProvider.setOrderData = orderData[index];
                              orderDialog.moreInfoAboutOrders(context);
                            },
                            title: Text("order #${orderData[index].passcode}"),
                            leading: apiOrderProvider
                                .stateOfOrders(orderData[index].state),
                            subtitle: Text(
                              orderData[index].state,
                              style: TextStyle(
                                  color: apiOrderProvider
                                      .stateColor(orderData[index].state)),
                            ),
                            trailing: Text(orderData[index].dateTime)),
                      );
                    },
                  );
                },
              )
            ],
          )),
    );
  }
}
