import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 193,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.birthdayLight.provider(),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorPalette.strokeLightColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: ColorPalette.strokeLightColor),
              borderRadius: BorderRadius.circular(8),
              color: ColorPalette.backgroundLightColor,
            ),
            child: Text('24 Jan'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: ColorPalette.strokeLightColor),
              borderRadius: BorderRadius.circular(8),
              color: ColorPalette.backgroundLightColor,
            ),
            child: Row(
              children: [
                Expanded(child: Text('This is a Birthday Party')),
                Assets.icons.heartSelected.svg(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
