import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/repository/repository.dart';
import 'package:kltn_mobile/models/user_login.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final APIRepository _apiRepository;

  LoginCubit(this._apiRepository) : super(LoginInitial());

  void checkEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(email)) {
      print("Email checked");
      emit(EmailError('Vui lòng nhập đúng định dạng email'));
    } else {
      emit(LoginInitial());
    }
  }

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      UserAuthLogin? userAuthLogin =
          await _apiRepository.login(email, password);
      // ignore: unnecessary_null_comparison
      if (userAuthLogin != null && userAuthLogin.error == null) {
        emit(LoginSuccess(userAuthLogin));
      } else {
        emit(LoginFailure(userAuthLogin?.error ?? 'Failed to login'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
