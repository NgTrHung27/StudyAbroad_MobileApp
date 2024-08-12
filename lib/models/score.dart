class SubjectScore {
  String subject;
  double score;
  SubjectScore({
    required this.subject,
    required this.score,
  });
}

class SemesterScore {
  int semester;
  List<SubjectScore> scores;
  String comment; // Thêm thuộc tính comment

  SemesterScore({
    required this.semester,
    required this.scores,
    required this.comment, // Thêm comment vào constructor
  });

  // Temporary data
  static List<SemesterScore> getDummySemesterScores() {
    return [
      SemesterScore(
        semester: 1,
        scores: [
          SubjectScore(subject: 'math', score: 3.4),
          SubjectScore(subject: 'literature', score: 3.6),
          SubjectScore(subject: 'science', score: 3.1),
          SubjectScore(subject: 'history', score: 3.5),
          SubjectScore(subject: 'geography', score: 3.7),
          SubjectScore(subject: 'math', score: 3.4),
          SubjectScore(subject: 'literature', score: 3.6),
          SubjectScore(subject: 'science', score: 3.1),
          SubjectScore(subject: 'history', score: 3.5),
          SubjectScore(subject: 'geography', score: 3.7),
        ],
        comment: 'Good progress in all subjects.', // Thêm comment
      ),
      SemesterScore(
        semester: 2,
        scores: [
          SubjectScore(subject: 'math', score: 3.0),
          SubjectScore(subject: 'literature', score: 3.2),
          SubjectScore(subject: 'science', score: 3.4),
          SubjectScore(subject: 'history', score: 2.8),
          SubjectScore(subject: 'geography', score: 3.5),
        ],
        comment: 'Needs improvement in history.', // Thêm comment
      ),
      SemesterScore(
        semester: 3,
        scores: [
          SubjectScore(subject: 'math', score: 3.8),
          SubjectScore(subject: 'literature', score: 3.4),
          SubjectScore(subject: 'science', score: 3.7),
          SubjectScore(subject: 'history', score: 3.6),
          SubjectScore(subject: 'geography', score: 3.8),
        ],
        comment: 'Excellent performance overall.', // Thêm comment
      ),
      SemesterScore(
        semester: 4,
        scores: [
          SubjectScore(subject: 'math', score: 3.5),
          SubjectScore(subject: 'literature', score: 3.7),
          SubjectScore(subject: 'science', score: 3.2),
          SubjectScore(subject: 'history', score: 3.4),
          SubjectScore(subject: 'geography', score: 3.6),
        ],
        comment: 'Consistent performance.', // Thêm comment
      ),
    ];
  }
}
