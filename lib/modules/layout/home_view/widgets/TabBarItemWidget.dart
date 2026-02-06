import 'package:evently/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme/color_palette.dart';
import '../../../../gen/assets.gen.dart';

class TabBarItemWidget extends StatelessWidget {
  const TabBarItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical:  16),
      decoration: BoxDecoration(
        color: ColorPalette.primaryDarkTextColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorPalette.strokeLightColor),

      ),
      child: Row(
        spacing: 8,
        children: [
      Assets.icons.sportLight.svg(width: 24,
      height: 24),

          Text('Sport',style: theme.textTheme.titleMedium,)
      ],),
    ) ;
  }
}
