import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/bloC/auth/forgot_pass_cubit.dart';
import 'package:kltn_mobile/bloC/repository/repository.dart';
import 'package:kltn_mobile/components/text_field.dart';
import 'package:kltn_mobile/components/button.dart';

class ForgetPass extends StatelessWidget {
  const ForgetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPassCubit(APIRepository()),
      child: _ForgetPass(),
    );
  }
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
    // In giá trị của biến ra log console
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/FORGOT PASSWORD 6.jpg"),
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
                      Text(
                        'Forgot Password?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Enter your email for the verification process, we will send verify link',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 70),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Enter Your Email',
                                style: GoogleFonts.getFont(
                                  'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
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
                                    Text(
                                      errorMessage!,
                                      style: const TextStyle(color: Colors.red),
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
                                child: Text(
                                  'Back to Login',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
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
