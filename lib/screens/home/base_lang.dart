import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kltn_mobile/models/user_login.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  UserAuthLogin? userAuth;

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
    if (userString != null) {
      setState(() {
        userAuth = UserAuthLogin.fromJson(jsonDecode(userString));
        print('User Auth: $userAuth'); // Debug User Auth (User Login)
        print('User Auth NameSchool: ${userAuth?.student.school.name}');
        print('User Auth BGImage: ${userAuth?.student.school.background}');
        print(
            'User Auth LogoImage: ${userAuth?.student.school.logo}'); // Debug User Auth ID (User Login ID
      });
    }
  }
}
