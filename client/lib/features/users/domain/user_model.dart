import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String email;
  final String password;
  final List<String> permissions;

  const UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.permissions,
  });

  String get permissionsString => permissions.join(",");
  String get hashedPassword => generateMd5(password);

  static List<String> allPermissions = [
    "all",
    "requests",
    "appointments",
  ];

  static String generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return digest.toString();
  }

  @override
  List<Object?> get props => [id, email, password, permissions];

  @override
  bool get stringify => true;

  // to map and from map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'permissions': permissions,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
      permissions: List<String>.from(map['permissions'] as List),
    );
  }

  // to json and from json
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  static List<UserModel> serverResponseData = [
    const UserModel(
      id: 1,
      email: "aymendenoub@gmail.com",
      password: "123456",
      permissions: ["all"],
    ),
    const UserModel(
      id: 5,
      email: "mohflitit@gmail.com",
      password: "111111",
      permissions: ["requests", "appointments"],
    ),
  ];
}
