import 'package:flutter/material.dart';
import '../app_theme/color_palette.dart';
import '../constants/app_strings.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String? buttonText;
  final void Function()? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Widget? customChild;
  const ElevatedButtonWidget({
    super.key,
    this.buttonText,
   required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.customChild,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorPalette.primaryLightColor,
        foregroundColor: foregroundColor ?? ColorPalette.primaryDarkTextColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
        child:
            customChild ??
            Text(
              buttonText!,
              style: theme.textTheme.titleLarge?.copyWith(
                color: ColorPalette.primaryDarkTextColor,
              ),
            ),
      ),
    );
  }
}
