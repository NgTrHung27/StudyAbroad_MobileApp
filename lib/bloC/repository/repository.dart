import 'dart:convert';
import 'package:kltn_mobile/Model/school.dart';

class APIRepository {
  get http => null;
  Future<List<School>> getSchools() async {
    try {
      final response = await http.get(
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
}
