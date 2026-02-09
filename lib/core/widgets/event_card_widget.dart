import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/constants/app_strings.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../gen/assets.gen.dart';

class EventCardWidget extends StatelessWidget {
  final EventDataModel dataModel;
  final Function onTap;
  const EventCardWidget({super.key, required this.dataModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = false;
    return GestureDetector(
      onTap:(){onTap.call();},
      child: Container(
        width: double.infinity,
        height: 193,
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(dataModel.eventCategoryLightImage),
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
              child: Text(DateFormat('dd MMM').format(dataModel.eventDate)),
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
                  Expanded(child: Text(dataModel.eventDescription)),
                  (dataModel.isFavorite==true)
                      ? Assets.icons.heartSelected.svg()
                      : Assets.icons.heartUnSelected.svg(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
