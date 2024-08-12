import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/models/score.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScoreTable extends StatelessWidget {
  final SemesterScore semesterScore;

  const ScoreTable({super.key, required this.semesterScore});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final localizations = AppLocalizations.of(context);
    final subject =
        localizations != null ? localizations.scr_subject : "Default Text";
    final score =
        localizations != null ? localizations.scr_score : "Default Text";
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3,
            spreadRadius: 3,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: DataTable(
          dividerThickness: 0,
          columnSpacing: screenWidth * 0.2,
          headingRowColor:
              WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            return AppColor.redButton; // Header background color
          }),
          headingTextStyle: const TextStyle(
            color: Colors.white, // Header text color
            fontWeight: FontWeight.bold,
          ),
          columns: [
            DataColumn(
                label: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05),
              child: TextMonserats(
                subject,
                color: Colors.white,
                fontSize: screenWidth * 0.04,
              ),
            )),
            DataColumn(
                label: TextMonserats(
              score,
              color: Colors.white,
              fontSize: screenWidth * 0.04,
            )),
          ],
          rows: semesterScore.scores.asMap().entries.map((entry) {
            int index = entry.key;
            SubjectScore subjectScore = entry.value;

            return DataRow(
              color: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                return index.isEven
                    ? Colors.white
                    : const Color(0xffFFE9E4); // Alternate row colors
              }),
              cells: [
                DataCell(Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: TextMonserats(
                    subjectScore.subject,
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                )),
                DataCell(SizedBox(
                    width: screenWidth * 0.4,
                    child: TextMonserats(
                      subjectScore.score.toString(),
                      fontSize: screenWidth * 0.035,
                      color: Colors.black,
                    ))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
