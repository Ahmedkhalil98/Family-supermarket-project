import 'package:adminapp/components/submit_button_widget.dart';
import 'package:adminapp/components/text_field_widget.dart';
import 'package:adminapp/constants.dart';
import 'package:adminapp/models/driver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DriverProvider extends ChangeNotifier {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> allDrivers() {
    return _fireStore.collection("drivers").snapshots();
  }

  Future addDriverAccount(DriverModel data) async {
    await _fireStore.collection('drivers').add(data.toMap());
  }

  Future updateDriverInfo(DriverModel data, String id) async {
    await _fireStore.collection('drivers').doc(id).update(data.toMap());
  }

  Future<void> deleteDriverInfo(String id) async {
    await _fireStore.collection("drivers").doc(id).delete();
  }

  //show dialog view
  Future<dynamic> showDialogStyle({
    required BuildContext context,
    DriverModel? data,
    String? driverId,
    required String state,
  }) async {
    return showDialog(
        context: context,
        builder: (context) {
          TextEditingController fullNameController = TextEditingController();
          TextEditingController phoneNumberController = TextEditingController();
          TextEditingController ageController = TextEditingController();
          if (data != null) {
            fullNameController.text = data.fullName;
            phoneNumberController.text = data.phoneNumber;
            ageController.text = data.age.toString();
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
                    "$state Driver",
                    style: TextStyle(color: kWhiteColor),
                  ),
                ),
              ]),
            ),
            content: SizedBox(
              width: 400.w,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyTextField(
                        hintText: "Full Name",
                        prefixicon: Icons.person,
                        controller: fullNameController),
                    MyTextField(
                        hintText: "Phone Number",
                        prefixicon: Icons.phone,
                        controller: phoneNumberController),
                    MyTextField(
                        hintText: "Age",
                        prefixicon: Icons.numbers,
                        controller: ageController),
                    GestureDetector(
                        onTap: () {
                          DriverModel driverData = DriverModel(
                            fullName: fullNameController.text,
                            phoneNumber: phoneNumberController.text,
                            age: int.parse(ageController.text),
                          );
                          if (state == 'Add') {
                            addDriverAccount(driverData);

                            Get.back();
                          } else {
                            updateDriverInfo(driverData, driverId!);

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
