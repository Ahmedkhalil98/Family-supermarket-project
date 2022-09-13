import 'package:adminapp/components/app_bar_widget.dart';
import 'package:adminapp/components/empty_page_widget.dart';
import 'package:adminapp/components/loading_widget.dart';
import 'package:adminapp/constants.dart';
import 'package:adminapp/services/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({Key? key}) : super(key: key);

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  UserProvider userProvider = UserProvider();
  @override
  void initState() {
    userProvider.conut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: MyAppBar(pageTitle: "Users"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: userProvider.allUser(),
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
                List<QueryDocumentSnapshot<Map<String, dynamic>>> users =
                    snapshot.data!.docs;
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.w),
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total Users : ",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            users.length.toString(),
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                                users[index].data()['fullName'].toString()),
                            leading: const Icon(
                              Icons.person,
                              size: 40,
                            ),
                            subtitle: Text(
                                users[index].data()['phoneNumber'].toString()),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
