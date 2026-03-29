import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/constants/app_strings.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/modules/appProvider/app_provider.dart';
import 'package:evently/utils/firestore_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';

class EventCardWidget extends StatelessWidget {
  final EventDataModel dataModel;
  final Function onTap;
  const EventCardWidget({
    super.key,
    required this.dataModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    final bool isFavorite = false;
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: double.infinity,
        height: 193,
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              provider.isDark()
                  ? dataModel.eventCategoryDarkImage
                  : dataModel.eventCategoryLightImage,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: provider.isDark()
                ? ColorPalette.strokeDarkColor
                : ColorPalette.strokeLightColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: provider.isDark()
                      ? ColorPalette.strokeDarkColor
                      : ColorPalette.strokeLightColor,
                ),
                borderRadius: BorderRadius.circular(8),
                color: provider.isDark()
                    ? ColorPalette.backgroundDarkColor
                    : ColorPalette.backgroundLightColor,
              ),
              child: Text(
                DateFormat('dd MMM').format(dataModel.eventDate),
                style: theme.textTheme.titleMedium!.copyWith(
                  color: provider.isDark()
                      ? ColorPalette.primaryDarkColor
                      : ColorPalette.primaryLightTextColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: provider.isDark()
                      ? ColorPalette.strokeDarkColor
                      : ColorPalette.strokeLightColor,
                ),
                borderRadius: BorderRadius.circular(8),
                color: provider.isDark()
                    ? ColorPalette.backgroundDarkColor
                    : ColorPalette.backgroundLightColor,
              ),
              child: Row(
                children: [
                  Expanded(child: Text(dataModel.eventDescription)),

                  GestureDetector(
                    onTap: () {
                      dataModel.isFavorite = !dataModel.isFavorite;
                      FirestoreUtils.updateEvent(dataModel);
                    },
                    child: (dataModel.isFavorite)
                        ? Assets.icons.heartSelected.svg(
                            colorFilter: ColorFilter.mode(
                              provider.isDark()
                                  ? ColorPalette.primaryDarkColor
                                  : ColorPalette.primaryLightColor,
                              BlendMode.srcIn,
                            ),
                          )
                        : Assets.icons.heartUnSelected.svg(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
