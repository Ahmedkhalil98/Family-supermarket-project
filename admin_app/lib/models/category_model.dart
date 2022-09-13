import 'dart:convert';
import 'package:flutter/foundation.dart';

class CategoriesModel {
  final List<Category> categories;
  CategoriesModel({
    required this.categories,
  });

  CategoriesModel copyWith({
    List<Category>? categories,
  }) {
    return CategoriesModel(
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      categories: List<Category>.from(
        (map['categories'] as List).map<Category>(
          (x) => Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) =>
      CategoriesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoriesModel(categories: $categories)';

  @override
  bool operator ==(covariant CategoriesModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.categories, categories);
  }

  @override
  int get hashCode => categories.hashCode;
}

class Category {
  final String id;
  final String title;
  final String imageurl;
  final String showToUser;
  Category({
    required this.id,
    required this.title,
    required this.imageurl,
    required this.showToUser,
  });

  Category copyWith({
    String? id,
    String? title,
    String? imageurl,
    String? showToUser,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      imageurl: imageurl ?? this.imageurl,
      showToUser: showToUser ?? this.showToUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageurl': imageurl,
      'showToUser': showToUser,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      title: map['title'] as String,
      imageurl: map['imageurl'] as String,
      showToUser: map['showToUser'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Categorie(id: $id, title: $title, imageurl: $imageurl, showToUser: $showToUser)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.imageurl == imageurl &&
        other.showToUser == showToUser;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageurl.hashCode ^
        showToUser.hashCode;
  }
}
