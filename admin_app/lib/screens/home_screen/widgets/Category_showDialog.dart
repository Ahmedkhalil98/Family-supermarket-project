import 'dart:io';

import 'package:adminapp/components/submit_button_widget.dart';
import 'package:adminapp/components/text_field_widget.dart';
import 'package:adminapp/constants.dart';
import 'package:adminapp/models/category_model.dart';
import 'package:adminapp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class catShowDialog extends ChangeNotifier {
  Future<dynamic> showDialogStyle({
    required BuildContext context,
    Category? data,
    required String state,
  }) async {
    return showDialog(
        context: context,
        builder: (context) {
          final actionProvider = Provider.of<ApiProvider>(context);
          File? file;
          TextEditingController titlecontroller = TextEditingController();
          String imagecontroller = "Upload image";
          if (data != null) {
            titlecontroller.text = data.title;
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
                    "$state Category",
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
              ]),
            ),
            content: SizedBox(
              width: 400.w,
              //  height: 300.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyTextField(
                        hintText: "Category Name",
                        prefixicon: Icons.title_outlined,
                        controller: titlecontroller),
                    Container(
                      height: 40.h,
                      margin: EdgeInsets.only(top: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: kDescriptionColor),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Text(
                                imagecontroller,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
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
                    GestureDetector(
                        onTap: () {
                          if (state == 'Add') {
                            actionProvider.addCategory(data: {
                              "action": "ADD_CATEGORY",
                              "title": titlecontroller.text,
                            }, file: file!);
                            Navigator.of(context).pop();
                            //Get.back();
                          } else {
                            //ToDo:
                            actionProvider.updateCategory(data: {
                              "action": "UPDATE_CATEGORY",
                              "title": titlecontroller.text,
                              "imageName": imagecontroller,
                              "id": data!.id,
                            });
                            titlecontroller.clear();

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
