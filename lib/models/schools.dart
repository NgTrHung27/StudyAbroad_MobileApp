// To parse this JSON data, do
//
//     final schools = schoolsFromJson(jsonString);

// ignore_for_file: constant_identifier_names

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
  String? short;
  String? description;
  String? history;
  String color;
  bool isPublished;
  String country;

  List<SchoolLocation> locations;
  List<SchoolProgram> programs;
  List<SchoolGallery>? galleries;
  List<SchoolScholarship>? scholarships;
  List<News>? news;

  DateTime createdAt;
  DateTime updatedAt;

  Schools({
    required this.id,
    required this.logo,
    required this.background,
    required this.name,
    this.short,
    this.description,
    this.history,
    required this.color,
    required this.isPublished,
    required this.country,
    required this.locations,
    required this.programs,
    this.galleries,
    this.scholarships,
    this.news,
    required this.createdAt,
    required this.updatedAt,
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
        locations: List<SchoolLocation>.from(
            json["locations"].map((x) => SchoolLocation.fromJson(x))),
        programs: List<SchoolProgram>.from(
            json["programs"].map((x) => SchoolProgram.fromJson(x))),
        galleries: json["galleries"] != null
            ? List<SchoolGallery>.from(
                json["galleries"].map((x) => SchoolGallery.fromJson(x)))
            : [],
        scholarships: json["scholarships"] != null
            ? List<SchoolScholarship>.from(
                json["scholarships"].map((x) => SchoolScholarship.fromJson(x)))
            : [],
        news: json["news"] != null
            ? List<News>.from(json["news"].map((x) => News.fromJson(x)))
            : [],
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
        "locations": locations.map((x) => x.toJson()).toList(),
        "programs": programs.map((x) => x.toJson()).toList(),
        "galleries": galleries?.map((x) => x.toJson()).toList() ?? [],
        "scholarships": scholarships?.map((x) => x.toJson()).toList() ?? [],
        "news": news?.map((x) => x.toJson()).toList() ?? [],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class SchoolLocation {
  String id;

  String cover;
  String name;
  String? description;
  String address;
  bool isMain;

  List<SchoolLocationImage>? images;
  List<SchoolLocationContact>? contacts;

  String schoolId;

  DateTime createdAt;
  DateTime updatedAt;

  SchoolLocation({
    required this.id,
    required this.cover,
    required this.name,
    this.description,
    required this.address,
    required this.isMain,
    this.images,
    this.contacts,
    required this.schoolId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchoolLocation.fromJson(Map<String, dynamic> json) => SchoolLocation(
        id: json["id"],
        cover: json["cover"],
        name: json["name"],
        description: json["description"],
        address: json["address"],
        isMain: json["isMain"],
        contacts: json["contacts"] != null
            ? List<SchoolLocationContact>.from(
                json["contacts"].map((x) => SchoolLocationContact.fromJson(x)))
            : [],
        images: json["images"] != null
            ? List<SchoolLocationImage>.from(
                json["images"].map((x) => SchoolLocationImage.fromJson(x)))
            : [],
        schoolId: json["schoolId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "name": name,
        "description": description,
        "address": address,
        "isMain": isMain,
        "contacts": contacts?.map((x) => x.toJson()).toList() ?? [],
        "images": images?.map((x) => x.toJson()).toList() ?? [],
        "schoolId": schoolId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class SchoolLocationImage {
  String id;

  String url;

  String locationId;

  SchoolLocationImage({
    required this.id,
    required this.url,
    required this.locationId,
  });

  factory SchoolLocationImage.fromJson(Map<String, dynamic> json) =>
      SchoolLocationImage(
        id: json["id"],
        url: json["url"],
        locationId: json["locationId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "locationId": locationId,
      };
}

class SchoolLocationContact {
  String id;

  String? phone;
  String? hours;
  String? fax;
  String? email;
  String? url;

  String locationId;

  DateTime createdAt;
  DateTime updatedAt;

  SchoolLocationContact({
    required this.id,
    this.phone,
    this.hours,
    this.fax,
    this.email,
    this.url,
    required this.locationId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchoolLocationContact.fromJson(Map<String, dynamic> json) =>
      SchoolLocationContact(
        id: json["id"],
        phone: json["phone"],
        hours: json["hours"],
        fax: json["fax"],
        email: json["email"],
        url: json["url"],
        locationId: json["locationId"]!,
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
        "locationId": locationId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class SchoolProgram {
  String id;
  String name;
  String description;
  String cover;
  bool isPublished;

  String schoolId;

  List<StudentSchoolProgram>? studentPrograms;
  List<SchoolProgramImage>? images;

  DateTime createdAt;
  DateTime updatedAt;

  SchoolProgram({
    required this.id,
    required this.name,
    required this.description,
    required this.cover,
    required this.isPublished,
    required this.schoolId,
    this.studentPrograms,
    this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchoolProgram.fromJson(Map<String, dynamic> json) => SchoolProgram(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        cover: json["cover"],
        isPublished: json["isPublished"],
        schoolId: json["schoolId"],
        studentPrograms: json["studentPrograms"] == null
            ? []
            : List<StudentSchoolProgram>.from(json["studentPrograms"]!
                .map((x) => StudentSchoolProgram.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<SchoolProgramImage>.from(json["images"]!.map((x) => x)),
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
        "studentPrograms":
            studentPrograms?.map((x) => x.toJson()).toList() ?? [],
        "images": images?.map((x) => x.toJson()).toList() ?? [],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class StudentSchoolProgram {
  String id;

  String studentId;
  String programId;

  DateTime createdAt;
  DateTime updatedAt;

  StudentSchoolProgram({
    required this.id,
    required this.studentId,
    required this.programId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentSchoolProgram.fromJson(Map<String, dynamic> json) =>
      StudentSchoolProgram(
        id: json["id"],
        studentId: json["studentId"],
        programId: json["programId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentId": studentId,
        "programId": programId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class SchoolProgramImage {
  String id;

  String url;

  String programId;

  SchoolProgramImage({
    required this.id,
    required this.url,
    required this.programId,
  });

  factory SchoolProgramImage.fromJson(Map<String, dynamic> json) =>
      SchoolProgramImage(
        id: json["id"],
        url: json["url"],
        programId: json["programId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "programId": programId,
      };
}

class SchoolGallery {
  String id;

  String name;
  String description;
  String cover;

  List<SchoolGalleryImage>? images;

  String schoolId;

  DateTime createdAt;
  DateTime updatedAt;

  SchoolGallery({
    required this.id,
    required this.name,
    required this.description,
    required this.cover,
    this.images,
    required this.schoolId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchoolGallery.fromJson(Map<String, dynamic> json) => SchoolGallery(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        cover: json["cover"],
        schoolId: json["schoolid"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: json["images"] == null
            ? []
            : List<SchoolGalleryImage>.from(
                json["images"]!.map((x) => SchoolGalleryImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "cover": cover,
        "images": images?.map((x) => x.toJson()).toList() ?? [],
        "schoolId": schoolId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class SchoolGalleryImage {
  String id;

  String url;

  String galleryId;

  SchoolGalleryImage({
    required this.id,
    required this.url,
    required this.galleryId,
  });

  factory SchoolGalleryImage.fromJson(Map<String, dynamic> json) =>
      SchoolGalleryImage(
        id: json["id"],
        url: json["url"],
        galleryId: json["galleryId"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "url": url, "galleryId": galleryId};
}

class SchoolScholarship {
  String id;
  String name;
  String description;
  String cover;
  bool isPublished;

  String schoolId;

  List<StudentSchoolScholarship>? owners;
  List<SchoolScholarshipImage>? images;

  DateTime createdAt;
  DateTime updatedAt;

  SchoolScholarship({
    required this.id,
    required this.name,
    required this.description,
    required this.cover,
    required this.isPublished,
    required this.schoolId,
    this.owners,
    this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchoolScholarship.fromJson(Map<String, dynamic> json) =>
      SchoolScholarship(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        cover: json["cover"],
        isPublished: json["isPublished"],
        schoolId: json["schoolId"],
        owners: json["owners"] == null
            ? []
            : List<StudentSchoolScholarship>.from(json["owners"]
                .map((x) => StudentSchoolScholarship.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<SchoolScholarshipImage>.from(
                json["images"].map((x) => SchoolScholarshipImage.fromJson(x))),
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
        "owners": owners?.map((x) => x.toJson()).toList() ?? [],
        "images": images?.map((x) => x.toJson()).toList() ?? [],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class SchoolScholarshipImage {
  String id;

  String url;

  String scholarshipId;

  SchoolScholarshipImage({
    required this.id,
    required this.url,
    required this.scholarshipId,
  });

  factory SchoolScholarshipImage.fromJson(Map<String, dynamic> json) =>
      SchoolScholarshipImage(
        id: json["id"],
        url: json["url"],
        scholarshipId: json["scholarshipId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "scholarshipId": scholarshipId,
      };
}

class StudentSchoolScholarship {
  String id;

  String studentId;

  String scholarshipId;

  DateTime createdAt;
  DateTime updatedAt;

  StudentSchoolScholarship({
    required this.id,
    required this.studentId,
    required this.scholarshipId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentSchoolScholarship.fromJson(Map<String, dynamic> json) =>
      StudentSchoolScholarship(
        id: json["id"],
        studentId: json["studentId"],
        scholarshipId: json["scholarshipId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentId": studentId,
        "scholarshipId": scholarshipId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class News {
  String id;

  String title;
  String content;
  String type;
  String cover;
  bool isPublished;

  String? schoolId;

  DateTime createdAt;
  DateTime updatedAt;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.cover,
    required this.isPublished,
    this.schoolId,
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

class Student {
  String id;
  String? studentCode;
  Account account;
  String? cover;
  String degreeType;
  String certificateType;
  String gradeType;
  int gradeScore;
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
        gradeScore: json["gradeScore"],
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
