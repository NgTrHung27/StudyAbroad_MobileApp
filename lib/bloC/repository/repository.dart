import 'dart:convert';
import 'dart:developer';
import 'package:kltn_mobile/Model/country.dart';
import 'package:kltn_mobile/Model/schools.dart';
import 'package:kltn_mobile/Model/user_login.dart';
import 'package:http/http.dart' as http;
import 'package:kltn_mobile/Model/user_register.dart';

class APIRepository {
  http.Client get httpClient => http.Client();
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
    String? gradeScore,
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
      } else if (response.statusCode == 406) {
        final responseData = jsonDecode(response.body);
        final errors = responseData['error'] as List<dynamic>;
        for (final error in errors) {
          final code = error['code'];
          final message = error['message'];
          final path = error['path'];
          print('Error: Code $code, Message: $message, Path: $path');
        }
        return null;
      } else {
        print("Failed to register: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception occurred while registering: $e");
      return null;
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

      final data =
          jsonDecode(utf8.decode(response.bodyBytes)); // Define data here

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


  Future<List<Country>> fetchCountry() async {
    try {
      final response = await http.get(
        Uri.parse('https://kltn-demo-deploy-admin.vercel.app/api/country'),
      );
      if (response.statusCode == 200) {
        List<dynamic> data =
            jsonDecode(utf8.decode(latin1.encode(response.body)));
        print('API Country Response: $data');
        List<Country> countries = [];
        for (var item in data) {
          Country country = Country.fromJson(item);
          countries.add(country);
        }
        return countries;
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API Country');
    }
  }

  Future<List<Schools>> fetchSchools() async {
    try {
      final response = await httpClient.get(
        Uri.parse('https://kltn-demo-deploy-admin.vercel.app/api/schools/full'),
      );
      if (response.statusCode == 200) {
        List<dynamic> data =
            jsonDecode(utf8.decode(latin1.encode(response.body)));
        print('API School Response: $data'); // Add this line
        List<Schools> schools = [];
        for (var item in data) {
          // Tạo một đối tượng School từ JSON
          Schools school = Schools.fromJson(item);
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
