import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/appProvider/app_provider.dart';
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
    final provider = Provider.of<AppProvider>(context);
    bool isDark = provider.currentThemeMode == ThemeMode.dark;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark
            ? backgroundColor ?? ColorPalette.primaryDarkColor
            : backgroundColor ?? ColorPalette.primaryLightColor,
        foregroundColor: isDark
            ? foregroundColor ?? ColorPalette.primaryLightTextColor
            : foregroundColor ?? ColorPalette.primaryDarkTextColor,
        side: BorderSide(color: isDark?ColorPalette.strokeDarkColor:ColorPalette.strokeLightColor)
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
