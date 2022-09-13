import 'package:adminapp/screens/navbar/navbar_view.dart';
import 'package:adminapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: //TestData(),
              //TypeListView(),
              // CategoriesListView(),
              // SliderListView(),
              const NavBarView(),
          theme: themeData(),
        );
      },
    );
  }
}
