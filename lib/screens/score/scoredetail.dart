import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/simplebutton.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/list_view/score_comment_box.dart';
import 'package:kltn_mobile/components/list_view/scoretable.dart';
import 'package:kltn_mobile/models/score.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScoreDetail extends StatelessWidget {
  final SemesterScore semesterScore;

  const ScoreDetail({super.key, required this.semesterScore});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final localizations = AppLocalizations.of(context);
    final sms = localizations != null ? localizations.scr_sms : "Default Text";
    final dwn = localizations != null ? localizations.scr_dwn : "Default Text";

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.15,
              color: AppColor.redButton,
              child: Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.05),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButtonCircle(),
                        TextMonserats(
                          '$sms ${semesterScore.semester.toString()}',
                          color: Colors.white,
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          width: screenWidth * 0.13,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.01),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.025),
                  ScoreTable(
                    semesterScore: semesterScore,
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  ScoreCommentBox(comment: semesterScore.comment),
                  SizedBox(height: screenHeight * 0.025),
                  SimpleButton(
                    backgroundColor: const Color(0xffF58218),
                    onPressed: () {},
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: screenWidth * 0.009,
                          ),
                          TextMonserats(
                            dwn,
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
