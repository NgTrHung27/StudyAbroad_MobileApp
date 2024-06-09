import 'dart:convert';

import 'package:kltn_mobile/models/student.dart';

class UserAuthLogin {
  String? id;
  String? name;
  String? email;
  DateTime? emailVerified;
  String? password;
  DateTime? dob;
  String? phoneNumber;
  bool? isLocked;
  Student? student;
  String? error;

  UserAuthLogin({
    this.id,
    this.name,
    this.email,
    this.emailVerified,
    this.password,
    this.dob,
    this.phoneNumber,
    this.isLocked,
    this.student,
    this.error,
  });

    factory UserAuthLogin.fromJson(Map<String, dynamic> json) {
    return UserAuthLogin(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerified: json['emailVerified'] != null ? DateTime.parse(json['emailVerified']) : null,
      password: json['password'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      phoneNumber: json['phoneNumber'],
      isLocked: json['isLocked'],
      student: json['student'] != null ? Student.fromJson(json['student']) : null,
      error: json.containsKey('error') ? json['error'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'emailVerified': emailVerified?.toIso8601String(),
      'password': password,
      'dob': dob?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'isLocked': isLocked,
      'student': student?.toJson(),
    };
  }

  static List<UserAuthLogin> parseList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserAuthLogin>((json) => UserAuthLogin.fromJson(json))
        .toList();
  }
}