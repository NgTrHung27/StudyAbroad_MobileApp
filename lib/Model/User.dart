import 'dart:convert';

class User {
  String? id;
  String? name;
  String? dob;
  String? address;
  String? phoneNumber;
  String? gender;
  String? cccd;
  String? description;
  bool? isPublic;
  String? avatar;
  String? email;
  String? pass;

  User.none();

  User.Register1(
      {this.name,
      this.dob,
      this.phoneNumber,
      this.address,
      this.gender,
      this.cccd,
      this.email,
      this.pass});

  User(
      {this.id,
      this.name,
      this.dob,
      this.address,
      this.phoneNumber,
      this.gender,
      this.cccd,
      this.description,
      this.isPublic,
      this.avatar,
      this.email,
      this.pass});

  static List<User> parseList(response) {
    var list = json.decode(response.body) as List;
    return list.map((item) => User.fromJson(item)).toList();
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        dob: json['dob'],
        address: json['address'],
        phoneNumber: json['phoneNumber'],
        gender: json['gender'],
        cccd: json['cccd'],
        description: json['description'],
        isPublic: json['isPublished'],
        avatar: json['avatar'],
        email: json['email'],
        pass: json['hashedPassword'],
      );
}
