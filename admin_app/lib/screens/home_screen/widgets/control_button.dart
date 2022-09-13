import 'package:adminapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ControlButton extends StatelessWidget {
  ControlButton(
      {Key? key,
      required this.color,
      required this.iconData,
      required this.title})
      : super(key: key);
  String title;
  IconData iconData;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
      ),
      // width: 80,
      height: 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: kWhiteColor,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            title,
            style: TextStyle(color: kWhiteColor),
          ),
        ],
      ),
    );
  }
}
