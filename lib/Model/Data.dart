import 'dart:convert';

import 'package:http/http.dart' as http;

// import 'News.dart';
// import 'School.dart';
import 'User.dart';

class ReadData {
  loadUser(String strUserName, String strPassword) async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/chill2305/user_data/main/user'));
  }

  ListUser() async {
    final response = await http
        .get(Uri.parse('https://admin-duhocsinhcanada.vercel.app/api/users'));
    List<User> u = User.parseList(response);
    return u;
  }

  // ListSchool() async {
  //   final response = await http
  //       .get(Uri.parse('https://admin-duhocsinhcanada.vercel.app/api/schools'));
  //   List<School> u = School.parseList(response);
  //   return u;
  // }

  // ListNews() async {
  //   final response = await http.get(Uri.parse(
  //       'https://admin-duhocsinhcanada.vercel.app/api/news?fbclid=IwAR0sy2DhD1EPqAxRBSDYVyN15XLCt9ujwFnaULgJH-TgRjSvpSXqGeBYAZk'));
  //   List<News> u = News.parseList(response);
  //   return u;
  // }

  Add(String strUserName, String strPassword) async {
    final response =
        await http.post(Uri.parse('http://192.168.1.9:8000/v1/user'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "AccountId": strUserName,
              "UserName": "chill",
              "FullName": "tran",
              "Email": "mailtran",
              "Password": strPassword,
            }));
    print(response.body.toString());
  }

  Future<bool> AddContact(
      String name, String email, String sdt, String content) async {
    try {
      final response = await http.post(
        Uri.parse('https://admin-duhocsinhcanada.vercel.app/api/contacts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "name": name,
          "email": email,
          "phoneNumber": sdt,
          "title": "Test title",
          "textContent": content,
          "createdAt": DateTime.now.toString(),
          "updatedAt": '',
        }),
      );

      if (response.statusCode == 200) {
        print(response.body.toString());
        return true; // Success
      } else {
        print("Failed to add contact. Status code: ${response.statusCode}");
        return false; // Failure
      }
    } catch (e) {
      print("Exception while adding contact: $e");
      return false; // Failure
    }
  }

  AddProfile(String strUserName, String strPassword) async {
    final response = await http.post(
        Uri.parse('https://admin-duhocsinhcanada.vercel.app/api/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "Name": strUserName,
          "DOB": "chill",
          "Address": "tran",
          "PhoneNumber": "mailtran",
          "Gender": strPassword,
          "CCCD": strPassword,
          "Description": strPassword,
          "IsPublised": strPassword,
          "Avatar": strPassword,
        }));
    print(response.body.toString());
  }

  Future<int> RequestForgotPass(String email) async {
    final response = await http.post(
        Uri.parse(
            'https://admin-duhocsinhcanada.vercel.app/api/forgotPassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email,
        }));
    print(response.statusCode.toString());
    return response.statusCode;
  }
}
