part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserAuthLogin userAuthLogin;

  LoginSuccess(this.userAuthLogin);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}