import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/app_theme/color_palette.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/pages_route_name.dart';
import '../../core/widgets/elevated_button_widget.dart';
import '../../core/widgets/text_form_field_widget.dart';
import '../../gen/assets.gen.dart';
import '../../models/event_category_model.dart';
import '../../models/event_data_model.dart';
import '../../utils/firestore_utils.dart';
import '../layout/home_view/widgets/TabBarItemWidget.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<EventCategoryModel> categories = [
    EventCategoryModel(
      id: 'sport',
      name: 'Sport',
      lightImage: Assets.images.sportLight.path,
      darkImage: Assets.images.sportDark.path,
      icon: Assets.icons.sportLight,
    ),
    EventCategoryModel(
      id: 'birthday',
      name: 'Birthday',
      lightImage: Assets.images.birthdayLight.path,
      darkImage: Assets.images.birthdayDark.path,
      icon: Assets.icons.birthdayCakeLight,
    ),
    EventCategoryModel(
      id: 'book_club',
      name: 'BookClub',
      lightImage: Assets.images.bookclubLight.path,
      darkImage: Assets.images.bookclubDark.path,
      icon: Assets.icons.bookLight,
    ),
  ];
  late EventDataModel eventData =
      ModalRoute.of(context)!.settings.arguments as EventDataModel;
  int currentIndex = 0;

  DateTime? selectedEventDate;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(AppStrings.editEvent),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                  image: AssetImage(categories[currentIndex].lightImage),fit: BoxFit.cover
                ),
              ),
            ),
            DefaultTabController(
              length: categories.length,
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(),
                tabAlignment: TabAlignment.start,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                tabs: categories.map((data) {
                  return TabBarItemWidget(
                    eventCategoryModel: data,
                    isSelected: currentIndex == categories.indexOf(data),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [
                    Text(AppStrings.title),
                    TextFormFieldWidget(
                      hintText: eventData.eventTitle,
                      controller: _titleController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'you have to enter a title for the event';
                        }
                        return null;
                      },
                    ),
                    Text(AppStrings.description),
                    TextFormFieldWidget(
                      hintText: eventData.eventDescription,
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'you have to enter a description for the event';
                        }
                        return null;
                      },
                      maxLines: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Assets.icons.calendarLight.svg(),
                        Expanded(
                          child: Text(
                            AppStrings.eventDate,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            getSelectedDate();
                          },
                          child: Text(
                              DateFormat(
                            'dd MMM',
                          ).format(selectedEventDate ==null?eventData.eventDate:selectedEventDate!) ,
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: ColorPalette.primaryLightColor,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorPalette.primaryLightColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Assets.icons.clockLight.svg(),
                        Expanded(
                          child: Text(
                            AppStrings.eventTime,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          AppStrings.chooseTime,
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: ColorPalette.primaryLightColor,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorPalette.primaryLightColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    ElevatedButtonWidget(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (selectedEventDate == null) {
                            return;
                          }
                          Navigator.pop(context, PagesRouteName.layout);
                          EventDataModel data = EventDataModel(
                            eventId: eventData.eventId,
                            eventCategoryDarkImage:
                                categories[currentIndex].darkImage,
                            eventTitle: _titleController.text,
                            eventDescription: _descriptionController.text,
                            eventDate: selectedEventDate!,
                            eventCategoryId: categories[currentIndex].id,
                            eventCategoryLightImage:
                                categories[currentIndex].lightImage,
                          );
                          FirestoreUtils.updateEvent(data);
                        }
                      },

                      customChild: Text(
                        AppStrings.updateEvent,
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: ColorPalette.primaryDarkTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getSelectedDate() async {
    var showCurrentDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    setState(() {
      selectedEventDate = showCurrentDate;
    });
  }
}
