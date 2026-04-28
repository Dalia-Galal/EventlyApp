import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/services/snack_bar_services.dart';
import 'package:evently/utils/firestore_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';

class EventCardWidget extends StatefulWidget {
  final EventDataModel dataModel;
  final Function onTap;
  const EventCardWidget({
    super.key,
    required this.dataModel,
    required this.onTap,
  });

  @override
  State<EventCardWidget> createState() => _EventCardWidgetState();
}

class _EventCardWidgetState extends State<EventCardWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        widget.onTap.call();
      },
      child: Container(
        width: double.infinity,
        height: 193,
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              provider.isDark
                  ? widget.dataModel.eventCategoryDarkImage
                  : widget.dataModel.eventCategoryLightImage,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: provider.isDark
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
                  color: provider.isDark
                      ? ColorPalette.strokeDarkColor
                      : ColorPalette.strokeLightColor,
                ),
                borderRadius: BorderRadius.circular(8),
                color: provider.isDark
                    ? ColorPalette.backgroundDarkColor
                    : ColorPalette.backgroundLightColor,
              ),
              child: Text(
                DateFormat('dd MMM').format(widget.dataModel.eventDate),
                style: theme.textTheme.titleMedium!.copyWith(
                  color: provider.isDark
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
                  color: provider.isDark
                      ? ColorPalette.strokeDarkColor
                      : ColorPalette.strokeLightColor,
                ),
                borderRadius: BorderRadius.circular(8),
                color: provider.isDark
                    ? ColorPalette.backgroundDarkColor
                    : ColorPalette.backgroundLightColor,
              ),
              child: Row(
                children: [
                  Expanded(child: Text(widget.dataModel.eventDescription)),

                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        widget.dataModel.isFavorite =
                        !widget.dataModel.isFavorite;
                      });
                      try {
                        await FirestoreUtils.updateEvent(widget.dataModel);

                      } catch (e) {  setState(() {
                        widget.dataModel.isFavorite =
                        !widget.dataModel.isFavorite;
                      });
                      SnackBarServices.showErrorMessage('Failed to update, please try again');}
                    },
                    child: (widget.dataModel.isFavorite)
                        ? Assets.icons.heartSelected.svg(
                            colorFilter: ColorFilter.mode(
                              provider.isDark
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
