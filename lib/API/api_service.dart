import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:kltn_mobile/Model/enum.dart';
import 'package:kltn_mobile/Model/school.dart';
import 'package:kltn_mobile/Model/user_login.dart';
import 'package:kltn_mobile/Model/user_register.dart';
import 'package:kltn_mobile/Model/vn_country.dart';

class APIService {
  Future<UserAuthLogin?> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('https://kltn-demo-deploy-admin.vercel.app/api/auth/login'),
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

  //Formart Date for API
  // UserAuthRegister userAuthRegister = UserAuthRegister.none();
  // DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(userAuthRegister.dob!);
  // String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
  // DateTime now = DateTime.now();
  // String dateNow = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  Future<UserAuthRegister?> register(
    String email,
    String name,
    String password,
    String confirmpassword,
    String idCardNumber,
    DateTime dob,
    String phone,
    String? selectedSchool,
    String? selectedProgram,
    String? selectedCity,
    String? selectedDistrict,
    String? selectedWard,
    String address,
    String? valueGender,
    String? valueDegree,
    String? radioGradeTypeValue,
    double gradeScore,
    String? selectedCertificateType,
    String? certificateImg,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://kltn-demo-deploy-admin.vercel.app/api/auth/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "name": name,
          "password": password,
          "confirmPassword": confirmpassword,
          "idCardNumber": idCardNumber,
          "dob": dob.toIso8601String(),
          "phoneNumber": phone,
          "schoolName": selectedSchool,
          "programName": selectedProgram,
          "city": selectedCity,
          "district": selectedDistrict,
          "ward": selectedWard,
          "addressLine": address,
          "gender": valueGender, // "0" or "1
          "degreeType": valueDegree,
          "gradeType": radioGradeTypeValue,
          "gradeScore": gradeScore,
          "certificateType": selectedCertificateType,
          "certificateImg": certificateImg,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('data: $data');

        return UserAuthRegister.fromJson(data);
      } else {
        print("Failed to register: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception occurred while registering: $e");
      return null;
    }
  }

  Future<List<City>> getCity() async {
    try {
      final response = await http.get(
        Uri.parse('https://kltn-demo-deploy-admin.vercel.app/api/country'),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print('API City Response: $data'); // Add this line
        List<City> cities = [];
        for (var item in data) {
          // Tạo một đối tượng School từ JSON
          City city = City.fromJson(item);
          // Thêm đối tượng School vào danh sách schools
          cities.add(city);
        }
        return cities;
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API City');
    }
  }

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
      throw Exception('Failed to connect to the API School');
    }
  }
}
