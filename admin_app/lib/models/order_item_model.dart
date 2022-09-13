// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:adminapp/models/product_model.dart';

class OrderItemModel {
  Product product;
  int? quantity;
  OrderItemModel({
    required this.product,
    this.quantity,
  });

  OrderItemModel copyWith({
    Product? product,
    int? quantity,
  }) {
    return OrderItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderItemModel(product: $product, quantity: $quantity)';

  @override
  bool operator ==(covariant OrderItemModel other) {
    if (identical(this, other)) return true;

    return other.product == product && other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;
}
