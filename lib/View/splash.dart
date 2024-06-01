import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/View/HomePage/home_page.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container wrapping the logo
            Container(
              margin: const EdgeInsets.only(
                  bottom: 5), // Adjust this value to control spacing
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 10),
                duration: const Duration(seconds: 2),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale:
                        1 + (value / 80), // Adjust the scale factor as needed
                    child: Transform.translate(
                      offset: Offset(0, value),
                      child: Image.asset('assets/LOGO_RED.png', width: 100),
                    ),
                  );
                },
              ),
            ),
            // Container wrapping the text
            Container(
              margin: const EdgeInsets.only(
                  top: 0), // Adjust this value to control spacing
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 2),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                        offset: Offset(
                            0,
                            50 *
                                (1 -
                                    value)), // Adjust the translation range as needed
                        child: Text('Canada Education Manage Company',
                            style: GoogleFonts.montserrat(
                              color: AppColor.redButton,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ))),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
