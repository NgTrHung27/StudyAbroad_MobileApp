class ScholarStatus {
  final String nameScholar;
  final String scholarStatus;

  ScholarStatus({
    required this.nameScholar,
    required this.scholarStatus,
  });
}

// Dữ liệu tạm thời
List<ScholarStatus> dummyScholarData = [
  ScholarStatus(nameScholar: 'GPA Scholarship', scholarStatus: 'Paid'),
  ScholarStatus(nameScholar: 'GPA Scholarship', scholarStatus: 'Pending'),
  ScholarStatus(nameScholar: 'GPA Scholarship', scholarStatus: 'UnPaid'),
];
