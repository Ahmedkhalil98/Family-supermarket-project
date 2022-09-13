import 'package:adminapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySubmitButton extends StatelessWidget {
  MySubmitButton({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.w),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          //shadowBox,
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: kWhiteColor,
        ),
      ),
    );
  }
}
