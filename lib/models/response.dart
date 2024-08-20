class ResponseModel {
  final String? message;
  final ErrorModel? error;

  ResponseModel({this.message, this.error});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      message: json['message'],
      error: json['error'] != null ? ErrorModel.fromJson(json['error']) : null,
    );
  }
}

class ErrorModel {
  final List<IssueModel> issues;

  ErrorModel({required this.issues});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    var issuesList = json['issues'] as List;
    List<IssueModel> issues =
        issuesList.map((i) => IssueModel.fromJson(i)).toList();
    return ErrorModel(issues: issues);
  }
}

class IssueModel {
  final String code;
  final int minimum;
  final String type;
  final bool inclusive;
  final bool exact;
  final String message;
  final List<String> path;

  IssueModel({
    required this.code,
    required this.minimum,
    required this.type,
    required this.inclusive,
    required this.exact,
    required this.message,
    required this.path,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) {
    var pathList = json['path'] as List;
    List<String> path = pathList.map((i) => i.toString()).toList();
    return IssueModel(
      code: json['code'],
      minimum: json['minimum'],
      type: json['type'],
      inclusive: json['inclusive'],
      exact: json['exact'],
      message: json['message'],
      path: path,
    );
  }
}
