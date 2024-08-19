import '../../models/user_changepass.dart';

abstract class ChangePassState {}

class ChangePassInitial extends ChangePassState {}

class ChangePassLoading extends ChangePassState {}

class ChangePassSuccess extends ChangePassState {
  final UserChangePass userChangePass;

  ChangePassSuccess(this.userChangePass);
}

class ChangePassFailure extends ChangePassState {
  final String error;

  ChangePassFailure(this.error);
}

class EmailError extends ChangePassState {
  final String error;

  EmailError(this.error);
}
