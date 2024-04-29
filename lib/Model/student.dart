class Student {
  String? id;
  String? degreeType;
  String? certificateType;
  String? certificateImg;
  String? gradeType;
  double? gradeScore;
  String? status;
  String? accountId;
  String? schoolId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Student({
    this.id,
    this.degreeType,
    this.certificateType,
    this.certificateImg,
    this.gradeType,
    this.gradeScore,
    this.status,
    this.accountId,
    this.schoolId,
    this.createdAt,
    this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      degreeType: json['degreeType'],
      certificateType: json['certificateType'],
      certificateImg: json['certificateImg'],
      gradeType: json['gradeType'],
      gradeScore: json['gradeScore']?.toDouble(),
      status: json['status'],
      accountId: json['accountId'],
      schoolId: json['schoolId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'degreeType': degreeType,
      'certificateType': certificateType,
      'certificateImg': certificateImg,
      'gradeType': gradeType,
      'gradeScore': gradeScore,
      'status': status,
      'accountId': accountId,
      'schoolId': schoolId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}