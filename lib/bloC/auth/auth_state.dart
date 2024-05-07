import 'package:kltn_mobile/Model/country.dart';
import 'package:kltn_mobile/Model/schools.dart';

abstract class AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedNamedSchoolState extends AuthState {
  final List<Schools> school;
  AuthLoadedNamedSchoolState(this.school);
}

class AuthErrorNamedSchoolState extends AuthState {
  String? message;
  AuthErrorNamedSchoolState(this.message);
}

class AuthLoadedCityState extends AuthState {
  final List<Country> country;
  AuthLoadedCityState(this.country);
}

class AuthErrorCityState extends AuthState {
  String? message;
  AuthErrorCityState(this.message);
}
