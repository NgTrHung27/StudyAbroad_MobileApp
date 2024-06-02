import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/style/simplebutton.dart';
import 'package:kltn_mobile/routes/app_route.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class LogoutPage extends BasePage {
  const LogoutPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends BasePageState<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.onGenerateRoute,
        home: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bckgr_logout_blur.png"),
                    fit: BoxFit.cover)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/LOGO_RED.png',
                            width: 80,
                          ),
                          SizedBox(height: screenHeight * 0.2),
                          const TextMonserats(
                            "Join with \nus to manage your future",
                            fontSize: 38,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          const TextMonserats(
                              "Create account to manage your \naccount today",
                              fontSize: 14),
                          SizedBox(height: screenHeight * 0.15),
                          SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: SimpleButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: const TextMonserats(
                                  'Sign Up',
                                  color: Colors.white,
                                ),
                              )),
                          SizedBox(height: screenHeight * 0.02),
                          SizedBox(
                            width: double.infinity,
                            child: SimpleButton(
                              backgroundColor: Colors.transparent,
                              borderColor: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const TextMonserats(
                                'Already have an account? Sign in',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ))));
  }
}