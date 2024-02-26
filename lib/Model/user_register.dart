import 'dart:convert';
import 'package:kltn_mobile/Model/enum.dart';

class UserAuthRegister {
  String? id;
  String? name;
  String? email;
  DateTime? emailVerified;
  String? password;
  String? image;
  String? studentCode;
  DateTime? dob;
  Gender? gender;
  String? phoneNumber;
  String? idCardNumber;
  String? address;
  String? schoolId;
  DegreeType? degreeType;
  CertificateType? certificateType;
  String? certificateImg;
  GradeType? gradeType;
  double? gradeScore;
  bool? isTwoFactorEnabled;
  StudentStatus? studentStatus;

  UserAuthRegister({
    this.id,
    this.name,
    this.email,
    this.emailVerified,
    this.password,
    this.image,
    this.studentCode,
    this.dob,
    this.gender,
    this.phoneNumber,
    this.idCardNumber,
    this.address,
    this.schoolId,
    this.degreeType,
    this.certificateType,
    this.certificateImg,
    this.gradeType,
    this.gradeScore,
    this.isTwoFactorEnabled,
  });

  factory UserAuthRegister.fromJson(Map<String, dynamic> json) {
    return UserAuthRegister(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerified: json['emailVerified'] != null
          ? DateTime.parse(json['emailVerified'])
          : null,
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'emailVerified': emailVerified?.toIso8601String(),
      'password': password,
    };
  }

  static List<UserAuthRegister> parseList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserAuthRegister>((json) => UserAuthRegister.fromJson(json))
        .toList();
  }
}
