import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/constants/app_strings.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/core/widgets/elevated_button_widget.dart';
import 'package:evently/core/widgets/text_form_field_widget.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/utils/firestore_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../gen/assets.gen.dart';
import '../../models/event_category_model.dart';
import '../layout/home_view/widgets/TabBarItemWidget.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
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
  int currentIndex = 0;
  DateTime? selectedEventDate;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addEvent),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16,
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
                  image: AssetImage(categories[currentIndex].lightImage),
                  fit: BoxFit.cover,
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
                      hintText: AppStrings.eventTitle,
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
                      hintText: AppStrings.eventDescription,
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
                            (selectedEventDate != null)
                                ? DateFormat(
                                    'dd MMM yyyy',
                                  ).format(selectedEventDate!)
                                : AppStrings.chooseDate,
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
                          Navigator.pushNamed(
                            context,
                            PagesRouteName.layout,
                          );
                          EventDataModel data = EventDataModel(
                            eventCategoryDarkImage:
                                categories[currentIndex].darkImage,
                            eventTitle: _titleController.text,
                            eventDescription: _descriptionController.text,
                            eventDate: selectedEventDate!,
                            eventCategoryId: categories[currentIndex].id,
                            eventCategoryLightImage:
                                categories[currentIndex].lightImage,
                          );
                          FirestoreUtils.addEvent(data);
                        }
                      },

                      customChild: Text(
                        AppStrings.addEvent,
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
