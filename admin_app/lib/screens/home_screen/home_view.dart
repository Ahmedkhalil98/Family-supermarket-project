import 'package:adminapp/components/app_bar_widget.dart';
import 'package:adminapp/components/card_widget.dart';
import 'package:adminapp/screens/home_screen/categories_list_view.dart';
import 'package:adminapp/screens/home_screen/sliders_list_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(pageTitle: "Application"),
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SliderListView()));
              },
              child: CardWidget(
                title: "sliders",
                imageUrl: 'images/slide_show.png',
              )),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoriesListView()));
              },
              child: CardWidget(
                title: "Categories",
                imageUrl: 'images/category.png',
              )),
        ],
      ),
    );
  }
}
