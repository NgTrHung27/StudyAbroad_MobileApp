// To parse this JSON data, do
//
//     final schools = schoolsFromJson(jsonString);

import 'dart:convert';

List<Schools> schoolsFromJson(String str) =>
    List<Schools>.from(json.decode(str).map((x) => Schools.fromJson(x)));

String schoolsToJson(List<Schools> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Schools {
  String id;
  String logo;
  String background;
  String name;
  String short;
  String? description;
  String? history;
  String color;
  bool isPublished;
  String country;
  DateTime createdAt;
  DateTime updatedAt;
  List<News> news;
  List<Gallery> galleries;
  List<Location> locations;
  List<Program> programs;
  List<Scholarship> scholarships;

  Schools({
    required this.id,
    required this.logo,
    required this.background,
    required this.name,
    required this.short,
    required this.description,
    required this.history,
    required this.color,
    required this.isPublished,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
    required this.news,
    required this.galleries,
    required this.locations,
    required this.programs,
    required this.scholarships,
  });

  factory Schools.fromJson(Map<String, dynamic> json) => Schools(
        id: json["id"],
        logo: json["logo"],
        background: json["background"],
        name: json["name"],
        short: json["short"],
        description: json["description"],
        history: json["history"],
        color: json["color"],
        isPublished: json["isPublished"],
        country: json["country"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
        galleries: List<Gallery>.from(
            json["galleries"].map((x) => Gallery.fromJson(x))),
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        programs: List<Program>.from(
            json["programs"].map((x) => Program.fromJson(x))),
        scholarships: List<Scholarship>.from(
            json["scholarships"].map((x) => Scholarship.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "background": background,
        "name": name,
        "short": short,
        "description": description,
        "history": history,
        "color": color,
        "isPublished": isPublished,
        "country": country,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
        "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "programs": List<dynamic>.from(programs.map((x) => x.toJson())),
        "scholarships": List<dynamic>.from(scholarships.map((x) => x.toJson())),
      };
}

class Gallery {
  String id;
  String name;
  String description;
  String schoolId;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> images;

  Gallery({
    required this.id,
    required this.name,
    required this.description,
    required this.schoolId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        schoolId: json["schoolId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<dynamic>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "schoolId": schoolId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}

class Location {
  Id id;
  String cover;
  String name;
  String address;
  bool isMain;
  String schoolId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Contact> contacts;
  List<ImageLoca> images;

  Location({
    required this.id,
    required this.cover,
    required this.name,
    required this.address,
    required this.isMain,
    required this.schoolId,
    required this.createdAt,
    required this.updatedAt,
    required this.contacts,
    required this.images,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: idValues.map[json["id"]]!,
        cover: json["cover"],
        name: json["name"],
        address: json["address"],
        isMain: json["isMain"],
        schoolId: json["schoolId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        contacts: List<Contact>.from(
            json["contacts"].map((x) => Contact.fromJson(x))),
        images: List<ImageLoca>.from(
            json["images"].map((x) => ImageLoca.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "cover": cover,
        "name": name,
        "address": address,
        "isMain": isMain,
        "schoolId": schoolId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Contact {
  String id;
  String phone;
  String? hours;
  dynamic fax;
  dynamic email;
  dynamic url;
  Id locationId;
  DateTime createdAt;
  DateTime updatedAt;

  Contact({
    required this.id,
    required this.phone,
    required this.hours,
    required this.fax,
    required this.email,
    required this.url,
    required this.locationId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        phone: json["phone"],
        hours: json["hours"],
        fax: json["fax"],
        email: json["email"],
        url: json["url"],
        locationId: idValues.map[json["locationId"]]!,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "hours": hours,
        "fax": fax,
        "email": email,
        "url": url,
        "locationId": idValues.reverse[locationId],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

enum Id {
  CLZ7_R9_S5_B0002_KG5_K0_QW5_KO02,
  CLZ7_R9_S5_K0004_KG5_K462_FCTIQ,
  CLZ7_R9_S910006_KG5_KQBA1_U3_DL,
  CLZ7_R9_S9_J0008_KG5_KWJ813_F7_V
}

final idValues = EnumValues({
  "clz7r9s5b0002kg5k0qw5ko02": Id.CLZ7_R9_S5_B0002_KG5_K0_QW5_KO02,
  "clz7r9s5k0004kg5k462fctiq": Id.CLZ7_R9_S5_K0004_KG5_K462_FCTIQ,
  "clz7r9s910006kg5kqba1u3dl": Id.CLZ7_R9_S910006_KG5_KQBA1_U3_DL,
  "clz7r9s9j0008kg5kwj813f7v": Id.CLZ7_R9_S9_J0008_KG5_KWJ813_F7_V
});

class ImageLoca {
  String id;
  String url;
  Id locationId;

  ImageLoca({
    required this.id,
    required this.url,
    required this.locationId,
  });

  factory ImageLoca.fromJson(Map<String, dynamic> json) => ImageLoca(
        id: json["id"],
        url: json["url"],
        locationId: idValues.map[json["locationId"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "locationId": idValues.reverse[locationId],
      };
}

class News {
  String id;
  String title;
  String content;
  String type;
  String cover;
  bool isPublished;
  String schoolId;
  DateTime createdAt;
  DateTime updatedAt;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.cover,
    required this.isPublished,
    required this.schoolId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        type: json["type"],
        cover: json["cover"],
        isPublished: json["isPublished"],
        schoolId: json["schoolId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "type": type,
        "cover": cover,
        "isPublished": isPublished,
        "schoolId": schoolId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Program {
  String id;
  String name;
  String description;
  String? cover; // Có thể là null
  bool isPublished;
  String schoolId;
  DateTime createdAt;
  DateTime updatedAt;
  List<StudentProgram>? studentPrograms;
  List<dynamic>? images;
  List<dynamic>? owners;

  Program({
    required this.id,
    required this.name,
    required this.description,
    required this.cover,
    required this.isPublished,
    required this.schoolId,
    required this.createdAt,
    required this.updatedAt,
    this.studentPrograms,
    this.images,
    this.owners,
  });

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        cover: json["cover"] ?? '', // Cung cấp giá trị mặc định nếu cover null
        isPublished: json["isPublished"],
        schoolId: json["schoolId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        studentPrograms: json["studentPrograms"] == null
            ? []
            : List<StudentProgram>.from(json["studentPrograms"]!
                .map((x) => StudentProgram.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        owners: json["owners"] == null
            ? []
            : List<dynamic>.from(json["owners"]!.map((x) => x)),
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
        "studentPrograms": studentPrograms == null
            ? []
            : List<dynamic>.from(studentPrograms!.map((x) => x.toJson())),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "owners":
            owners == null ? [] : List<dynamic>.from(owners!.map((x) => x)),
      };
}

class StudentProgram {
  Student student;

  StudentProgram({
    required this.student,
  });

  factory StudentProgram.fromJson(Map<String, dynamic> json) => StudentProgram(
        student: Student.fromJson(json["student"]),
      );

  Map<String, dynamic> toJson() => {
        "student": student.toJson(),
      };
}

class Student {
  String id;
  String? studentCode;
  Account account;
  String? cover;
  String degreeType;
  String certificateType;
  String gradeType;
  double gradeScore;
  String status;

  Student({
    required this.id,
    required this.studentCode,
    required this.account,
    required this.cover,
    required this.degreeType,
    required this.certificateType,
    required this.gradeType,
    required this.gradeScore,
    required this.status,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        studentCode: json["studentCode"],
        account: Account.fromJson(json["account"]),
        cover: json["cover"],
        degreeType: json["degreeType"],
        certificateType: json["certificateType"],
        gradeType: json["gradeType"],
        gradeScore: json["gradeScore"]?.toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentCode": studentCode,
        "account": account.toJson(),
        "cover": cover,
        "degreeType": degreeType,
        "certificateType": certificateType,
        "gradeType": gradeType,
        "gradeScore": gradeScore,
        "status": status,
      };
}

class Account {
  String name;

  Account({
    required this.name,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Scholarship {
  String id;
  String name;
  String description;
  String cover;
  bool isPublished;
  String schoolId;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> images;
  List<dynamic> owners;
  School school;

  Scholarship({
    required this.id,
    required this.name,
    required this.description,
    required this.cover,
    required this.isPublished,
    required this.schoolId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.owners,
    required this.school,
  });

  factory Scholarship.fromJson(Map<String, dynamic> json) => Scholarship(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        cover: json["cover"],
        isPublished: json["isPublished"],
        schoolId: json["schoolId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<dynamic>.from(json["images"].map((x) => x)),
        owners: List<dynamic>.from(json["owners"].map((x) => x)),
        school: School.fromJson(json["school"]),
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
        "images": List<dynamic>.from(images.map((x) => x)),
        "owners": List<dynamic>.from(owners.map((x) => x)),
        "school": school.toJson(),
      };
}

class School {
  String id;
  String logo;
  String background;
  String name;
  String short;
  dynamic description;
  dynamic history;
  String color;
  bool isPublished;
  String country;
  DateTime createdAt;
  DateTime updatedAt;

  School({
    required this.id,
    required this.logo,
    required this.background,
    required this.name,
    required this.short,
    required this.description,
    required this.history,
    required this.color,
    required this.isPublished,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        logo: json["logo"],
        background: json["background"],
        name: json["name"],
        short: json["short"],
        description: json["description"],
        history: json["history"],
        color: json["color"],
        isPublished: json["isPublished"],
        country: json["country"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "background": background,
        "name": name,
        "short": short,
        "description": description,
        "history": history,
        "color": color,
        "isPublished": isPublished,
        "country": country,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
