class Tuition {
  final int semester;
  final int tuition;
  final String tuitionStatus;

  Tuition({
    required this.semester,
    required this.tuition,
    required this.tuitionStatus,
  });
}

// Dữ liệu tạm thời
List<Tuition> dummyTuitionData = [
  Tuition(semester: 1, tuition: 5000, tuitionStatus: 'Paid'),
  Tuition(semester: 1, tuition: 5000, tuitionStatus: 'Paid'),
  Tuition(semester: 1, tuition: 5000, tuitionStatus: 'Paid'),
  Tuition(semester: 1, tuition: 5000, tuitionStatus: 'Paid'),
  Tuition(semester: 2, tuition: 5500, tuitionStatus: 'Unpaid'),
  Tuition(semester: 3, tuition: 6000, tuitionStatus: 'Pending'),
];
