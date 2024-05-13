import 'dart:convert';

class UserForgotpass {
  String? error;

  UserForgotpass({this.error});

  factory UserForgotpass.fromJson(Map<String, dynamic> json) {
    return UserForgotpass(
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
    };
  }

  static UserForgotpass userForgotpassFromJson(String str) =>
      UserForgotpass.fromJson(json.decode(str));

  static String userForgotpassToJson(UserForgotpass data) =>
      json.encode(data.toJson());

  static List<UserForgotpass> parseList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserForgotpass>((json) => UserForgotpass.fromJson(json))
        .toList();
  }
}
