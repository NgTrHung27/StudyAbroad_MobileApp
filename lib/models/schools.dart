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
  dynamic short;
  String? description;
  dynamic history;
  String color;
  bool isPublished;
  String country;
  DateTime createdAt;
  DateTime updatedAt;
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
    required this.country,
    required this.createdAt,
    required this.updatedAt,
    required this.programs,
  });

  Schools copyWith({
    String? id,
    String? logo,
    String? background,
    String? name,
    dynamic short,
    String? description,
    dynamic history,
    String? color,
    bool? isPublished,
    String? country,
    DateTime? createdAt,
    DateTime? updatedAt,
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
        country: country ?? this.country,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
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
        country: json["country"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        programs: List<Program>.from(
            json["programs"].map((x) => Program.fromJson(x))),
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
        "programs": List<dynamic>.from(programs.map((x) => x.toJson())),
      };
}

class Program {
  String name;

  Program({
    required this.name,
  });

  Program copyWith({
    String? name,
  }) =>
      Program(
        name: name ?? this.name,
      );

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
