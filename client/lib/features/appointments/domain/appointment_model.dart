import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppointmentModel extends Equatable {
  final int id;
  final String fullName;
  final DateTime date;
  final String patientStatus;
  final int age;
  final String email;

  const AppointmentModel({
    required this.id,
    required this.fullName,
    required this.date,
    required this.patientStatus,
    required this.age,
    required this.email,
  });

  @override
  List<Object?> get props => [id, fullName, date, patientStatus, age, email];

  @override
  bool get stringify => true;

  // to map and from map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'date': date.millisecondsSinceEpoch,
      'patientStatus': patientStatus,
      'age': age,
      'email': email,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      patientStatus: map['patientStatus'] as String,
      age: map['age'] as int,
      email: map['email'] as String,
    );
  }

  // to json and from json
  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  static List<AppointmentModel> serverResponseData = [
    AppointmentModel(
      id: 1,
      fullName: "Aymen Denoub",
      date: DateTime.parse("2024-01-28"),
      patientStatus: "Normal",
      age: 20,
      email: 'aymendenoub@gmail.com',
    ),
  ];
}
