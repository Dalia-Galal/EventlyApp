import 'package:flutter/material.dart';

import '../../core/app_theme/color_palette.dart';
import '../../core/constants/app_strings.dart';
import '../../gen/assets.gen.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(AppStrings.eventDetails),
        centerTitle: true,
        actions: [
          Assets.icons.edit.svg(),
          SizedBox(width: 10),
          Assets.icons.trash.svg(),
        ],
        actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorPalette.primaryDarkTextColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorPalette.strokeLightColor),
                image: DecorationImage(
                  image: Assets.images.birthdayLight.provider(),
                ),
              ),
            ),
            Text('We’re going to play football '),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorPalette.primaryDarkTextColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorPalette.strokeLightColor),
              ),
              child: Row(
                spacing: 20,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ColorPalette.backgroundLightColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorPalette.strokeLightColor),
                    ),
                    child: Assets.icons.calendarLight.svg(
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text('January', style: theme.textTheme.titleMedium),
                      Text(
                        '12.12pm',
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: ColorPalette.disabledColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(AppStrings.description),
            Container(
              padding: const EdgeInsets.all(16),
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorPalette.primaryDarkTextColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorPalette.strokeLightColor),
              ),
              child: Text(
                'Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.',
                style: theme.textTheme.titleSmall,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
