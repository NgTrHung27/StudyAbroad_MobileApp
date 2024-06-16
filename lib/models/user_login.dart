// To parse this JSON data, do
//
//     final userAuthLogin = userAuthLoginFromJson(jsonString);

import 'dart:convert';

UserAuthLogin userAuthLoginFromJson(String str) =>
    UserAuthLogin.fromJson(json.decode(str));

String userAuthLoginToJson(UserAuthLogin data) => json.encode(data.toJson());

class UserAuthLogin {
  String id;
  String email;
  String password;
  DateTime emailVerified;
  String name;
  DateTime dob;
  String phoneNumber;
  Student student;
  bool isLocked;
  String? error;

  UserAuthLogin({
    required this.id,
    required this.email,
    required this.password,
    required this.emailVerified,
    required this.name,
    required this.dob,
    required this.phoneNumber,
    required this.student,
    required this.isLocked,
  });

  UserAuthLogin copyWith({
    String? id,
    String? email,
    String? password,
    DateTime? emailVerified,
    String? name,
    DateTime? dob,
    String? phoneNumber,
    Student? student,
    bool? isLocked,
  }) =>
      UserAuthLogin(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        emailVerified: emailVerified ?? this.emailVerified,
        name: name ?? this.name,
        dob: dob ?? this.dob,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        student: student ?? this.student,
        isLocked: isLocked ?? this.isLocked,
      );

  factory UserAuthLogin.fromJson(Map<String, dynamic> json) => UserAuthLogin(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        emailVerified: DateTime.parse(json["emailVerified"]),
        name: json["name"],
        dob: DateTime.parse(json["dob"]),
        phoneNumber: json["phoneNumber"],
        student: Student.fromJson(json['student']),
        isLocked: json["isLocked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "emailVerified": emailVerified.toIso8601String(),
        "name": name,
        "dob": dob.toIso8601String(),
        "phoneNumber": phoneNumber,
        "student": student.toJson(),
        "isLocked": isLocked,
      };
}

class Student {
  String? status;
  School school;
  StudentProgram program;

  Student({
    required this.status,
    required this.school,
    required this.program,
  });

  Student copyWith({
    String? status,
    School? school,
    StudentProgram? program,
  }) =>
      Student(
        status: status ?? this.status,
        school: school ?? this.school,
        program: program ?? this.program,
      );

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        status: json["status"],
        school: School.fromJson(json['school']),
        program: StudentProgram.fromJson(json["program"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "school": school.toJson(),
        "program": program.toJson(),
      };
}

class StudentProgram {
  ProgramProgram program;

  StudentProgram({
    required this.program,
  });

  StudentProgram copyWith({
    ProgramProgram? program,
  }) =>
      StudentProgram(
        program: program ?? this.program,
      );

  factory StudentProgram.fromJson(Map<String, dynamic> json) => StudentProgram(
        program: ProgramProgram.fromJson(json["program"]),
      );

  Map<String, dynamic> toJson() => {
        "program": program.toJson(),
      };
}

class ProgramProgram {
  String name;

  ProgramProgram({
    required this.name,
  });

  ProgramProgram copyWith({
    String? name,
  }) =>
      ProgramProgram(
        name: name ?? this.name,
      );

  factory ProgramProgram.fromJson(Map<String, dynamic> json) => ProgramProgram(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class School {
  String name;
  String? logo;
  String? background;

  School({
    required this.name,
    required this.logo,
    required this.background,
  });

  School copyWith({
    String? name,
    String? logo,
    String? background,
  }) =>
      School(
        name: name ?? this.name,
        logo: logo ?? this.logo,
        background: background ?? this.background,
      );

  factory School.fromJson(Map<String, dynamic> json) => School(
        name: json['name'],
        logo: json['logo'],
        background: json['background'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "background": background,
      };
}
