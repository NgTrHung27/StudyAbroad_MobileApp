import 'package:flutter/material.dart';
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

    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Flat AppBar
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Semester ${latestScore.semester}/2025 Score',
                          style: TextStyle(
                            fontSize: 16.0,
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
                    SizedBox(height: 8.0),
                    Text(
                      'Total GPA',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      calculateGPA(latestScore.scores).toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Divider(),
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
            Expanded(
              child: ListView(
                children: widget.semesterScores
                    .where((score) => score.semester != latestSemester)
                    .map((semesterScore) {
                  return Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text('Semester ${semesterScore.semester}/2024'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.0,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScoreDetail(semesterScore: semesterScore),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
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
