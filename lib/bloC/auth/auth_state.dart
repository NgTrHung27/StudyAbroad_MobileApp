import 'package:kltn_mobile/Model/school.dart';

abstract class AuthState  {}

class AuthLoadingState extends AuthState{
}

class AuthLoadedState extends AuthState{
  final List<School>? school;
  AuthLoadedState(this.school);
}

class AuthErorrState extends AuthState{
  String? message;
  AuthErorrState(this.message);
}