import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeRepo {
  Stream<CustomTheme> getTheme();
  Future<void> saveTheme(CustomTheme theme);
  void dispose();
}

enum CustomTheme { light, dark }

class ThemeRepository implements ThemeRepo {
  ThemeRepository({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences {
    _init();
  }

  final SharedPreferences _sharedPreferences;

  static const _kThemePersistenceKey = '__theme_persistence_key__';

  final _controller = StreamController<CustomTheme>();

  String? _getValue(String key) {
    try {
      return _sharedPreferences.getString(key);
    } catch (_) {
      return null;
    }
  }

  Future<void> _setValue(String key, String value) =>
      _sharedPreferences.setString(key, value);

  void _init() {
    final themeString = _getValue(_kThemePersistenceKey);
    if (themeString != null) {
      if (themeString == CustomTheme.light.name) {
        _controller.add(CustomTheme.light);
      } else {
        _controller.add(CustomTheme.dark);
      }
    } else {
      _controller.add(CustomTheme.light);
    }
  }

  @override
  Stream<CustomTheme> getTheme() async* {
    yield* _controller.stream;
  }

  @override
  Future<void> saveTheme(CustomTheme theme) {
    _controller.add(theme);
    return _setValue(_kThemePersistenceKey, theme.name);
  }

  @override
  void dispose() => _controller.close();
}
