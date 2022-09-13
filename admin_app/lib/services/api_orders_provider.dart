import 'dart:convert';
import 'package:adminapp/constants.dart';
import 'package:adminapp/models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiOrders extends ChangeNotifier {
  Uri url =
      Uri.parse("https://family-supermarket.000webhostapp.com/order_data.php");
  //get all orders
  Future<OrdersModel> getOrders() async {
    Map<String, dynamic> data = {'action': 'GET_ORDERS'};
    http.Response response = await http.post(url, body: data);
    OrdersModel responseBody = OrdersModel.fromJson(response.body);

    return responseBody;
  }

// change order state to working
//state available : working / pending / canceled / delivered
  void changeOrderState(String id) async {
    Map<String, dynamic> data = {'action': 'UPDATE_ORDERS', 'id': id};
    http.Response response = await http.post(url, body: data);
    var responseBody = jsonDecode(response.body);
    notifyListeners();
  }

  //delete order
  void deleteOrder(String id) async {
    Map<String, dynamic> data = {'action': 'DELETE_ORDERS', 'id': id};
    http.Response response = await http.post(url, body: data);
    var responseBody = jsonDecode(response.body);
    notifyListeners();
  }

  Order? orderData;

  set setOrderData(Order data) {
    orderData = data;
  }

  Widget stateOfOrders(String state) {
    if (state == 'pending') {
      return Icon(
        Icons.pause_circle,
        size: 30,
        color: kPrimaryColor,
      );
    }
    if (state == 'working') {
      return const Icon(
        Icons.timelapse,
        size: 30,
        color: Colors.blue,
      );
    }
    if (state == 'canceled') {
      return const Icon(
        Icons.cancel,
        size: 30,
        color: Colors.red,
      );
    } else {
      return const Icon(
        Icons.check_circle,
        size: 30,
        color: Colors.green,
      );
    }
  }

  Color? stateColor(String state) {
    if (state == 'pending') {
      return kPrimaryColor;
    }
    if (state == 'working') {
      return Colors.blue;
    }
    if (state == 'canceled') {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}
