import 'package:adminapp/components/app_bar_widget.dart';
import 'package:adminapp/components/empty_page_widget.dart';
import 'package:adminapp/components/loading_widget.dart';
import 'package:adminapp/constants.dart';
import 'package:adminapp/models/product_model.dart';
import 'package:adminapp/screens/home_screen/widgets/control_button.dart';
import 'package:adminapp/services/api_provider.dart';
import 'package:adminapp/services/products_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductsListView extends StatefulWidget {
  const ProductsListView({Key? key}) : super(key: key);

  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: MyAppBar(pageTitle: productProvider.getTypeName),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<ProductsDialog>()
              .showDialogStyle(context: context, state: 'Add');
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            FutureBuilder<ProductsModel>(
              future: productProvider.getProducts(),
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
                      errorText: "empty", imageUrl: "images/box.png");
                }

                if (snapshot.data == null) {
                  return EmptyPageWidget(
                      errorText: "empty", imageUrl: "images/box.png");
                }
                List<Product> productList = snapshot.data!.products;
                return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        height: 200.h,
                        width: 190.w,
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          children: [
                            Container(
                              // height: 300,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 130.w,
                                    height: 100.h,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.w),
                                          child: Image.network(
                                            "https://family-supermarket.000webhostapp.com/images/${productList[index].imageurl}",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    productList[index].title,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.h),
                                    child: Text(
                                      '${productList[index].unitsize} ${productList[index].unit}',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: kDescriptionColor
                                              .withOpacity(0.6)),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Price:",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: kBlackColor),
                                        ),
                                        Text(
                                          '${productList[index].price} IQD',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: kPrimaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<ProductsDialog>()
                                          .showDialogStyle(
                                            context: context,
                                            state: 'update',
                                            data: productList[index],
                                          );
                                    },
                                    child: ControlButton(
                                        color: Colors.green,
                                        iconData: Icons.edit,
                                        title: "edit"),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      productProvider.deleteProducts(
                                        sliderId: productList[index].id,
                                        imageName: productList[index].imageurl,
                                      );
                                    },
                                    child: ControlButton(
                                        color: Colors.red,
                                        iconData: Icons.delete,
                                        title: "delete"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }

//

}
