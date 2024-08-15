import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Column(
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
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lastest Score',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[800],
                  ),
                ),
                SizedBox(height: 8.0),
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextMonserats(
                                'Semester ${latestScore.semester}/2025 Score',
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Handle download action
                              },
                              icon: Icon(Icons.download),
                              label: Text('Download'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextMonserats(
                              'Total GPA',
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            Text(
                              calculateGPA(latestScore.scores)
                                  .toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      const Divider(
                        color: Colors.grey,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Details score',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16.0,
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
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  'Previous Score',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[800],
                  ),
                ),
                SizedBox(height: 8.0),
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
                            .where((score) => score.semester != latestSemester)
                            .length;
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                  'Semester ${semesterScore.semester}/2024'),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
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
