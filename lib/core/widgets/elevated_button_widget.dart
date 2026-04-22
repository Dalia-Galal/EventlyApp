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
  final bool isOnboardingSetting;
  final bool? isTheme;
  final bool? isSelected;
  const ElevatedButtonWidget({
    super.key,
    this.buttonText,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.customChild,
    this.isOnboardingSetting = false,
    this.isTheme = false,
    this.isSelected = false,
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
            : isSelected!
            ? ColorPalette.primaryDarkTextColor
            : backgroundColor ?? ColorPalette.primaryLightColor,
        foregroundColor: isDark
            ? foregroundColor ?? ColorPalette.primaryDarkColor
            : foregroundColor ?? ColorPalette.primaryDarkTextColor,
        side: BorderSide(
          color: isDark
              ? ColorPalette.strokeDarkColor
              : ColorPalette.strokeLightColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(
            isOnboardingSetting ? 8 : 16,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
        child:
            customChild ??
            Text(
              buttonText!,
              style: isOnboardingSetting
                  ? theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: isSelected! && !provider.isDark
                          ? ColorPalette.primaryLightColor
                          : isSelected! && !provider.isDark
                          ? ColorPalette.primaryDarkTextColor
                          : ColorPalette.secondaryDarkTextColor,
                    )
                  : theme.textTheme.titleLarge?.copyWith(
                      color: ColorPalette.primaryDarkTextColor,
                    ),
            ),
      ),
    );
  }
}
