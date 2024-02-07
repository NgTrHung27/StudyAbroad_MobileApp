import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/components/Button.dart';
import 'package:kltn_mobile/components/TextField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text Editing Controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  //LoginUser in Method
  // ignore: non_constant_identifier_names
  void UserLogin() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Background.jpg"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 35.0, vertical: 40.0),
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
                          "assets/LOGO_CEMC_RED.jpg",
                          height: 134.0,
                          width: 200.0,
                        ),
                      ],
                    ),
                    //(Option /Welcome,...)
                    //Sign in title
                    const SizedBox(height: 40),
                    Text(
                      'Sign In',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                      ),
                    ),
                    //Email TextFied
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Enter your email',
                      obscureText: false,
                    ),

                    //Pass TextFied
                    const SizedBox(height: 20),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Enter your password',
                      obscureText: true,
                    ),

                    //Forgot Pass
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    //Login Button
                    const SizedBox(height: 170),

                    MyButton(
                      onTap: UserLogin,
                    ),
                    //Create Account
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You don’t have an account?',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text('Create Account',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: const Color(0xff7D1F1F),
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
