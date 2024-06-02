import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/forgot_pass_cubit.dart';
import 'package:kltn_mobile/blocs/repository/repository.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/constant/theme.dart';
import 'package:kltn_mobile/components/functions/button.dart';
import 'package:kltn_mobile/components/functions/text_field.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class ForgetPass extends BasePage {
  const ForgetPass({super.key});

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPassCubit(APIRepository()),
      child: _ForgetPass(),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _ForgetPass extends StatefulWidget {
  @override
  State<_ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<_ForgetPass> {
  String email = '';
  String? errorMessage;
  final usermailController = TextEditingController();

  void userForgetPass(BuildContext context) async {
    try {
      email = usermailController.text.trim();
      await context.read<ForgotPassCubit>().accept(email);
    } catch (e) {
      print('API Error: $e'); // Print the error
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                context.watch<ThemeSettingCubit>().state == AppTheme.blackTheme
                    ? 'assets/FORGOTPASS_Background_Dark.png'
                    : 'assets/FORGOT PASSWORD 6.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<ForgotPassCubit, ForgotPassState>(
            listener: (context, state) {
              if (state is ForgotPassLoading) {
                const Center(child: CircularProgressIndicator());
              }
              if (state is ForgotPassFailure) {
                setState(() {
                  errorMessage = state.error;
                });
              } else if (state is ForgotPassSuccess) {
                errorMessage = 'Verification email has been sent!';
              } else if (state is EmailError) {
                setState(() {
                  errorMessage = state.error;
                });
              } else if (state is ForgotPassInitial) {
                setState(() {
                  errorMessage = null;
                });
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/LOGO_WHITE.png",
                            height: 70,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextMonserats(
                            'Forgot Password?',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                          SizedBox(height: 10),
                          TextMonserats(
                            'Enter your email for the verification process, we will send verify link',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ],
                      ),
                      const SizedBox(height: 70),
                      Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextMonserats(
                                'Enter Your Email',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  MyTextField(
                                    controller: usermailController,
                                    hintText: 'Email',
                                    obscureText: false,
                                    prefixIcon: Icons.email,
                                    onChanged: (value) {
                                      email = value;
                                      context
                                          .read<ForgotPassCubit>()
                                          .errorEmail(email);
                                    },
                                  ),
                                  // Display errorMessage if it is not null
                                  if (errorMessage != null)
                                    TextMonserats(
                                      errorMessage!,
                                      color: Colors.red,
                                      textAlign: TextAlign.left,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyButton(
                                text: 'Send Verification Link',
                                onTap: () {
                                  print('Button pressed');
                                  userForgetPass(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 280),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigate back to login screen
                                  Navigator.pop(context);
                                },
                                child: const TextMonserats(
                                  'Back to Login',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
