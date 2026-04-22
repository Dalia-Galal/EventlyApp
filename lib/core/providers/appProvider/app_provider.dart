import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  final SharedPreferences _prefs;

  AppProvider(this._prefs) {
    loadSettings();
  }

  ThemeMode _currentThemeMode = ThemeMode.light;
   String _currentLanguage = "en";

  ThemeMode get currentThemeMode => _currentThemeMode;
  String get currentLanguage=>_currentLanguage;


  void loadSettings() {

    final isDark = _prefs.getBool('isDark') ?? false;
    final isEnglish = _prefs.getBool('isEnglish')?? true;
    _currentThemeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _currentLanguage= isEnglish ?'en':'ar';
    hasSeenOnboarding = _prefs.getBool('hasSeenOnboarding') ?? false;
    notifyListeners();
  }

  void changeCurrentThemeMode(ThemeMode mode) async {

    if (mode == _currentThemeMode) return;
    await _prefs.setBool('isDark', mode == ThemeMode.dark);
    _currentThemeMode = mode;

    notifyListeners();
  }
  void changeCurrentLanguage(String newLanguage) async {

    if (newLanguage == _currentLanguage) return;
    await _prefs.setBool('isEnglish', newLanguage == 'en');
    _currentLanguage = newLanguage;

    notifyListeners();
  }
  bool  get isDark => _currentThemeMode == ThemeMode.dark;
  bool get isEnglish => _currentLanguage =='en';

  bool hasSeenOnboarding = false;

  Future<void> setOnboardingSeen() async {
    hasSeenOnboarding = true;
    await _prefs.setBool('hasSeenOnboarding', true);
    notifyListeners();
  }

  Future<void> getOnboardingSeen() async {
    hasSeenOnboarding = _prefs.getBool('hasSeenOnboarding') ?? false;
    notifyListeners();
  }
}
