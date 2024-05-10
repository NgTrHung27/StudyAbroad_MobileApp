import 'package:kltn_mobile/Model/country.dart';
import 'package:kltn_mobile/Model/schools.dart';

abstract class AuthState {}
//Suceess
class AuthInitialState extends AuthState {}
class AuthLoadingState extends AuthState {}
class AuthSuccessState extends AuthState {}

//Email
class AuthErrorEmailState extends AuthState {
  String? message;
  AuthErrorEmailState(this.message);
}
//Password
class AuthErrorPasswordState extends AuthState {
  String? message;
  AuthErrorPasswordState(this.message);
}
//DOB
class AuthErrorDOBState extends AuthState {
  String? message;
  AuthErrorDOBState(this.message);
}
//Gender
class AuthErrorGenderErrorState extends AuthState {
  String? message;
  AuthErrorGenderErrorState(this.message);
}
//Phone
class AuthErrorPhoneState extends AuthState {
  String? message;
  AuthErrorPhoneState(this.message);
}
//IDCard
class AuthErrorIDCardNumberState extends AuthState {
  String? message;
  AuthErrorIDCardNumberState(this.message);
}
//City - District - Ward
class AuthLoadedCityState extends AuthState {
  final List<Country> country;
  AuthLoadedCityState(this.country);
}
class AuthErrorCityState extends AuthState {
  String? message;
  AuthErrorCityState(this.message);
}
class AuthErrorDistrictState extends AuthState {
  String? message;
  AuthErrorDistrictState(this.message);
}
class AuthErrorWardState extends AuthState {
  String? message;
  AuthErrorWardState(this.message);
}
//School - Program
class AuthLoadedNamedSchoolState extends AuthState {
  final List<Schools> school;
  AuthLoadedNamedSchoolState(this.school);
}
class AuthErrorNamedSchoolState extends AuthState {
  String? message;
  AuthErrorNamedSchoolState(this.message);
}
class AuthErrorProgramState extends AuthState {
  String? message;
  AuthErrorProgramState(this.message);
}
//Degree - Certificate - CertifcateIMG
class AuthErrorDegreeTypeState extends AuthState{
  String? message;
  AuthErrorDegreeTypeState(this.message);
}
class AuthErrorCertificateTypeState extends AuthState{
  String? message;
  AuthErrorCertificateTypeState(this.message);
} 
class AuthErrorCertificateImgState extends AuthState{
  String? message;
  AuthErrorCertificateImgState(this.message);
}
//GradeType - GradeScore
class AuthErrorGradeTypeState extends AuthState{
  String? message;
  AuthErrorGradeTypeState(this.message);
}
class AuthErrorGradeScore extends AuthState{
  String? message;
  AuthErrorGradeScore(this.message);
}
//Error API
class AuthErrorState extends AuthState {
  String? message;
  AuthErrorState(this.message);
}

