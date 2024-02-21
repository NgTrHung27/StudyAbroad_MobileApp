import 'dart:convert';

class UserAuthentication {
  String? id;
  String? name;
  String? email;
  DateTime? emailVerified;
  String? password;

  UserAuthentication({
    this.id,
    this.name,
    this.email,
    this.emailVerified,
    this.password,
  });

  factory UserAuthentication.fromJson(Map<String, dynamic> json) {
    return UserAuthentication(
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

  static List<UserAuthentication> parseList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserAuthentication>((json) => UserAuthentication.fromJson(json))
        .toList();
  }
}
