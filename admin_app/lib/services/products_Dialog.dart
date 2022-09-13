import 'dart:io';

import 'package:adminapp/components/submit_button_widget.dart';
import 'package:adminapp/components/text_field_widget.dart';
import 'package:adminapp/constants.dart';
import 'package:adminapp/models/product_model.dart';
import 'package:adminapp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductsDialog extends ChangeNotifier {
  Future<dynamic> showDialogStyle({
    required BuildContext context,
    Product? data,
    required String state,
  }) async {
    return showDialog(
        context: context,
        builder: (context) {
          File? file;
          final productsProvider = Provider.of<ApiProvider>(context);
          TextEditingController titleController = TextEditingController();
          TextEditingController unitController = TextEditingController();
          TextEditingController unitSizeController = TextEditingController();
          TextEditingController priceController = TextEditingController();
          String imagecontroller = "upload image";
          if (data != null) {
            titleController.text = data.title;
            unitController.text = data.unit;
            unitSizeController.text = data.unitsize;
            priceController.text = data.price;
            imagecontroller = data.imageurl;
          }

          return AlertDialog(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            titlePadding: EdgeInsets.zero,
            title: Container(
              color: kPrimaryColor,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$state Product",
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
              ]),
            ),
            content: SizedBox(
              width: 400.w,
              height: 300.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyTextField(
                        hintText: "Product Name",
                        prefixicon: Icons.title_outlined,
                        controller: titleController),
                    MyTextField(
                        hintText: "Product Unit",
                        prefixicon: Icons.scale,
                        controller: unitController),
                    MyTextField(
                        hintText: "Product Unit Size",
                        prefixicon: Icons.group_work,
                        controller: unitSizeController),
                    MyTextField(
                        hintText: "Product Price",
                        prefixicon: Icons.price_change,
                        controller: priceController),
                    Container(
                      height: 40.h,
                      margin: EdgeInsets.only(top: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: kDescriptionColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Text(
                                imagecontroller,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  color: kDescriptionColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 60.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8.r),
                                  bottomRight: Radius.circular(8.r),
                                )),
                            child: GestureDetector(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                file = File(image!.path);

                                imagecontroller = "oky";
                                //file!.path.split('/').last;
                              },
                              child: Icon(
                                Icons.upload,
                                size: 30,
                                color: kWhiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          if (state == 'Add') {
                            //ToDo:
                            productsProvider.addProducts(file: file!, data: {
                              "action": "ADD_PRODUCT",
                              'title': titleController.text,
                              'price': priceController.text,
                              'unit': unitController.text,
                              'unitsize': unitSizeController.text,
                              'typeid': productsProvider.getTypeId,
                            });
                            Get.back();
                          } else {
                            //ToDo:
                            productsProvider.updateProducts(data: {
                              "action": "UPDATE_PRODUCT",
                              'title': titleController.text,
                              'price': priceController.text,
                              'unit': unitController.text,
                              'unitsize': unitSizeController.text,
                              'typeid': productsProvider.getTypeId,
                              'file': imagecontroller,
                              'id': data!.id,
                            });
                            Get.back();
                          }
                        },
                        child: MySubmitButton(title: state)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
