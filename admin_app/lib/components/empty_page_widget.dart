import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyPageWidget extends StatelessWidget {
  EmptyPageWidget({Key? key, required this.errorText, required this.imageUrl})
      : super(key: key);
  String errorText;
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 200.h,
          ),
          Image.asset(imageUrl),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Text(errorText),
          ),
        ],
      ),
    );
  }
}
