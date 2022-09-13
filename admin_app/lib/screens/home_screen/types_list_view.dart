import 'package:adminapp/components/app_bar_widget.dart';
import 'package:adminapp/components/empty_page_widget.dart';
import 'package:adminapp/components/loading_widget.dart';
import 'package:adminapp/components/submit_button_widget.dart';
import 'package:adminapp/components/text_field_widget.dart';
import 'package:adminapp/constants.dart';
import 'package:adminapp/models/type_model.dart';
import 'package:adminapp/screens/home_screen/products_list_view.dart';
import 'package:adminapp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TypeListView extends StatefulWidget {
  const TypeListView({Key? key}) : super(key: key);

  @override
  State<TypeListView> createState() => _TypeListViewState();
}

class _TypeListViewState extends State<TypeListView> {
  @override
  Widget build(BuildContext context) {
    final typeProvider = Provider.of<ApiProvider>(context, listen: true);
    return Scaffold(
      appBar: MyAppBar(pageTitle: typeProvider.getCategoryTitle),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogStyle(context: context, state: "Add");
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<TypeModel>(
          future: typeProvider.getTypes(),
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
            List<Type> typeList = snapshot.data!.types;
            return ListView.builder(
              itemCount: typeList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Card(
                    child: ListTile(
                      title: GestureDetector(
                        onTap: () {
                          typeProvider.setTypeId = typeList[index].id;
                          typeProvider.setTypeName = typeList[index].typeName;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ProductsListView()));
                        },
                        child: Text(
                          typeList[index].typeName,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 60.w,
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  showDialogStyle(
                                      context: context,
                                      state: "update",
                                      data: typeList[index]);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  typeProvider.deleteType(data: {
                                    'action': "DELETE_TYPE",
                                    'id': typeList[index].id
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> showDialogStyle({
    required BuildContext context,
    Type? data,
    required String state,
  }) async {
    return showDialog(
        context: context,
        builder: (context) {
          final typeProvider = Provider.of<ApiProvider>(context);

          TextEditingController titlecontroller = TextEditingController();

          if (data != null) {
            titlecontroller.text = data.typeName;
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
                    "$state Type",
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
              ]),
            ),
            content: SizedBox(
              width: 400.w,
              // height: 300.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyTextField(
                        hintText: "Slider Title",
                        prefixicon: Icons.title_outlined,
                        controller: titlecontroller),
                    GestureDetector(
                        onTap: () {
                          if (state == 'Add') {
                            //ToDo:
                            print(typeProvider.getCategoryId);
                            typeProvider.addType(data: {
                              'action': 'ADD_TYPE',
                              'title': titlecontroller.text,
                              'categoryId': typeProvider.getCategoryId,
                            });

                            Get.back();
                          } else {
                            typeProvider.updateType(data: {
                              "action": 'UPDATE_TYPE',
                              'title': titlecontroller.text,
                              'id': data!.id,
                            });
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
