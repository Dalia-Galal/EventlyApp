import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/utils/firestore_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/app_theme/color_palette.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/providers/appProvider/app_provider.dart';
import '../../gen/assets.gen.dart';
import '../../models/event_data_model.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    EventDataModel eventData =
        ModalRoute.of(context)!.settings.arguments as EventDataModel;
    final theme = Theme.of(context);
    final provider = Provider.of<AppProvider>(context);
    var appLocal = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(appLocal!.eventDetails),
        centerTitle: true,
        foregroundColor: provider.isDark
            ? ColorPalette.primaryDarkTextColor
            : ColorPalette.primaryLightColor,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                PagesRouteName.editEvent,
                arguments: eventData,
              );
            },
            child: provider.isDark?Assets.icons.edit2.svg():Assets.icons.edit.svg(),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              FirestoreUtils.deleteEvent(eventData);
              Navigator.pop(context, PagesRouteName.layout);
            },
            child: Assets.icons.trash.svg(),
          ),
        ],
        actionsPadding: const EdgeInsets.symmetric(horizontal: 24),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: provider.isDark
                      ? ColorPalette.backgroundDarkColor
                      : ColorPalette.primaryDarkTextColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: provider.isDark
                        ? ColorPalette.strokeDarkColor
                        : ColorPalette.strokeLightColor,
                  ),
                  image: DecorationImage(
                    image: provider.isDark
                        ? AssetImage(eventData.eventCategoryDarkImage)
                        : AssetImage(eventData.eventCategoryLightImage),
                    fit: BoxFit.cover
                  ),
                ),
              ),
              Text(eventData.eventTitle),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: provider.isDark
                      ? ColorPalette.primaryDarkTextFieldColor
                      : ColorPalette.primaryDarkTextColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: provider.isDark
                        ? ColorPalette.strokeDarkColor
                        : ColorPalette.strokeLightColor,
                  ),
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
                        color: provider.isDark
                            ? ColorPalette.backgroundDarkColor
                            : ColorPalette.backgroundLightColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: provider.isDark
                              ? ColorPalette.strokeDarkColor
                              : ColorPalette.strokeLightColor,
                        ),
                      ),
                      child: provider.isDark
                          ? Assets.icons.calendarDark.svg()
                          : Assets.icons.calendarLight.svg(
                              width: 30,
                              height: 30,
                            ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('dd MMM').format(eventData.eventDate),
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                         eventData.eventTime?? '12.12pm',
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: ColorPalette.disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(appLocal.description),
              Container(
                padding: const EdgeInsets.all(16),
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: provider.isDark
                      ? ColorPalette.primaryDarkTextFieldColor
                      : ColorPalette.primaryDarkTextColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: provider.isDark
                        ? ColorPalette.strokeDarkColor
                        : ColorPalette.strokeLightColor,
                  ),
                ),
                child: Text(
                  eventData.eventDescription,
                  style: theme.textTheme.titleSmall,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
