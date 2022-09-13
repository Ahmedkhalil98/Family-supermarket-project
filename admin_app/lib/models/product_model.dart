import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductsModel {
  final List<Product> products;
  ProductsModel({
    required this.products,
  });

  ProductsModel copyWith({
    List<Product>? products,
  }) {
    return ProductsModel(
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      products: List<Product>.from(
        (map['products'] as List).map<Product>(
          (x) => Product.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsModel.fromJson(String source) =>
      ProductsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductsModel(products: $products)';

  @override
  bool operator ==(covariant ProductsModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.products, products);
  }

  @override
  int get hashCode => products.hashCode;
}

class Product {
  final String id;
  final String title;
  final String imageurl;
  final String price;
  final String unit;
  final String unitsize;
  Product({
    required this.id,
    required this.title,
    required this.imageurl,
    required this.price,
    required this.unit,
    required this.unitsize,
  });

  Product copyWith({
    String? id,
    String? title,
    String? imageurl,
    String? price,
    String? unit,
    String? unitsize,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      imageurl: imageurl ?? this.imageurl,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      unitsize: unitsize ?? this.unitsize,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageurl': imageurl,
      'price': price,
      'unit': unit,
      'unitsize': unitsize,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      title: map['title'] as String,
      imageurl: map['imageurl'] as String,
      price: map['price'] as String,
      unit: map['unit'] as String,
      unitsize: map['unitsize'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, title: $title, imageurl: $imageurl, price: $price, unit: $unit, unitsize: $unitsize)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.imageurl == imageurl &&
        other.price == price &&
        other.unit == unit &&
        other.unitsize == unitsize;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageurl.hashCode ^
        price.hashCode ^
        unit.hashCode ^
        unitsize.hashCode;
  }
}
