import 'package:flutter/material.dart';

enum AppThemeMode { light, dark, system }

class ThemeController extends ChangeNotifier {
  AppThemeMode _themeMode = AppThemeMode.dark; // Default for Neo Brutalism

  AppThemeMode get themeMode => _themeMode;

  ThemeMode get flutterThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  void setThemeMode(AppThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
      // TODO: Save selection to shared preferences or secure storage
    }
  }
}
