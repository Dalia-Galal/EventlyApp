import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/core/widgets/elevated_button_widget.dart';
import 'package:evently/core/widgets/text_form_field_widget.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/services/snack_bar_services.dart';
import 'package:evently/utils/firestore_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/providers/appProvider/app_provider.dart';
import '../../gen/assets.gen.dart';
import '../../models/event_category_model.dart';
import '../layout/home_view/widgets/tab_bar_item_widget.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int currentIndex = 0;
  DateTime? selectedEventDate;
  TimeOfDay? timeOfDay;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var appLocal = AppLocalizations.of(context);
    final provider = Provider.of<AppProvider>(context);

    List<EventCategoryModel> categories = EventCategoryModel.getCategories(
      appLocal!,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocal.addEvent),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: provider.isDark
            ? ColorPalette.primaryDarkTextColor
            : ColorPalette.primaryLightColor,
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
                border: Border.all(
                  color: provider.isDark
                      ? ColorPalette.strokeDarkColor
                      : ColorPalette.strokeLightColor,
                ),
                image: DecorationImage(
                  image: provider.isDark
                      ? AssetImage(categories[currentIndex].darkImage)
                      : AssetImage(categories[currentIndex].lightImage),
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
                    Text(appLocal.title),
                    TextFormFieldWidget(
                      hintText: appLocal.eventTitle,
                      controller: _titleController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'you have to enter a title for the event';
                        }
                        return null;
                      },
                    ),
                    Text(appLocal.description),
                    TextFormFieldWidget(
                      hintText: appLocal.eventDescription,
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
                        provider.isDark
                            ? Assets.icons.calendarDark.svg()
                            : Assets.icons.calendarLight.svg(),
                        Expanded(
                          child: Text(
                            appLocal.eventDate,
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
                                : appLocal.chooseDate,
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: provider.isDark
                                  ? ColorPalette.primaryDarkColor
                                  : ColorPalette.primaryLightColor,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorPalette.primaryLightColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: getSelectedTime,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          provider.isDark
                              ? Assets.icons.clockDark.svg()
                              : Assets.icons.clockLight.svg(),
                          Expanded(
                            child: Text(
                              appLocal.eventTime,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          Text(
                            (timeOfDay != null)
                                ? timeOfDay!.format(context)
                                : appLocal.chooseTime,
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: provider.isDark
                                  ? ColorPalette.primaryDarkColor
                                  : ColorPalette.primaryLightColor,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorPalette.primaryLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButtonWidget(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;

                        if (selectedEventDate == null) {
                          SnackBarServices.showErrorMessage(
                            'Date not selected',
                          );
                          return;
                        }
                        if (timeOfDay == null) {
                          SnackBarServices.showErrorMessage(
                            'Time not selected',
                          );
                          return;
                        }
                        final EventDataModel data = EventDataModel(
                          eventCategoryDarkImage:
                              categories[currentIndex].darkImage,
                          eventTitle: _titleController.text,
                          eventDescription: _descriptionController.text,
                          eventDate: selectedEventDate!,
                          eventTime: timeOfDay!.format(context),
                          eventCategoryId: categories[currentIndex].id,
                          eventCategoryLightImage:
                              categories[currentIndex].lightImage,
                        );
                        EasyLoading.show();
                        try {
                          await FirestoreUtils.addEvent(data);
                          EasyLoading.dismiss();
                          SnackBarServices.showSuccessMessage(
                            'event added successfully',
                          );
                          if (context.mounted) {
                            Navigator.pop(context, PagesRouteName.layout);
                          }
                        } catch (e) {
                          EasyLoading.dismiss();
                          return SnackBarServices.showErrorMessage(
                            e.toString(),
                          );
                        }
                      },

                      customChild: Text(
                        appLocal.addEvent,
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

  void getSelectedTime() async {
    var showCurrentTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    setState(() {
      timeOfDay = showCurrentTime;
    });
  }
}
