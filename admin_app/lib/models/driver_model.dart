import 'dart:convert';

class DriverModel {
  String fullName;
  String phoneNumber;
  int age;
  DriverModel({
    required this.fullName,
    required this.phoneNumber,
    required this.age,
  });

  DriverModel copyWith({
    String? fullName,
    String? phoneNumber,
    int? age,
  }) {
    return DriverModel(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'age': age,
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      fullName: map['fullName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverModel.fromJson(String source) =>
      DriverModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DriverModel(fullName: $fullName, phoneNumber: $phoneNumber, age: $age)';

  @override
  bool operator ==(covariant DriverModel other) {
    if (identical(this, other)) return true;

    return other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.age == age;
  }

  @override
  int get hashCode => fullName.hashCode ^ phoneNumber.hashCode ^ age.hashCode;
}
