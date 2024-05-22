part of 'theme_setting_cubit.dart';

class ThemeSettingState extends Equatable {
  const ThemeSettingState(
      {this.themeMode = ThemeMode.light}); // Default theme = light theme

  final ThemeMode themeMode;

  // `copyWith()` method allows us to emit brand new instance of ThemeState
  ThemeSettingState copyWith({ThemeMode? themeMode}) => ThemeSettingState(
        themeMode: themeMode ?? this.themeMode,
      );

  @override
  List<Object?> get props => [themeMode];
}
