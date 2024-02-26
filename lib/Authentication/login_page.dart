import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/API/api_service.dart';
import 'package:kltn_mobile/HomePage/home_page.dart';
import 'package:kltn_mobile/Model/user_login.dart';
import 'package:kltn_mobile/components/button.dart';
import 'package:kltn_mobile/components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  //Text Editing Controller
  final usermailController = TextEditingController();
  final passwordController = TextEditingController();
  int selectedValue = 0; // Define the selectedValue variable

  //LoginUser in Method
  // ignore: non_constant_identifier_names
  void UserLogin() async {
    // Lấy giá trị email và password từ các TextField
    String email = usermailController.text.trim();
    String password = passwordController.text.trim();
    log('data: $email');
    log('data: $password');

    // Kiểm tra email và password không trống
    if (email.isEmpty || password.isEmpty) {
      // Hiển thị thông báo lỗi
      print('Email hoặc password không được trống!');
      return;
    }
    // Gọi phương thức login từ APIService
    UserAuthLogin? userAuth = await APIService().login(email, password);
    log('data: $userAuth');

    // Xử lý kết quả trả về
    if (userAuth != null) {
      // Đăng nhập thành công, điều hướng tới màn hình tiếp theo
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Hiển thị thông báo lỗi

      print('Đăng nhập thất bại!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Bckgr_Login.jpg"),
                    fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Thay đổi từ CrossAxisAlignment.center thành CrossAxisAlignment.start
                    children: [
                      //Logo
                      //Logo và các phần còn lại sẽ được bao trong một Row để căn giữa theo chiều ngang
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Logo
                          Image.asset(
                            "assets/LOGO_RED.png",
                            height: 80,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Welcome\nBack!',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: const Color(0xff7D1F1F),
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Continue your adventure',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: const Color(0xff7D1F1F),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      //Email TextFied
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTextField(
                            controller: usermailController,
                            hintText: 'Enter your email',
                            obscureText: false,
                            prefixIcon: Icons.email,
                            onChanged: (value) {
                              // Lưu giá trị email mới được nhập
                              email = value;
                            },
                          ),
                        ],
                      ),

                      //Pass TextFied
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTextField(
                            controller: passwordController,
                            hintText: 'Enter your password',
                            obscureText: true,
                            prefixIcon: Icons.lock,
                            additionalIcon: Icons.visibility,
                            onChanged: (value) {
                              // Lưu giá trị password mới được nhập
                              password = value;
                            },
                          ),
                        ],
                      ),

                      //Forgot Pass
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.8, // Adjust the scale factor as needed
                            child: Radio(
                              value: 0,
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value!;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Remember me?',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      //Login Button
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            onTap: UserLogin,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      //Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Forgot your password?',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              )
                            )
                        ],
                      ),

                      const SizedBox(height: 160),
                      //divider
                      const Divider(
                        color:Color(0xffCBD5E1),
                        height: 2,
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account?',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text('Sign Up',
                                style: GoogleFonts.getFont(
                                  'Montserrat',
                                  color: const Color(0xff7D1F1F),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ))
                          ]
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
        );
  }
}
