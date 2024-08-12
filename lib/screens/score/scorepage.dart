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
  int selectedSemester = 1;

  @override
  Widget build(BuildContext context) {
    SemesterScore selectedScore = widget.semesterScores.firstWhere(
      (score) => score.semester == selectedSemester,
      orElse: () => widget.semesterScores.first,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Scores'),
      ),
      body: Column(
        children: [
          DropdownButton<int>(
            value: selectedSemester,
            items: widget.semesterScores.map((semesterScore) {
              return DropdownMenuItem<int>(
                value: semesterScore.semester,
                child: Text('Semester ${semesterScore.semester}'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedSemester = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ScoreDetail(semesterScore: selectedScore),
                ),
              );
            },
            child: Text('View Details'),
          ),
        ],
      ),
    );
  }
}
