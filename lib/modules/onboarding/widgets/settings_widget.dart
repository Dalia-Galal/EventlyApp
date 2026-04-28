import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/elevated_button_widget.dart';

class SettingsWidget extends StatefulWidget {
  final String title;
  final String? firstButton;
  final String? secondButton;
  final bool? isTheme;
  final Function onFirstButtonPressed;
  final Function onSecondButtonPressed;
  final SvgPicture? sunIcon;
  final SvgPicture? moonIcon;
  final bool isFirstButtonSelected;
  final bool isSecondButtonSelected;
  const SettingsWidget({
    super.key,
    this.firstButton,
    this.secondButton,
    required this.title,
    this.isTheme = false,
    this.sunIcon,
    this.moonIcon,
    required this.onFirstButtonPressed,
    required this.onSecondButtonPressed,
    required this.isFirstButtonSelected,
    required this.isSecondButtonSelected,
  });

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Row(
      spacing: 20,
      children: [
        Expanded(child: Text(widget.title)),

        Expanded(
          child: ElevatedButtonWidget(
            key: ValueKey(widget.firstButton),
            buttonText: widget.firstButton,
            isSelected: widget.isFirstButtonSelected ? false : true,
            backgroundColor: provider.isDark && widget.isFirstButtonSelected
                ? ColorPalette.primaryDarkColor
                : provider.isDark && !widget.isFirstButtonSelected
                ? ColorPalette.primaryDarkTextFieldColor
                : null,
            foregroundColor: provider.isDark && widget.isFirstButtonSelected
                ? ColorPalette.primaryDarkTextColor
                : provider.isDark && !widget.isFirstButtonSelected
                ? ColorPalette.primaryDarkColor
                : null,
            isOnboardingSetting: true,
            isTheme: widget.isTheme,
            customChild: widget.sunIcon,
            onPressed: () {
              widget.onFirstButtonPressed.call();
            },
          ),
        ),
        Expanded(
          child: ElevatedButtonWidget(
            key: ValueKey(widget.secondButton),
            buttonText: widget.secondButton,
            isSelected: widget.isSecondButtonSelected ? false : true,
            isOnboardingSetting: true,
            isTheme: widget.isTheme,
            customChild: widget.moonIcon,
            backgroundColor: provider.isDark && widget.isSecondButtonSelected
                ? ColorPalette.primaryDarkColor
                : provider.isDark && !widget.isSecondButtonSelected
                ? ColorPalette.primaryDarkTextFieldColor
                : null,
            foregroundColor: provider.isDark && widget.isSecondButtonSelected
                ? ColorPalette.primaryDarkTextColor
                : provider.isDark && !widget.isSecondButtonSelected
                ? ColorPalette.primaryLightColor
                : null,
            onPressed: () {
              widget.onSecondButtonPressed.call();
            },
          ),
        ),
      ],
    );
  }
}
