import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/constant/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_setting_state.dart';

class ThemeSettingCubit extends Cubit<ThemeData> {
  ThemeSettingCubit() : super(AppTheme.lightTheme) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    emit(isDarkMode ? AppTheme.blackTheme : AppTheme.lightTheme);
  }

  Future<void> toggleTheme() async {
    if (state == AppTheme.lightTheme) {
      emit(AppTheme.blackTheme);
      _saveTheme(true);
    } else { 
      emit(AppTheme.lightTheme);
      _saveTheme(false);
    }
  }

  Future<void> _saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }
}