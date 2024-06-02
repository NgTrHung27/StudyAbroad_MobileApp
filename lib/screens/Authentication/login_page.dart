import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/login_cubit.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/textspan.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/constant/theme.dart';
import 'package:kltn_mobile/components/functions/button.dart';
import 'package:kltn_mobile/components/functions/text_field.dart';
import 'package:kltn_mobile/routes/app_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class LoginPage extends BasePage {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    context.read<ThemeSettingCubit>().loadTheme();
  }

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
    log('data email: $email');
    log('data pass: $password');
    // Gọi phương thức login từ LoginCubit
    context.read<LoginCubit>().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final homeActionText =
        localizations != null ? localizations.home_action : 'Default Text';

    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final textColorRed = isDarkMode ? Colors.white : AppColor.redButton;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoute.onGenerateRoute,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(context.watch<ThemeSettingCubit>().state ==
                        AppTheme.blackTheme
                    ? "assets/Bckgr_Login_Dark.png"
                    : "assets/Bckgr_Login.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: BackButtonCircle(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // backgroundColor: Colors.transparent,
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
                Navigator.pushNamed(context, 'userdetail',
                    arguments: state.userAuthLogin);
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
                child: BlocBuilder<LanguageBloc, Locale>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: screenHeight * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              context.watch<ThemeSettingCubit>().state ==
                                      AppTheme.blackTheme
                                  ? "assets/LOGO_WHITE.png"
                                  : "assets/LOGO_RED.png",
                              height: 80,
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     BackButtonCircle(
                          //       onPressed: () {
                          //         if (scaffoldKey.currentContext != null) {
                          //           if (Navigator.canPop(
                          //               scaffoldKey.currentContext!)) {
                          //             Navigator.pop(
                          //                 scaffoldKey.currentContext!);
                          //           } else {
                          //             Navigator.pushNamed(
                          //                 scaffoldKey.currentContext!, 'home');
                          //           }
                          //         }
                          //       },
                          //     ),
                          //     //Logo
                          //     SizedBox(
                          //         width:
                          //             MediaQuery.of(context).size.width * 0.20),
                          //     Image.asset(
                          //       context.watch<ThemeSettingCubit>().state ==
                          //               AppTheme.blackTheme
                          //           ? "assets/LOGO_WHITE.png"
                          //           : "assets/LOGO_RED.png",
                          //       height: 80,
                          //     ),
                          //     SizedBox(
                          //         width:
                          //             MediaQuery.of(context).size.width * 0.20),
                          //     Container(width: 35)
                          //   ],
                          // ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextMonserats(
                              homeActionText,
                              fontSize: 30,
                              color: textColorRed,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: TextMonserats(
                              'Continue your adventure',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
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
                                keyboardType: TextInputType.emailAddress,
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
                          const SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyTextField(
                                controller: passwordController,
                                hintText: 'Enter your password',
                                obscureText: true,
                                prefixIcon: Icons.lock,
                                onChanged: (value) {
                                  // Lưu giá trị password mới được nhập
                                  password = value;
                                },
                              ),
                            ],
                          ),
                          //Error Message
                          if (errorMessage != null)
                            Center(
                              child: TextMonserats(
                                errorMessage!,
                                color: Colors.red,
                              ),
                            ),
                          //Forgot Pass
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
                              const TextMonserats(
                                'Remember me?',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ],
                          ),

                          //Login Button
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyButton(
                                onTap: () => userLogin(context),
                                text: 'Login',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          //Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigate to the ForgetPass screen
                                  Navigator.pushNamed(context, "/forgotpass");
                                },
                                child: const TextMonserats(
                                  'Forgot your password?',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 110),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Divider(
                                height: 1,
                                color: Color(0xFFCBD5E1),
                                thickness: 1.0,
                                indent: 20,
                                endIndent: 20,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Align(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      styledTextSpan(
                                        'Don’t have an account? ',
                                        color: textColor,
                                      ),
                                      styledTextSpan(
                                        'Sign up',
                                        color: AppColor.redButton,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                        decorationColor: const Color(
                                            0xff7D1F1F), // Change the color of the underline
                                        decorationStyle: TextDecorationStyle
                                            .solid, // Change the number of lines
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushNamed(
                                                context, "/register");
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // const Positioned(
                              //   bottom: 0,
                              //   left: 0,
                              //   right: 0,
                              //   child: MainNavBar(),
                              // )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
