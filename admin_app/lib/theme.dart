import 'package:adminapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: kBackGroundColor,
    fontFamily: "Roboto",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      centerTitle: true,
      backgroundColor: kPrimaryColor,
      elevation: 1,
      iconTheme: IconThemeData(color: kWhiteColor, size: 30),
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        color: kWhiteColor,
      ));
}

TextTheme? textTheme() {
  return TextTheme(
    bodyLarge: TextStyle(
      fontSize: 16,
      color: kBlackColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: kBlackColor,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: kDescriptionColor,
    ),
  );
}
