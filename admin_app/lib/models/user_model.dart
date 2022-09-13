// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoModel {
  String? fullName;
  String phoneNumber;
  String email;
  String userId;
  String? dateOfRegistration;
  DocumentReference? reference;
  UserInfoModel(
      {this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.userId,
      this.dateOfRegistration,
      this.reference});

  UserInfoModel copyWith({
    String? fullName,
    String? phoneNumber,
    String? email,
    String? userId,
    String? dateOfRegistration,
  }) {
    return UserInfoModel(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      dateOfRegistration: dateOfRegistration ?? this.dateOfRegistration,
    );
  }

  factory UserInfoModel.fromSnapShot(DocumentSnapshot documentSnapshot) {
    return UserInfoModel.fromMap(
        documentSnapshot.data() as Map<String, dynamic>,
        reference: documentSnapshot.reference);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'userId': userId,
      'dateOfRegistration': dateOfRegistration,
      'reference': reference,
    };
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> map,
      {DocumentReference? reference}) {
    return UserInfoModel(
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      userId: map['userId'] as String,
      dateOfRegistration: map['dateOfRegistration'] != null
          ? map['dateOfRegistration'] as String
          : null,
      reference: reference,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfoModel.fromJson(String source) =>
      UserInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInfoModel(fullName: $fullName, phoneNumber: $phoneNumber, email: $email, userId: $userId, dateOfRegistration: $dateOfRegistration)';
  }

  @override
  bool operator ==(covariant UserInfoModel other) {
    if (identical(this, other)) return true;

    return other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.userId == userId &&
        other.dateOfRegistration == dateOfRegistration;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        userId.hashCode ^
        dateOfRegistration.hashCode;
  }
}
