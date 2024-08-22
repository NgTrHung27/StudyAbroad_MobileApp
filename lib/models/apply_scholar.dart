class ApplyScholarModel {
  final String? success;
  final String? error;

  ApplyScholarModel({this.success, this.error});

  factory ApplyScholarModel.fromJson(Map<String, dynamic> json) {
    return ApplyScholarModel(
      success: json['success'] as String?,
      error: json['error'] as String?,
    );
  }
}
