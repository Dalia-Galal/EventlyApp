import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomContainerWidget extends StatelessWidget {
  final String text;
  final Widget customWidget;
  const CustomContainerWidget({
    super.key,
    required this.text,
    required this.customWidget,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final provider = Provider.of<AppProvider>(context);
    bool isDark = provider.currentThemeMode == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color:isDark? ColorPalette.primaryDarkTextFieldColor:ColorPalette.primaryDarkTextColor,
          border: Border.all(color:isDark?ColorPalette.strokeDarkColor: ColorPalette.strokeLightColor),
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12.0),
             child: Text( text,style: isDark? theme.textTheme.bodyMedium!.copyWith(color: ColorPalette.primaryDarkTextColor):theme.textTheme.bodyMedium,),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 12.0),
             child: customWidget,
           ),
          ],
        ),
      ),
    );
  }
}
