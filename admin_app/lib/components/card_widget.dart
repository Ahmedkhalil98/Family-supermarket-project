import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  CardWidget({Key? key, required this.title, required this.imageUrl})
      : super(key: key);
  String title;
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Card(
        child: ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
          ),
          leading: Image.asset(imageUrl),
        ),
      ),
    );
  }
}
