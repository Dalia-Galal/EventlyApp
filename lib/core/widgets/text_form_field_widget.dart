import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../app_theme/color_palette.dart';
import '../constants/app_strings.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TextFormField(
      decoration: InputDecoration(
        hintText: AppStrings.enterYourEmail,

        prefixIcon: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: prefixIcon,
        ),
        suffixIcon: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: suffixIcon,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorPalette.strokeLightColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorPalette.strokeLightColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPalette.strokeLightColor,
            width: 1,
          ),
          gapPadding: 50,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),

      style: theme.textTheme.titleSmall,
    );
  }
}
