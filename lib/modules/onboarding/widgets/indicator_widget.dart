import 'package:evently/core/app_theme/color_palette.dart';
import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  final bool isActive;
  const IndicatorWidget({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? ColorPalette.primaryLightColor
            : ColorPalette.disabledColor,
        borderRadius: BorderRadiusGeometry.circular(36)
      ),
      
    );
  }
}
