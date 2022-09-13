import 'package:adminapp/components/app_bar_widget.dart';
import 'package:adminapp/components/empty_page_widget.dart';
import 'package:adminapp/components/loading_widget.dart';
import 'package:adminapp/constants.dart';
import 'package:adminapp/models/category_model.dart';
import 'package:adminapp/screens/home_screen/types_list_view.dart';
import 'package:adminapp/screens/home_screen/widgets/Category_showDialog.dart';
import 'package:adminapp/screens/home_screen/widgets/control_button.dart';
import 'package:adminapp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({Key? key}) : super(key: key);

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: MyAppBar(pageTitle: "Categories"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<catShowDialog>()
              .showDialogStyle(context: context, state: 'Add');
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              FutureBuilder<CategoriesModel>(
                future: categoryProvider.getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 250.h,
                        ),
                        const LoadingWidget(),
                      ],
                    );
                  }
                  if (snapshot.hasError) {
                    return EmptyPageWidget(
                        errorText: "empty", imageUrl: "images/box.png");
                  }

                  if (snapshot.data == null) {
                    return EmptyPageWidget(
                        errorText: "empty", imageUrl: "images/box.png");
                  }
                  List<Category> catData = snapshot.data!.categories;

                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.98,
                      ),
                      itemCount: catData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            categoryProvider.setCatId = catData[index].id;
                            categoryProvider.setCatTitle = catData[index].title;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TypeListView()));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            height: 200.h,
                            width: 190.w,
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 200.w,
                                    height: 140.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.r),
                                          topRight: Radius.circular(10.r)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://family-supermarket.000webhostapp.com/images/${catData[index].imageurl}"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<catShowDialog>()
                                              .showDialogStyle(
                                                  context: context,
                                                  data: catData[index],
                                                  state: "update");
                                        },
                                        child: ControlButton(
                                            color: Colors.green,
                                            iconData: Icons.edit,
                                            title: "edit"),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Consumer<ApiProvider>(
                                        builder: (context, action, child) {
                                          return GestureDetector(
                                            onTap: () {
                                              action.deleteCategory(
                                                sliderId: catData[index].id,
                                                imageName:
                                                    catData[index].imageurl,
                                              );
                                            },
                                            child: ControlButton(
                                                color: Colors.red,
                                                iconData: Icons.delete,
                                                title: "delete"),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          )),
    );
  }

//

}
