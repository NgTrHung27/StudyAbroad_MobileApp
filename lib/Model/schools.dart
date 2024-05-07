// To parse this JSON data, do
//
//     final schools = schoolsFromJson(jsonString);

import 'dart:convert';

List<Schools> schoolsFromJson(String str) => List<Schools>.from(json.decode(str).map((x) => Schools.fromJson(x)));

String schoolsToJson(List<Schools> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    DateTime createdAt;
    DateTime updatedAt;
    List<News> news;
    List<dynamic> galleries;
    List<dynamic> locations;
    List<Program> programs;

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
        required this.createdAt,
        required this.updatedAt,
        required this.news,
        required this.galleries,
        required this.locations,
        required this.programs,
    });

    Schools copyWith({
        String? id,
        String? logo,
        String? background,
        String? name,
        String? short,
        String? description,
        String? history,
        String? color,
        bool? isPublished,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<News>? news,
        List<dynamic>? galleries,
        List<dynamic>? locations,
        List<Program>? programs,
    }) => 
        Schools(
            id: id ?? this.id,
            logo: logo ?? this.logo,
            background: background ?? this.background,
            name: name ?? this.name,
            short: short ?? this.short,
            description: description ?? this.description,
            history: history ?? this.history,
            color: color ?? this.color,
            isPublished: isPublished ?? this.isPublished,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            news: news ?? this.news,
            galleries: galleries ?? this.galleries,
            locations: locations ?? this.locations,
            programs: programs ?? this.programs,
        );

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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
        galleries: List<dynamic>.from(json["galleries"].map((x) => x)),
        locations: List<dynamic>.from(json["locations"].map((x) => x)),
        programs: List<Program>.from(json["programs"].map((x) => Program.fromJson(x))),
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
        "galleries": List<dynamic>.from(galleries.map((x) => x)),
        "locations": List<dynamic>.from(locations.map((x) => x)),
        "programs": List<dynamic>.from(programs.map((x) => x.toJson())),
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

    News copyWith({
        String? id,
        String? title,
        String? content,
        String? type,
        String? cover,
        bool? isPublished,
        String? schoolId,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        News(
            id: id ?? this.id,
            title: title ?? this.title,
            content: content ?? this.content,
            type: type ?? this.type,
            cover: cover ?? this.cover,
            isPublished: isPublished ?? this.isPublished,
            schoolId: schoolId ?? this.schoolId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

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
    String cover;
    bool isPublished;
    String schoolId;
    DateTime createdAt;
    DateTime updatedAt;
    List<StudentProgram> studentPrograms;

    Program({
        required this.id,
        required this.name,
        required this.description,
        required this.cover,
        required this.isPublished,
        required this.schoolId,
        required this.createdAt,
        required this.updatedAt,
        required this.studentPrograms,
    });

    Program copyWith({
        String? id,
        String? name,
        String? description,
        String? cover,
        bool? isPublished,
        String? schoolId,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<StudentProgram>? studentPrograms,
    }) => 
        Program(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            cover: cover ?? this.cover,
            isPublished: isPublished ?? this.isPublished,
            schoolId: schoolId ?? this.schoolId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            studentPrograms: studentPrograms ?? this.studentPrograms,
        );

    factory Program.fromJson(Map<String, dynamic> json) => Program(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        cover: json["cover"],
        isPublished: json["isPublished"],
        schoolId: json["schoolId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        studentPrograms: List<StudentProgram>.from(json["studentPrograms"].map((x) => StudentProgram.fromJson(x))),
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
        "studentPrograms": List<dynamic>.from(studentPrograms.map((x) => x.toJson())),
    };
}

class StudentProgram {
    Student student;

    StudentProgram({
        required this.student,
    });

    StudentProgram copyWith({
        Student? student,
    }) => 
        StudentProgram(
            student: student ?? this.student,
        );

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
    dynamic cover;
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

    Student copyWith({
        String? id,
        String? studentCode,
        Account? account,
        dynamic cover,
        String? degreeType,
        String? certificateType,
        String? gradeType,
        double? gradeScore,
        String? status,
    }) => 
        Student(
            id: id ?? this.id,
            studentCode: studentCode ?? this.studentCode,
            account: account ?? this.account,
            cover: cover ?? this.cover,
            degreeType: degreeType ?? this.degreeType,
            certificateType: certificateType ?? this.certificateType,
            gradeType: gradeType ?? this.gradeType,
            gradeScore: gradeScore ?? this.gradeScore,
            status: status ?? this.status,
        );

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

    Account copyWith({
        String? name,
    }) => 
        Account(
            name: name ?? this.name,
        );

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
