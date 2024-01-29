import 'dart:convert';

import 'package:equatable/equatable.dart';

class RequestModel extends Equatable {
  final int id;
  final int patientId;
  final DateTime date;
  final String patientStatus;
  final String message;
  final String requestStatus;

  const RequestModel({
    required this.id,
    required this.patientId,
    required this.date,
    required this.patientStatus,
    required this.message,
    required this.requestStatus,
  });

  @override
  List<Object?> get props => [
        id,
        patientId,
        date,
        patientStatus,
        message,
        requestStatus,
      ];

  @override
  bool get stringify => true;

  // to map and from map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientId': patientId,
      'date': date.millisecondsSinceEpoch,
      'patientStatus': patientStatus,
      'message': message,
      'requestStatus': requestStatus,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'] as int,
      patientId: map['patientId'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      patientStatus: map['patientStatus'] as String,
      message: map['message'] as String,
      requestStatus: map['requestStatus'] as String,
    );
  }

  // to json and from json
  factory RequestModel.fromJson(String source) =>
      RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  static List<RequestModel> serverResponseData = [
    RequestModel(
      id: 12,
      patientId: 8,
      date: DateTime.now(),
      patientStatus: "Normal",
      message: "Message",
      requestStatus: "Pending",
    ),
    RequestModel(
      id: 55,
      patientId: 9,
      date: DateTime.parse('2024-01-28'),
      patientStatus: "Critical",
      message: "Test Test",
      requestStatus: "Pending",
    ),
  ];
}
