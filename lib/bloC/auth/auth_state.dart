import 'package:kltn_mobile/Model/school.dart';
import 'package:kltn_mobile/Model/vn_country.dart';

abstract class AuthState  {}

class AuthLoadingState extends AuthState{
}

class AuthLoadedNamedSchoolState extends AuthState{
  final List<School>? school;
  AuthLoadedNamedSchoolState(this.school);
}
class AuthErrorNamedSchoolState extends AuthState{
  String? message;
  AuthErrorNamedSchoolState(this.message);
}
class AuthLoadedCityState extends AuthState{
  final List<City>? city;
  AuthLoadedCityState(this.city);
}
class AuthErrorCityState extends AuthState{
  String? message;
  AuthErrorCityState(this.message);
}