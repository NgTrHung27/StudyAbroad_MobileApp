import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/functions/circle_avatarimg.dart';
import 'package:kltn_mobile/components/list_view/scholarships_box.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';


class ScholarshipsList extends BasePage {
  const ScholarshipsList({super.key});
  @override
  ScholarshipsListState createState() => ScholarshipsListState();
}

class ScholarshipsListState extends BasePageState<ScholarshipsList> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final userAuthLogin = userAuth;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.14),
              child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(userAuthLogin?.student.school.background ?? ''),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          child: TextMonserats(
                            userAuthLogin?.student.school.name ?? '',
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const Expanded(
                      child: ScholarshipsBox(),
                    ),
                  ],
                ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              child: const BackButtonCircle(), // Đặt BackButtonCircle ở góc trái trên
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