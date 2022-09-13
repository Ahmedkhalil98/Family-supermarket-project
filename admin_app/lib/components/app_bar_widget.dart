import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  MyAppBar({
    required this.pageTitle,
    Key? key,
  }) : super(key: key);
  String pageTitle;
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        pageTitle,
      ),
    );
  }
}
