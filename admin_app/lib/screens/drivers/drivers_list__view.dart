import 'package:adminapp/components/empty_page_widget.dart';
import 'package:adminapp/components/loading_widget.dart';
import 'package:adminapp/constants.dart';
import 'package:adminapp/models/driver_model.dart';
import 'package:adminapp/services/driver_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DriversListView extends StatefulWidget {
  const DriversListView({Key? key}) : super(key: key);

  @override
  State<DriversListView> createState() => _DriversListViewState();
}

class _DriversListViewState extends State<DriversListView> {
  getmessage() {
    FirebaseMessaging.onMessage.listen((event) {
      print("============================");
      print(event.notification!.title.toString());
      print(event.notification!.title.toString());
    });
  }

  @override
  void initState() {
    getmessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drivers"),
        centerTitle: true,
        toolbarHeight: 50.h,
        actions: [
          GestureDetector(
            onTap: () {
              driverProvider.showDialogStyle(context: context, state: "Add");
            },
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Icon(
                Icons.add,
                color: kWhiteColor,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: driverProvider.allDrivers(),
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
                    errorText: "Check your internet and Try again",
                    imageUrl: "images/serviceError.png");
              }

              if (snapshot.data!.docs.isEmpty) {
                return EmptyPageWidget(
                    errorText: "empty", imageUrl: "images/box.png");
              }
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot driver = snapshot.data!.docs[index];
                  return Card(
                    child: ListTile(
                        title: Text(driver['fullName'].toString()),
                        leading: const Icon(
                          Icons.person,
                          size: 40,
                        ),
                        subtitle: Text(driver['phoneNumber'].toString()),
                        trailing: PopupMenuButton(
                            onSelected: (int id) {
                              if (id == 1) {
                                print(driver.id);
                                driverProvider.showDialogStyle(
                                  context: context,
                                  state: 'update',
                                  data: DriverModel(
                                      fullName: driver['fullName'].toString(),
                                      phoneNumber:
                                          driver['phoneNumber'].toString(),
                                      age: driver['age']),
                                  driverId: driver.id,
                                );
                              } else {
                                print("delete");
                                driverProvider.deleteDriverInfo(driver.id);
                              }
                            },
                            itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text("delete"),
                                  )
                                ])),
                  );
                },
              );
            },
          )
        ],
      )),
    );
  }
}
