part of 'forgot_pass_cubit.dart';

@immutable
abstract class ForgotPassState {}

class ForgotPassInitial extends ForgotPassState {}

class ForgotPassLoading extends ForgotPassState {}

class ForgotPassSuccess extends ForgotPassState {
  final UserForgotpass userForgotpass;

  ForgotPassSuccess(this.userForgotpass);
}

class ForgotPassFailure extends ForgotPassState {
  final String error;

  ForgotPassFailure(this.error);
}

class EmailError extends ForgotPassState {
  final String error;

  EmailError(this.error);
}
