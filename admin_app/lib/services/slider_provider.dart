import 'dart:convert';
import 'dart:io';
import 'package:adminapp/models/slider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class SliderProvider extends ChangeNotifier {
  Uri url =
      Uri.parse("https://family-supermarket.000webhostapp.com/get_slider.php");
  static const _getSlider = 'GET_SLIDER_ADMIN';
  static const _deleteSlider = 'DELETE_SLIDER';
  static const _hideSlider = 'HIDE_SLIDER';

//get all slider
  Future<SliderModel> getSliderList() async {
    Map<String, dynamic> data = {
      'action': _getSlider,
    };
    http.Response response = await http.post(url, body: data);
    SliderModel responseBody = SliderModel.fromJson(response.body);

    return responseBody;
  }

  //add new slider
  Future addSlider(File file, Map data) async {
    var request = http.MultipartRequest("POST", url);
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());

    var multPartFile = http.MultipartFile('file', stream, length,
        filename: basename(file.path));

    request.files.add(multPartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    var sendRequest = await request.send();
    http.Response response = await http.Response.fromStream(sendRequest);

    if (sendRequest.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      notifyListeners();
      return responseBody;
    } else {
      Get.snackbar("Error", "Try Again");
    }
  }

  //update single slider
  updateSlider({required Map data}) async {
    http.Response response = await http.post(url, body: data);
    var responseBody = jsonDecode(response.body);
    notifyListeners();

    return responseBody;
  }

//delete single slider
  Future deleteSlider(
      {required String sliderId, required String imageName}) async {
    Map<String, dynamic> data = {
      'action': _deleteSlider,
      'sliderId': sliderId,
      'imageName': imageName
    };
    http.Response response = await http.post(url, body: data);
    final responseBody = jsonDecode(response.body);
    notifyListeners();

    return responseBody;
  }

//delete single slider
  Future hideSlider(
      {required String sliderId, required String showToUser}) async {
    String isshow = showToUser;

    if (showToUser == '1') {
      isshow = '0';
    } else {
      isshow = '1';
    }
    Map<String, dynamic> data = {
      'action': _hideSlider,
      'showToUser': isshow,
      'sliderId': sliderId
    };
    http.Response response = await http.post(
      url,
      body: data,
    );
    var responseBody = jsonDecode(response.body);
    notifyListeners();
    return responseBody;
  }
}
