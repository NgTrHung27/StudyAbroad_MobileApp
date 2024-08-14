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
  String? name;
  DateTime dob;
  String phoneNumber;
  Student student;
  bool isLocked;
  String? error;
  String token;

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
    required this.token,
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
        isLocked: isLocked ?? this.isLocked, token: '',
      );

  factory UserAuthLogin.fromJson(Map<String, dynamic> json) => UserAuthLogin(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        emailVerified: DateTime.parse(json["emailVerified"]),
        name: json["name"],
        dob: DateTime.parse(json["dob"]),
        phoneNumber: json["phoneNumber"],
        student: Student.fromJson(json["student"]),
        isLocked: json["isLocked"], token: '',
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
  List<ScholarshipElement> scholarship;
  String status;
  School school;
  StudentProgram program;

  Student({
    required this.scholarship,
    required this.status,
    required this.school,
    required this.program,
  });

  Student copyWith({
    List<ScholarshipElement>? scholarship,
    String? status,
    School? school,
    StudentProgram? program,
  }) =>
      Student(
        scholarship: scholarship ?? this.scholarship,
        status: status ?? this.status,
        school: school ?? this.school,
        program: program ?? this.program,
      );

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        scholarship: List<ScholarshipElement>.from(
            json["scholarship"].map((x) => ScholarshipElement.fromJson(x))),
        status: json["status"],
        school: School.fromJson(json["school"]),
        program: StudentProgram.fromJson(json["program"]),
      );

  Map<String, dynamic> toJson() => {
        "scholarship": List<dynamic>.from(scholarship.map((x) => x.toJson())),
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

class ScholarshipElement {
  String id;
  String studentId;
  String scholarshipId;
  DateTime createdAt;
  DateTime updatedAt;
  ScholarshipScholarship scholarship;

  ScholarshipElement({
    required this.id,
    required this.studentId,
    required this.scholarshipId,
    required this.createdAt,
    required this.updatedAt,
    required this.scholarship,
  });

  ScholarshipElement copyWith({
    String? id,
    String? studentId,
    String? scholarshipId,
    DateTime? createdAt,
    DateTime? updatedAt,
    ScholarshipScholarship? scholarship,
  }) =>
      ScholarshipElement(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        scholarshipId: scholarshipId ?? this.scholarshipId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        scholarship: scholarship ?? this.scholarship,
      );

  factory ScholarshipElement.fromJson(Map<String, dynamic> json) =>
      ScholarshipElement(
        id: json["id"],
        studentId: json["studentId"],
        scholarshipId: json["scholarshipId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        scholarship: ScholarshipScholarship.fromJson(json["scholarship"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentId": studentId,
        "scholarshipId": scholarshipId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "scholarship": scholarship.toJson(),
      };
}

class ScholarshipScholarship {
  String id;
  String name;
  String description;
  String cover;
  bool isPublished;
  String schoolId;
  DateTime createdAt;
  DateTime updatedAt;

  ScholarshipScholarship({
    required this.id,
    required this.name,
    required this.description,
    required this.cover,
    required this.isPublished,
    required this.schoolId,
    required this.createdAt,
    required this.updatedAt,
  });

  ScholarshipScholarship copyWith({
    String? id,
    String? name,
    String? description,
    String? cover,
    bool? isPublished,
    String? schoolId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ScholarshipScholarship(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        cover: cover ?? this.cover,
        isPublished: isPublished ?? this.isPublished,
        schoolId: schoolId ?? this.schoolId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ScholarshipScholarship.fromJson(Map<String, dynamic> json) =>
      ScholarshipScholarship(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        cover: json["cover"],
        isPublished: json["isPublished"],
        schoolId: json["schoolId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "cover": cover,
        "isPublished": isPublished,
        "schoolId": schoolId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class School {
  String name;
  String logo;
  String background;

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
        name: json["name"],
        logo: json["logo"],
        background: json["background"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "background": background,
      };
}
