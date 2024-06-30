import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/forgot_pass_cubit.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/constant/theme.dart';
import 'package:kltn_mobile/components/functions/button.dart';
import 'package:kltn_mobile/components/functions/text_field.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPass extends BasePage {
  const ForgetPass({super.key});
  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends BasePageState<ForgetPass> {
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
    final localizations = AppLocalizations.of(context);
    final forgot1 =
        localizations != null ? localizations.forgot_1 : 'Default Text';
    final forgot2 =
        localizations != null ? localizations.forgot_2 : 'Default Text';
    final forgot3 =
        localizations != null ? localizations.forgot_3 : 'Default Text';
    final emailText = localizations != null
        ? localizations.register_login_cpass__fg_mail
        : 'Default Text';
    final forgot4 =
        localizations != null ? localizations.forgot_4 : 'Default Text';
    final forgot5 =
        localizations != null ? localizations.forgot_5 : 'Default Text';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                context.watch<ThemeSettingCubit>().state == AppTheme.blackTheme
                    ? 'assets/backgrounds/bckgr_fgpass_dark.jpg'
                    : 'assets/backgrounds/bckgr_fgpass.jpg'),
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
                            "assets/logo_white.png",
                            height: 70,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextMonserats(
                            forgot1,
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                          const SizedBox(height: 10),
                          TextMonserats(
                            forgot2,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextMonserats(
                                forgot3,
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
                                    hintText: emailText,
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
                                text: forgot4,
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
                                child: TextMonserats(
                                  forgot5,
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
