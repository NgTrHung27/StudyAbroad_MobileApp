// FILE:LANGUAGE_BLOC.DART
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LanguageEvent { setEnglish, setKorean, setVietnamese }

class LanguageBloc extends Bloc<LanguageEvent, Locale> {
  LanguageBloc() : super(const Locale('en')) {
    _loadLanguageFromPrefs().then((locale) => add(_eventFromLocale(locale)));
    on<LanguageEvent>(_onEvent);
  }

  Future<Locale> _loadLanguageFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en';
    return Locale(languageCode);
  }

  LanguageEvent _eventFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEvent.setEnglish;
      case 'ko':
        return LanguageEvent.setKorean;
      case 'vi':
        return LanguageEvent.setVietnamese;
      default:
        return LanguageEvent.setEnglish;
    }
  }

  void _onEvent(LanguageEvent event, Emitter<Locale> emit) async {
    switch (event) {
      case LanguageEvent.setEnglish:
        await _saveLanguageToPrefs('en');
        emit(const Locale('en'));
        break;
      case LanguageEvent.setKorean:
        await _saveLanguageToPrefs('ko');
        emit(const Locale('ko'));
        break;
      case LanguageEvent.setVietnamese:
        await _saveLanguageToPrefs('vi');
        emit(const Locale('vi'));
        break;
    }
  }

  Future<void> _saveLanguageToPrefs(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }

  Future<String> getCurrentLanguageCode() async {
    final locale = await _loadLanguageFromPrefs();
    return locale.languageCode;
  }
}
