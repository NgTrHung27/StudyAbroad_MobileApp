import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:kltn_mobile/Model/user_login.dart';

class APIService {
  Future<UserAuthLogin?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://study-abroad-canada.vercel.app/api/auth/signin'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('data: $data');

        return UserAuthLogin.fromJson(data);
      } else {
        print("Failed to login: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception occurred while logging in: $e");
      return null;
    }
  }
}
