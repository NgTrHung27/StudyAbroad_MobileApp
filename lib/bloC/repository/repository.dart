import 'dart:convert';
import 'dart:developer';
import 'package:kltn_mobile/Model/school.dart';
import 'package:kltn_mobile/Model/user_login.dart';
import 'package:http/http.dart' as http;

class APIRepository {
  http.Client get httpClient => http.Client();
  Future<List<School>> getSchools() async {
    try {
      final response = await httpClient.get(
        Uri.parse('https://kltn-demo-deploy-admin.vercel.app/api/schools/full'),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print('API School Response: $data'); // Add this line
        List<School> schools = [];
        for (var item in data) {
          // Tạo một đối tượng School từ JSON
          School school = School.fromJson(item);
          // Thêm đối tượng School vào danh sách schools
          schools.add(school);
        }
        return schools;
      } else {
        throw Exception('Failed to load schools');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API School: $e');
    }
  }

  Future<UserAuthLogin?> login(
    String email,
    String password,
  ) async {
    try {
      final response = await httpClient.post(
        Uri.parse('https://kltn-demo-deploy-admin.vercel.app/api/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: utf8.encode(jsonEncode({"email": email, "password": password})),
      );

      final data = jsonDecode(utf8.decode(response.bodyBytes)); // Define data here

      if (response.statusCode == 200) {
        log('data: $data');
        return UserAuthLogin.fromJson(data);
      } else {
        print("Failed to login: ${response.statusCode}");
        return UserAuthLogin.fromJson(data); // Now data is accessible here
      }
    } catch (e) {
      print("Exception occurred while logging in: $e");
      return null;
    }
  } 
}
