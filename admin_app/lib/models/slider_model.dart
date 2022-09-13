import 'dart:convert';

import 'package:flutter/foundation.dart';

class SliderModel {
  final List<SliderData> slider;
  SliderModel({
    required this.slider,
  });

  SliderModel copyWith({
    List<SliderData>? slider,
  }) {
    return SliderModel(
      slider: slider ?? this.slider,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slider': slider.map((x) => x.toMap()).toList(),
    };
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      slider: List<SliderData>.from(
        (map['slider'] as List).map<SliderData>(
          (x) => SliderData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderModel.fromJson(String source) =>
      SliderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SliderModel(slider: $slider)';

  @override
  bool operator ==(covariant SliderModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.slider, slider);
  }

  @override
  int get hashCode => slider.hashCode;
}

class SliderData {
  final String id;
  final String title;
  final String imageurl;
  final String showToUser;
  SliderData({
    required this.id,
    required this.title,
    required this.imageurl,
    required this.showToUser,
  });

  SliderData copyWith({
    String? id,
    String? title,
    String? imageurl,
    String? showToUser,
  }) {
    return SliderData(
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

  factory SliderData.fromMap(Map<String, dynamic> map) {
    return SliderData(
      id: map['id'] as String,
      title: map['title'] as String,
      imageurl: map['imageurl'] as String,
      showToUser: map['showToUser'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderData.fromJson(String source) =>
      SliderData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Slider(id: $id, title: $title, imageurl: $imageurl, showToUser: $showToUser)';
  }

  @override
  bool operator ==(covariant SliderData other) {
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
