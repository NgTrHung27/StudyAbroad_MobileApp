import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/simplebutton.dart';
import 'package:kltn_mobile/components/functions/circle_avatarimg.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class ScholarshipsDetail extends BasePage {
  final String name;
  final String description;

  const ScholarshipsDetail({super.key, required this.name, required this.description});

  @override
  ScholarshipsDetailState createState() => ScholarshipsDetailState();
}

class ScholarshipsDetailState extends BasePageState<ScholarshipsDetail> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextMonserats(
                            widget.name,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 10),
                          TextMonserats(widget.description),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add some space before the button
                  SimpleButton(
                    onPressed: () {
                      // Handle the button press
                    },
                    child: const Text(
                      'Apply Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              child: const BackButtonCircle(),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              right: 0,
              child: CirleAvatarImage(
                avatarImgUrl: userAuth?.student.school.logo != null
                        ? userAuth!.student.school.logo
                        : null,
                    avatarImgPath: 'assets/logo/logo_red.png',
                    width: 60,
                    height: 60
              ),
            ),
          ],
        ),
      ),
    );
  }
}