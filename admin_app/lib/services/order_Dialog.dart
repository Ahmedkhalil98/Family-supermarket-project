import 'dart:convert';

import 'package:adminapp/constants.dart';
import 'package:adminapp/models/order_item_model.dart';
import 'package:adminapp/services/api_orders_provider.dart';
import 'package:adminapp/services/launch_map_and_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';

class OrderDialog extends ChangeNotifier {
  Widget textTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Future<dynamic> moreInfoAboutOrders(BuildContext context) {
    double totalPrice = 0;
    return showDialog(
        context: context,
        builder: (context) {
          final apiOrderProvider = Provider.of<ApiOrders>(context);
          String text =
              HtmlUnescape().convert(apiOrderProvider.orderData!.orderItems);
          String removeExtraChar1 = text.replaceAll('"{', '{');
          String jsondata = removeExtraChar1.replaceAll('}"', '}');
          List orderItemList = jsonDecode(jsondata);
          for (var element in orderItemList) {
            totalPrice +=
                int.parse(OrderItemModel.fromMap(element).product.price) *
                    OrderItemModel.fromMap(element).quantity!;
          }
          return AlertDialog(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            titlePadding: EdgeInsets.zero,
            title: Container(
              height: 90.h,
              color: kPrimaryColor,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    "Order Code #${apiOrderProvider.orderData!.passcode} ",
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Container(
                    width: 140.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        apiOrderProvider
                            .stateOfOrders(apiOrderProvider.orderData!.state),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          apiOrderProvider.orderData!.state,
                          style: TextStyle(
                              color: apiOrderProvider.stateColor(
                                  apiOrderProvider.orderData!.state)),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Text(
                    apiOrderProvider.orderData!.dateTime,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ]),
            ),
            contentPadding: EdgeInsets.zero,
            content: Container(
              margin: EdgeInsets.all(10.h),
              height: 400.h,
              width: 400.w,
              color: kWhiteColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 10.w),
                      title: textTitle("User Phone"),
                      subtitle: Text(apiOrderProvider.orderData!.userPhone),
                      trailing: IconButton(
                          onPressed: () {
                            LaunchProvider launch = LaunchProvider();
                            launch.makePhoneCall(
                                apiOrderProvider.orderData!.userPhone);
                          },
                          icon: const Icon(Icons.phone)),
                    ),
                    const Divider(),
                    ListTile(
                        contentPadding: EdgeInsets.only(left: 10.w),
                        title: textTitle("User Location"),
                        subtitle:
                            Text(apiOrderProvider.orderData!.userLocation),
                        trailing: IconButton(
                          onPressed: () {
                            LaunchProvider launch = LaunchProvider();
                            launch.makeMap(
                                apiOrderProvider.orderData!.userLatLng);
                          },
                          icon: const Icon(Icons.map),
                        )),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: textTitle("Order Items"),
                    ),
                    Container(
                      // height: 100.h,
                      padding: EdgeInsets.only(left: 10.w, bottom: 5.h),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                          ),
                          itemCount: orderItemList.length,
                          itemBuilder: (context, index) {
                            OrderItemModel orderItem =
                                OrderItemModel.fromMap(orderItemList[index]);

                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  width: 10.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                      //color: Colors.red,
                                      borderRadius: BorderRadius.circular(10.r),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://family-supermarket.000webhostapp.com/images/${orderItem.product.imageurl}"))),
                                ),
                                Positioned(
                                    width: 20.w,
                                    height: 20.h,
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor: kPrimaryColor,
                                      child: Text(
                                        orderItem.quantity.toString(),
                                        style: TextStyle(color: kWhiteColor),
                                      ),
                                    )),
                              ],
                            );
                          }),
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textTitle("Total"),
                          Text(
                            "$totalPrice IQD",
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: textTitle("Action"),
                    ),
                    GestureDetector(
                      onTap: () {
                        apiOrderProvider.changeOrderState(
                            apiOrderProvider.orderData!.passcode);
                        Get.back();
                      },
                      child: listWidget(
                          titleWidget: const Text('Work on order'),
                          iconData: Icons.timelapse,
                          color: Colors.blue),
                    ),
                    GestureDetector(
                      onTap: () {
                        apiOrderProvider
                            .deleteOrder(apiOrderProvider.orderData!.passcode);
                        Get.back();
                      },
                      child: listWidget(
                          titleWidget: const Text("Delete order"),
                          iconData: Icons.delete,
                          color: Colors.red),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget listWidget(
      {required Widget titleWidget,
      IconData? iconData,
      Color? color,
      Widget? trailingWidget,
      Widget? subtitleWidget}) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10.w),
      horizontalTitleGap: 0,
      dense: true,
      title: titleWidget,
      leading: Icon(
        iconData,
        color: color,
      ),
      subtitle: subtitleWidget,
      trailing: trailingWidget,
    );
  }
}
