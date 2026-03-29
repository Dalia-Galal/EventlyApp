
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode _currentThemeMode = ThemeMode.light;

  ThemeMode get currentThemeMode => _currentThemeMode;

  void changeCurrentThemeMode(ThemeMode value) {
    if (value == _currentThemeMode) return;
    _currentThemeMode = value;
    notifyListeners();
  }
  bool isDark() => _currentThemeMode == ThemeMode.dark;

}
