import 'dart:convert';

import 'package:flutter/foundation.dart';

class TypeModel {
  final List<Type> types;
  TypeModel({
    required this.types,
  });

  TypeModel copyWith({
    List<Type>? types,
  }) {
    return TypeModel(
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'types': types.map((x) => x.toMap()).toList(),
    };
  }

  factory TypeModel.fromMap(Map<String, dynamic> map) {
    return TypeModel(
      types: List<Type>.from(
        (map['types'] as List).map<Type>(
          (x) => Type.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeModel.fromJson(String source) =>
      TypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TypeModel(types: $types)';

  @override
  bool operator ==(covariant TypeModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.types, types);
  }

  @override
  int get hashCode => types.hashCode;
}

class Type {
  final String id;
  final String typeName;
  final String categoryId;
  Type({
    required this.id,
    required this.typeName,
    required this.categoryId,
  });

  Type copyWith({
    String? id,
    String? typeName,
    String? categoryId,
  }) {
    return Type(
      id: id ?? this.id,
      typeName: typeName ?? this.typeName,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'typeName': typeName,
      'categoryId': categoryId,
    };
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      id: map['id'] as String,
      typeName: map['typeName'] as String,
      categoryId: map['categoryId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Type.fromJson(String source) =>
      Type.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Type(id: $id, typeName: $typeName, categoryId: $categoryId)';

  @override
  bool operator ==(covariant Type other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.typeName == typeName &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode => id.hashCode ^ typeName.hashCode ^ categoryId.hashCode;
}
