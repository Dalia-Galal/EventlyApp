import 'package:evently/core/app_theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';

abstract class ThemeManager {
  static ThemeData themeDataLight = ThemeData(
    scaffoldBackgroundColor:ColorPalette.backgroundLightColor,
    primaryColor:ColorPalette.primaryLightColor,
    useMaterial3: true,
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontFamily:'Poppins',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: ColorPalette.primaryLightColor,
      ),
      titleLarge: TextStyle(
        fontFamily:FontFamily.poppins,
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
          fontFamily:FontFamily.poppins,
        fontWeight: FontWeight.w400,
        color: ColorPalette.primaryLightTextColor
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.poppins,
        color: ColorPalette.primaryLightColor
      ),
      bodySmall: TextStyle(
        fontSize: 12,
      )
    )
  );
}