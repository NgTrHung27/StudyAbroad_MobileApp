import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/models/score.dart';
import 'package:kltn_mobile/screens/score/scoredetail.dart';

class ScorePage extends StatefulWidget {
  final List<SemesterScore> semesterScores;

  const ScorePage({super.key, required this.semesterScores});

  @override
  ScorePageState createState() => ScorePageState();
}

class ScorePageState extends State<ScorePage> {
  late int latestSemester;

  @override
  void initState() {
    super.initState();
    // Find the semester with the highest number (latest semester)
    latestSemester = widget.semesterScores
        .map((e) => e.semester)
        .reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    SemesterScore latestScore = widget.semesterScores.firstWhere(
      (score) => score.semester == latestSemester,
      orElse: () => widget.semesterScores.first,
    );
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : AppColor.redButton;
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
                          'Score',
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
                  horizontal: screenWidth * 0.05, vertical: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextMonserats(
                    'Lastest Score',
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  SizedBox(height: screenHeight * 0.013),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  child: TextMonserats(
                                    'Semester ${latestScore.semester}',
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.w700,
                                    height: 1.5,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Handle download action
                                },
                                icon: const Icon(
                                    Icons.download_for_offline_outlined),
                                label: TextMonserats(
                                  'Download',
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.033,
                                ),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextMonserats(
                                'Total GPA',
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                              TextMonserats(
                                calculateGPA(latestScore.scores)
                                    .toStringAsFixed(1),
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[800],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                              Icons.person_outline,
                              color: Colors.black,
                            ),
                            title: TextMonserats(
                              'Details score',
                              fontSize: screenWidth * 0.035,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: screenWidth * 0.04,
                              color: Colors.black,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ScoreDetail(semesterScore: latestScore),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  TextMonserats(
                    'Previous Score',
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  SizedBox(height: screenHeight * 0.013),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0), // Inner padding for the box
                    decoration: BoxDecoration(
                      color: Colors.white, // White background
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.2), // Subtle shadow for depth
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: widget.semesterScores
                            .where((score) => score.semester != latestSemester)
                            .map((semesterScore) {
                          // Get the index of the current item
                          int index =
                              widget.semesterScores.indexOf(semesterScore);
                          // Get the total number of items
                          int itemCount = widget.semesterScores
                              .where(
                                  (score) => score.semester != latestSemester)
                              .length;
                          return Column(
                            children: [
                              ListTile(
                                title: TextMonserats(
                                  'Semester ${semesterScore.semester}',
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: screenWidth * 0.04,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScoreDetail(
                                          semesterScore: semesterScore),
                                    ),
                                  );
                                },
                              ),
                              // Only show Divider if this is not the last item
                              if (index < itemCount - 1)
                                const Divider(
                                  color: Colors
                                      .grey, // Light grey color for the divider
                                  height: 1, // Height of the divider
                                  thickness: 1, // Thickness of the divider line
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateGPA(List<SubjectScore> scores) {
    double totalScore = scores.fold(
      0.0,
      (previousValue, score) => previousValue + score.score,
    );
    return totalScore / scores.length;
  }
}
