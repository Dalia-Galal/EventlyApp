import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/utils/firestore_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/app_theme/color_palette.dart';
import '../../core/constants/app_strings.dart';
import '../../gen/assets.gen.dart';
import '../../models/event_data_model.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    EventDataModel eventData =
        ModalRoute.of(context)!.settings.arguments as EventDataModel;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(AppStrings.eventDetails),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                PagesRouteName.editEvent,
                arguments: eventData,
              );
            },
            child: Assets.icons.edit.svg(),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              FirestoreUtils.deleteEvent(eventData);
              Navigator.pop(
                context,
                PagesRouteName.layout,
              );
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
                  color: ColorPalette.primaryDarkTextColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorPalette.strokeLightColor),
                  image: DecorationImage(
                    image: AssetImage(eventData.eventCategoryLightImage),
                  ),
                ),
              ),
              Text(eventData.eventTitle),
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
                        Text(
                          DateFormat('dd MMM').format(eventData.eventDate),
                          style: theme.textTheme.titleMedium,
                        ),
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
