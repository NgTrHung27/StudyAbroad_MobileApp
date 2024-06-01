import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/bloC/lang/language_bloc.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  @override
  void initState() {
    super.initState();
    _loadLanguage();
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
}
