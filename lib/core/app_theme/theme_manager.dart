import 'package:evently/core/app_theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';

abstract class ThemeManager {
  static ThemeData themeDataLight = ThemeData(
    scaffoldBackgroundColor: ColorPalette.backgroundLightColor,
    primaryColor: ColorPalette.primaryLightColor,
    useMaterial3: true,
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: ColorPalette.primaryLightColor,
      ),
      titleLarge: TextStyle(
        fontFamily: FontFamily.poppins,
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
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w400,
        color: ColorPalette.primaryLightTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.poppins,
        color: ColorPalette.primaryLightTextColor,
      ),
      bodySmall: TextStyle(fontSize: 12),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorPalette.primaryDarkTextColor,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: const IconThemeData(size: 24),
      unselectedIconTheme: const IconThemeData(size: 12),
      selectedItemColor: ColorPalette.primaryLightColor,
      unselectedItemColor: ColorPalette.disabledColor,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPalette.primaryLightColor,
        foregroundColor: ColorPalette.primaryDarkTextColor,
        side: BorderSide(color: ColorPalette.strokeLightColor),
        // ColorPalette.strokeDarkColor:
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorPalette.primaryLightColor,
      foregroundColor: ColorPalette.primaryDarkTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(50),
      ),
    ),
  );

  static ThemeData themeDataDark = ThemeData(
    scaffoldBackgroundColor: ColorPalette.backgroundDarkColor,
    primaryColor: ColorPalette.primaryDarkColor,
    useMaterial3: true,
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: ColorPalette.primaryDarkTextColor,
      ),
      titleLarge: TextStyle(
        fontFamily: FontFamily.poppins,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: ColorPalette.primaryDarkTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: ColorPalette.primaryDarkTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontFamily: FontFamily.poppins,
        fontWeight: FontWeight.w400,
        color: ColorPalette.secondaryDarkTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.poppins,
        color: ColorPalette.secondaryDarkTextColor,
      ),
      bodySmall: TextStyle(fontSize: 12),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorPalette.backgroundDarkColor,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: const IconThemeData(size: 24),
      unselectedIconTheme: const IconThemeData(size: 12),
      selectedItemColor: ColorPalette.primaryDarkColor,
      unselectedItemColor: ColorPalette.disabledColor,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPalette.primaryDarkTextFieldColor,
        foregroundColor: ColorPalette.primaryLightColor,
        side: BorderSide(color: ColorPalette.strokeDarkColor, ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorPalette.primaryDarkColor,
      foregroundColor: ColorPalette.primaryDarkTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(50),
      ),
    ),
  );
}
