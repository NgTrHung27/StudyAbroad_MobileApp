import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/Authentication/register_page.dart';
import 'package:kltn_mobile/View/status_test.dart';
import 'package:kltn_mobile/bloC/auth/login_cubit.dart';
import 'package:kltn_mobile/bloC/repository/repository.dart';
import 'package:kltn_mobile/components/button.dart';
import 'package:kltn_mobile/components/text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(APIRepository()),
      child: _LoginPage(),
    );
  }
}

class _LoginPage extends StatefulWidget {
  @override
  State<_LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<_LoginPage> {
  String email = '';
  String password = '';
  String? errorMessage;

  //Text Editing Controller
  final usermailController = TextEditingController();
  final passwordController = TextEditingController();
  int selectedValue = 0; // Define the selectedValue variable

  //LoginUser in Method API
  void userLogin(BuildContext context) {
    // Lấy giá trị email và password từ các TextField
    String email = usermailController.text.trim();
    String password = passwordController.text.trim();
    log('data: $email');
    log('data: $password');
    // Gọi phương thức login từ LoginCubit
    context.read<LoginCubit>().login(email, password);
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
              body: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    const Center(child: CircularProgressIndicator());
                  }
                  if (state is LoginFailure) {
                    setState(() {
                      errorMessage = state.error;
                    });
                  } else if (state is LoginSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              StatusTest(userAuth: state.userAuthLogin)),
                    );
                  } else if (state is EmailError) {
                    setState(() {
                      errorMessage = state.error;
                    });
                  } else if (state is LoginInitial) {
                    setState(() {
                      errorMessage = null;
                    });
                  }
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 40.0),
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
                                  context.read<LoginCubit>().checkEmail(email);
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
                          //Error Message
                          if (errorMessage != null)
                            Text(
                              errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          //Login Button
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyButton(
                                onTap: () => userLogin(context),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          //Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Forgot your password?',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ))
                            ],
                          ),

                          const SizedBox(height: 230),
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()),
                                    );
                                  },
                                  child: Text('Sign Up',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        color: const Color(0xff7D1F1F),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      )),
                                )
                              ]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }
}
