import 'package:evently/core/app_theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void config(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.black
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.white
    ..indicatorColor = ColorPalette.primaryLightColor
    ..textColor = ColorPalette.primaryLightColor
    ..userInteractions = false
    ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
}