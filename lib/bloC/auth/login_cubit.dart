import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/Model/user_login.dart';
import 'package:kltn_mobile/bloC/repository/repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final APIRepository _apiRepository;

  LoginCubit(this._apiRepository) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      UserAuthLogin? userAuthLogin = await _apiRepository.login(email, password);
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