import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/screens/Authentication/auth_data_notify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kltn_mobile/blocs/repository/repository.dart';
import 'package:kltn_mobile/models/user_login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final APIRepository _apiRepository;
  late SharedPreferences logindata;
  UserAuthLogin? userAuthLogin;

  LoginCubit(this._apiRepository)
      : super(LoginCheckSessionState(isLoggedIn: false)) {
    checkLoginStatus();
  }

  Future<UserAuthLogin?> checkLoginStatus() async {
    logindata = await SharedPreferences.getInstance();
    final userString = logindata.getString('user');
    final token = logindata.getString('token');
    final isRemember = logindata.getBool('isRememberChange') ?? false;

    if (token != null && isRemember && userString != null) {
      userAuthLogin = UserAuthLogin.fromJson(jsonDecode(userString));
      emit(LoginCheckSessionState(isLoggedIn: true, token: token));
    } else {
      userAuthLogin = null;
      await logindata.remove('user'); // Xóa dữ liệu user nếu không có token
      emit(LoginCheckSessionState(isLoggedIn: false));
    }
    return userAuthLogin;
  }

  Future<void> login(
      String email, String password, bool isRememberChange) async {
    emit(LoginLoading());
    try {
      UserAuthLogin? userAuthLogin =
          await _apiRepository.login(email, password);
      if (userAuthLogin != null && userAuthLogin.error == null) {
        this.userAuthLogin = userAuthLogin;
        logindata = await SharedPreferences.getInstance();

        if (isRememberChange) {
          await logindata.setString('token', userAuthLogin.token); // Lưu token
        }
        await logindata.setString(
            'user', jsonEncode(userAuthLogin.toJson())); // Lưu userAuthLogin
        await logindata.setBool('isRememberChange', isRememberChange);

        emit(LoginSuccess(userAuthLogin));
      } else {
        await logindata.setString('user', jsonEncode(userAuthLogin?.toJson()));
        emit(LoginFailure(userAuthLogin?.error ?? 'Failed to login'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> logout(BuildContext context) async {
    logindata = await SharedPreferences.getInstance();
    await logindata.remove('token');
    await logindata.remove('user');
    await logindata.remove('isRememberChange');
    // ignore: use_build_context_synchronously
    context.read<UserAuthProvider>().setUserAuthLogin(null);
    print(userAuthLogin);
    emit(LoginInitial());
  }

  void checkEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(email)) {
      emit(EmailError('Vui lòng nhập đúng định dạng email'));
    } else {
      emit(LoginInitial());
    }
  }
}
