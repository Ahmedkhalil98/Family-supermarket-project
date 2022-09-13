import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrdersModel {
  final List<Order> orders;
  OrdersModel({
    required this.orders,
  });

  OrdersModel copyWith({
    List<Order>? orders,
  }) {
    return OrdersModel(
      orders: orders ?? this.orders,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orders': orders.map((x) => x.toMap()).toList(),
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      orders: List<Order>.from(
        (map['orders'] as List).map<Order>(
          (x) => Order.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdersModel.fromJson(String source) =>
      OrdersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrdersModel(orders: $orders)';

  @override
  bool operator ==(covariant OrdersModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.orders, orders);
  }

  @override
  int get hashCode => orders.hashCode;
}

class Order {
  final String passcode;
  final String orderItems;
  final String userLocation;
  final String userId;
  final String userLatLng;
  final String userPhone;
  final String dateTime;
  final String state;
  Order({
    required this.passcode,
    required this.orderItems,
    required this.userLocation,
    required this.userId,
    required this.userLatLng,
    required this.userPhone,
    required this.dateTime,
    required this.state,
  });

  Order copyWith({
    String? passcode,
    String? orderItems,
    String? userLocation,
    String? userId,
    String? userLatLng,
    String? userPhone,
    String? dateTime,
    String? state,
  }) {
    return Order(
      passcode: passcode ?? this.passcode,
      orderItems: orderItems ?? this.orderItems,
      userLocation: userLocation ?? this.userLocation,
      userId: userId ?? this.userId,
      userLatLng: userLatLng ?? this.userLatLng,
      userPhone: userPhone ?? this.userPhone,
      dateTime: dateTime ?? this.dateTime,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'passcode': passcode,
      'orderItems': orderItems,
      'userLocation': userLocation,
      'userId': userId,
      'userLatLng': userLatLng,
      'userPhone': userPhone,
      'dateTime': dateTime,
      'state': state,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      passcode: map['passcode'] as String,
      orderItems: map['orderItems'] as String,
      userLocation: map['userLocation'] as String,
      userId: map['userId'] as String,
      userLatLng: map['userLatLng'] as String,
      userPhone: map['userPhone'] as String,
      dateTime: map['dateTime'] as String,
      state: map['state'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(passcode: $passcode, orderItems: $orderItems, userLocation: $userLocation, userId: $userId, userLatLng: $userLatLng, userPhone: $userPhone, dateTime: $dateTime, state: $state)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.passcode == passcode &&
        other.orderItems == orderItems &&
        other.userLocation == userLocation &&
        other.userId == userId &&
        other.userLatLng == userLatLng &&
        other.userPhone == userPhone &&
        other.dateTime == dateTime &&
        other.state == state;
  }

  @override
  int get hashCode {
    return passcode.hashCode ^
        orderItems.hashCode ^
        userLocation.hashCode ^
        userId.hashCode ^
        userLatLng.hashCode ^
        userPhone.hashCode ^
        dateTime.hashCode ^
        state.hashCode;
  }
}
