import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/simplebutton.dart';
import 'package:kltn_mobile/models/user_login.dart';
import 'package:kltn_mobile/screens/Authentication/auth_data_notify.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ApplyPage extends BasePage {
  final String name;
  final String id;

  const ApplyPage({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  ApplyPageState createState() => ApplyPageState();
}

class ApplyPageState extends BasePageState<ApplyPage> {
  final TextEditingController descriptionController = TextEditingController();

  Future<void> sendScholarReg() async {
    final url =
        'https://kltn-demo-deploy-admin.vercel.app/api/accounts/students/${userAuth?.student.id}/requirements/${widget.id}';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'studentId': userAuth?.student.id,
        'additional': descriptionController.text,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print('Failed to send response');
    }
    print(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userAuth = context.watch<UserAuthProvider>().userAuthLogin;
  }

  Future<UserAuthLogin?> getUserAuth(BuildContext context) async {
    return userAuth ?? context.watch<UserAuthProvider>().userAuthLogin;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextMonserats('Description',
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w700),
                  TextField(
                    controller: descriptionController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white, // Màu nền trắng
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.black54, // Màu sắc của đường viền
                        ),
                      ),
                    ),
                    maxLines: 8, // Số dòng tối đa có thể nhập
                    keyboardType: TextInputType
                        .multiline, // Kiểu bàn phím nhập văn bản nhiều dòng
                  ),

                  const SizedBox(
                      height: 20), // Add some space before the button
                  SimpleButton(
                    onPressed: () {},
                    child: const TextMonserats('Send', color: Colors.white),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: const BackButtonCircle(),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top +
                        screenHeight * 0.005),
                child: TextMonserats(widget.name,
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
