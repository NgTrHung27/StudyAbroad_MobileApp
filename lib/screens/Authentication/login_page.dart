import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/login_cubit.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/style/backbutton.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/style/textspan.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/constant/theme.dart';
import 'package:kltn_mobile/components/functions/button.dart';
import 'package:kltn_mobile/components/functions/text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class LoginPage extends BasePage {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage> {
  String email = '';
  String password = '';
  String? errorMessage;

  //Text Editing Controller
  final usermailController = TextEditingController();
  final passwordController = TextEditingController();
  int selectedValue = 0;
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
    //size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    //language
    final localizations = AppLocalizations.of(context);
    final welcome =
        localizations != null ? localizations.login_welcome : 'Default Text';
    final loginContinue =
        localizations != null ? localizations.login_continue : 'Default Text';
    final emailText = localizations != null
        ? localizations.register_login_cpass__fg_mail
        : 'Default Text';
    final passText = localizations != null
        ? localizations.register_login_cpass__fg_pass
        : 'Default Text';
    final remem =
        localizations != null ? localizations.login_remember : 'Default Text';
    final signup = localizations != null
        ? localizations.register_login_signin
        : 'Default Text';
    final forgot =
        localizations != null ? localizations.login_forgot : 'Default Text';
    final notAccout =
        localizations != null ? localizations.login_donot : 'Default Text';
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final textColorRed = isDarkMode ? Colors.white : AppColor.redButton;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(context.watch<ThemeSettingCubit>().state ==
                      AppTheme.blackTheme
                  ? "assets/backgrounds/bckgr_login_dark.jpg"
                  : "assets/backgrounds/bckgr_login.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
              Navigator.pushNamed(context, '/home',
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
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BackButtonCircle(onPressed: () {
                              Navigator.pushNamed(context, '/logout');
                            }),
                            //Logo
                            SizedBox(width: screenWidth * 0.20),
                            Image.asset(
                              context.watch<ThemeSettingCubit>().state ==
                                      AppTheme.blackTheme
                                  ? "assets/logo/logo_white.png"
                                  : "assets/logo/logo_red.png",
                              height: 80,
                            ),
                            SizedBox(width: screenWidth * 0.25),
                            Container(width: 35)
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextMonserats(
                            welcome,
                            fontSize: 30,
                            color: textColorRed,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.008),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: TextMonserats(
                            loginContinue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        //Email TextFied
                        SizedBox(height: screenHeight * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextField(
                              controller: usermailController,
                              hintText: emailText,
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
                        SizedBox(height: screenHeight * 0.001),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextField(
                              controller: passwordController,
                              hintText: passText,
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
                            TextMonserats(
                              remem,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ],
                        ),

                        //Login Button
                        SizedBox(height: screenHeight * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyButton(
                              onTap: () => userLogin(context),
                              text: signup,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        //Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigate to the ForgetPass screen
                                Navigator.pushNamed(context, "/forgotpass");
                              },
                              child: TextMonserats(
                                forgot,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.25),
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
                                      notAccout,
                                      color: textColor,
                                    ),
                                    styledTextSpan(
                                      signup,
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
    );
  }
}
