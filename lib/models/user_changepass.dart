import 'dart:convert';

class UserChangePass {
  String? error;

  UserChangePass({this.error});

  factory UserChangePass.fromJson(Map<String, dynamic> json) {
    return UserChangePass(
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
    };
  }

  static UserChangePass userChangePassFromJson(String str) =>
      UserChangePass.fromJson(json.decode(str));

  static String userChangePassToJson(UserChangePass data) =>
      json.encode(data.toJson());

  static List<UserChangePass> parseList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UserChangePass>((json) => UserChangePass.fromJson(json))
        .toList();
  }
}
