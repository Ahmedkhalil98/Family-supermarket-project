import 'dart:convert';
import 'dart:io';

import 'package:adminapp/models/category_model.dart';
import 'package:adminapp/models/product_model.dart';
import 'package:adminapp/models/type_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:path/path.dart';

class ApiProvider extends ChangeNotifier {
  Uri url =
      Uri.parse("https://family-supermarket.000webhostapp.com/user_action.php");
  Uri adminUrl = Uri.parse(
      "https://family-supermarket.000webhostapp.com/admin_action.php");
  static const _getCategories = 'GET_ALL_CATEGORIES';
  static const _getTypes = 'GET_TYPES';
  static const _getProducts = 'GET_PRODUCTS';

  //get all Categories
  Future<CategoriesModel> getCategories() async {
    Map<String, dynamic> data = {'action': _getCategories};
    http.Response response = await http.post(url, body: data);
    CategoriesModel responseBody = CategoriesModel.fromJson(response.body);
    return responseBody;
  }

//add Category to DB
  Future addCategory({required File file, required Map data}) async {
    var request = http.MultipartRequest("POST", adminUrl);
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

  //update single Category
  Future updateCategory({required Map data}) async {
    http.Response response = await http.post(adminUrl, body: data);
    var responseBody = jsonDecode(response.body);
    notifyListeners();
    return responseBody;
  }

//delete single Category
  Future deleteCategory(
      {required String sliderId, required String imageName}) async {
    Map<String, dynamic> data = {
      'action': "DELETE_CATEGORY",
      'id': sliderId,
      'imageName': imageName
    };
    http.Response response = await http.post(adminUrl, body: data);
    final responseBody = jsonDecode(response.body);
    notifyListeners();
    return responseBody;
  }

//function for get all type of one category
  String? _categoryId;
  String? _categoryTitle;

  set setCatId(String catId) {
    _categoryId = catId;
  }

  set setCatTitle(String catName) {
    _categoryTitle = catName;
  }

  get getCategoryTitle {
    return _categoryTitle;
  }

  get getCategoryId {
    return _categoryId;
  }

  Future<TypeModel> getTypes() async {
    Map<String, dynamic> data = {
      'action': _getTypes,
      'categoryId': _categoryId,
    };
    http.Response response = await http.post(url, body: data);
    TypeModel responseBody = TypeModel.fromJson(response.body);
    return responseBody;
  }

// add Type to DB
  Future addType({required Map data}) async {
    http.Response response = await http.post(adminUrl, body: data);
    var responseBody = jsonDecode(response.body);
    notifyListeners();
    return responseBody;
  }

  // add Type to DB
  Future updateType({required Map data}) async {
    http.Response response = await http.post(adminUrl, body: data);
    var responseBody = jsonDecode(response.body);
    notifyListeners();
    return responseBody;
  }

  // delete Type to DB
  Future deleteType({required Map data}) async {
    http.Response response = await http.post(adminUrl, body: data);
    var responseBody = jsonDecode(response.body);
    notifyListeners();
    return responseBody;
  }

  //function for get products
  String? _typeId;
  String? _typeName;

  set setTypeId(String tId) {
    _typeId = tId;
  }

  set setTypeName(String typeName) {
    _typeName = typeName;
  }

  get getTypeId {
    return _typeId;
  }

  get getTypeName {
    return _typeName;
  }

//list of products
  Future<ProductsModel> getProducts() async {
    Map<String, dynamic> data = {
      'action': _getProducts,
      'typeId': _typeId,
    };
    http.Response response = await http.post(url, body: data);
    ProductsModel responseBody = ProductsModel.fromJson(response.body);
    return responseBody;
  }

//add new products
  Future addProducts({required File file, required Map data}) async {
    var request = http.MultipartRequest("POST", adminUrl);
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

  //update  Products
  Future updateProducts({required Map data}) async {
    http.Response response = await http.post(adminUrl, body: data);
    var responseBody = jsonDecode(response.body);
    notifyListeners();
    return responseBody;
  }

//delete Products
  Future deleteProducts(
      {required String sliderId, required String imageName}) async {
    Map<String, dynamic> data = {
      'action': "DELETE_PRODUCT",
      'id': sliderId,
      'imageName': imageName
    };
    http.Response response = await http.post(adminUrl, body: data);
    final responseBody = jsonDecode(response.body);
    notifyListeners();
    return responseBody;
  }
}
