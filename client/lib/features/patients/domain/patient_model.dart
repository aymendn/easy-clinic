import 'dart:convert';

import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
  final int id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String address;
  final DateTime birthDate;

  const PatientModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.birthDate,
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        phoneNumber,
        email,
        address,
        birthDate,
      ];

  @override
  bool get stringify => true;

  // to map and from map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'birthDate': birthDate,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      birthDate: map['birthDate'] as DateTime,
    );
  }

  // to json and from json
  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  static List<PatientModel> serverResponseData = [
    PatientModel(
      id: 5,
      fullName: "Aymen Denoub",
      phoneNumber: "055555555",
      email: "aymendenoub@gmail.com",
      address: "Rue Djouabmi Mbarek",
      birthDate: DateTime.parse("1998-05-05"),
    ),
  ];
}
