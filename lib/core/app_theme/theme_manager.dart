import 'package:evently/core/app_theme/color_palette.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  ThemeData themeDataLight = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    useMaterial3: true,
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: ColorPalette.primaryLightTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: ColorPalette.primaryLightTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: ColorPalette.primaryLightTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorPalette.primaryLightTextColor
      ),
      bodySmall: TextStyle(
        fontSize: 12,
      )
    )
  );
}