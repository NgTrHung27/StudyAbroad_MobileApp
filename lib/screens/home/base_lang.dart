import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/login_cubit.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kltn_mobile/models/user_login.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  UserAuthLogin? userAuth;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _loadUserAuth();
  }

  Future<void> _loadLanguage() async {
    final languageCode =
        await context.read<LanguageBloc>().getCurrentLanguageCode();
    switch (languageCode) {
      case 'en':
        // ignore: use_build_context_synchronously
        context.read<LanguageBloc>().add(LanguageEvent.setEnglish);
        break;
      case 'ko':
        // ignore: use_build_context_synchronously
        context.read<LanguageBloc>().add(LanguageEvent.setKorean);
        break;
      case 'vi':
        // ignore: use_build_context_synchronously
        context.read<LanguageBloc>().add(LanguageEvent.setVietnamese);
        break;
    }
  }

  Future<void> _loadUserAuth() async {
    final logindata = await SharedPreferences.getInstance();
    final userString = logindata.getString('user');
    final isRemember = logindata.getBool('isRememberChange') ??
        false; // Lấy trạng thái isRememberChange
    setState(() {
      if (userString != null && isRemember) {
        // Kiểm tra nếu có thông tin đăng nhập và isRememberChange là true
        userAuth = UserAuthLogin.fromJson(jsonDecode(userString));
        isLoggedIn = true;
      } else if (userString != null) {
        userAuth = UserAuthLogin.fromJson(jsonDecode(userString));
        isLoggedIn = true;
      } else {
        // Nếu isRememberChange là false, không lấy thông tin đăng nhập từ SharedPreferences
        userAuth = null;
        isLoggedIn = false;
      }
      print('Check isRemember Data Base: $isRemember');
      print('Check Data Base: $userAuth');
    });
  }
}
