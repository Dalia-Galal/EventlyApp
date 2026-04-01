
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    loadTheme();
  }
  ThemeMode _currentThemeMode = ThemeMode.light;

  ThemeMode get currentThemeMode => _currentThemeMode;

  void loadTheme()async{
    final preferences = await SharedPreferences.getInstance();
    final isDark = preferences.getBool('isDark') ?? false;
    _currentThemeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  void changeCurrentThemeMode(ThemeMode value) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();

    if (value == _currentThemeMode) return;
    await prefs.setBool('isDark',value==ThemeMode.dark);
    _currentThemeMode = value;

    notifyListeners();
  }
  bool isDark() => _currentThemeMode == ThemeMode.dark;


}
