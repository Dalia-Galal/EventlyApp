import 'package:evently/core/providers/auth_provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/app_theme/color_palette.dart';
import '../../core/constants/app_strings.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/providers/appProvider/app_provider.dart';
import '../../core/routes/pages_route_name.dart';
import '../../core/widgets/elevated_button_widget.dart';
import '../../core/widgets/text_form_field_widget.dart';
import '../../gen/assets.gen.dart';
import '../../models/event_category_model.dart';
import '../../models/event_data_model.dart';
import '../../services/snack_bar_services.dart';
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

  late EventDataModel eventData =
      ModalRoute.of(context)!.settings.arguments as EventDataModel;
  int currentIndex = 0;

  DateTime? selectedEventDate;
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final provider = Provider.of<AppProvider>(context);
    var appLocal = AppLocalizations.of(context);
    List<EventCategoryModel> categories = [
      EventCategoryModel(
        id: 'sport',
        name: appLocal!.sport,
        lightImage: Assets.images.sportLight.path,
        darkImage: Assets.images.sportDark.path,
        icon: Assets.icons.sportLight,
      ),
      EventCategoryModel(
        id: 'birthday',
        name: appLocal.birthday,
        lightImage: Assets.images.birthdayLight.path,
        darkImage: Assets.images.birthdayDark.path,
        icon: Assets.icons.birthdayCakeLight,
      ),
      EventCategoryModel(
        id: 'book_club',
        name: appLocal.bookClub,
        lightImage: Assets.images.bookclubLight.path,
        darkImage: Assets.images.bookclubDark.path,
        icon: Assets.icons.bookLight,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(appLocal.editEvent),
        centerTitle: true,
        foregroundColor: provider.isDark?ColorPalette.primaryDarkTextColor:ColorPalette.primaryLightColor,
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
                color: provider.isDark?ColorPalette.primaryDarkTextFieldColor:ColorPalette.primaryDarkTextColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: provider.isDark?ColorPalette.strokeDarkColor:ColorPalette.strokeLightColor),
                image: DecorationImage(
                  image: provider.isDark?AssetImage(categories[currentIndex].darkImage):AssetImage(categories[currentIndex].lightImage),
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
                      hintText: eventData.eventTitle,
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
                       provider.isDark?Assets.icons.calendarDark.svg():
                        Assets.icons.calendarLight.svg(),
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
                            DateFormat('dd MMM').format(
                              selectedEventDate == null
                                  ? eventData.eventDate
                                  : selectedEventDate!,
                            ),
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: provider.isDark?ColorPalette.primaryDarkColor:ColorPalette.primaryLightColor,
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
                        provider.isDark?Assets.icons.clockDark.svg():Assets.icons.clockLight.svg(),
                        Expanded(
                          child: Text(
                            appLocal.eventTime,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          appLocal.chooseTime,
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: provider.isDark?ColorPalette.primaryDarkColor:ColorPalette.primaryLightColor,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorPalette.primaryLightColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Consumer<AuthenticationProvider>(
                      builder: (context,auth,_) {
                        return ElevatedButtonWidget(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (selectedEventDate == null) {
                                SnackBarServices.showSuccessMessage(
                                    'event did not edited',);
                                return;
                              }
                              SnackBarServices.showSuccessMessage(
                                'Event edited Successfully',
                              );
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                PagesRouteName.layout,
                                (route) => false,
                              );
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
                                  ownerId: auth.user!.userId,
                              );
                              FirestoreUtils.updateEvent(data);
                            }
                          },

                          customChild: Text(
                            appLocal.updateEvent,
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: ColorPalette.primaryDarkTextColor,
                            ),
                          ),
                        );
                      }
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
