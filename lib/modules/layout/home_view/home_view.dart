import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/core/widgets/event_card_widget.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/models/user_data_model.dart';
import 'package:evently/modules/layout/home_view/widgets/TabBarItemWidget.dart';
import 'package:evently/utils/firestore_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/app_theme/color_palette.dart';
import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';
import '../../../models/event_category_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
  late UserDataModel
  user =  ModalRoute.of(context)!.settings.arguments as UserDataModel;

  @override
  Widget build(BuildContext context) {print(user);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.welcome, style: theme.textTheme.titleSmall),
                  Text(user.userName, style: theme.textTheme.titleLarge),
                ],
              ),
            ),
            Assets.icons.moonLight.svg(width: 24, height: 24),
            SizedBox(width: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorPalette.primaryLightColor,
              ),
              child: Text(
                AppStrings.english,
                style: theme.textTheme.titleSmall!.copyWith(
                  color: ColorPalette.primaryDarkTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        spacing: 24,
        children: [
          SizedBox.shrink(),
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
         StreamBuilder(
           stream: FirestoreUtils.getStreamDataFromFirestore(categories[currentIndex].id) ,
           builder: (context, snapshot) {
             if (snapshot.hasError) {
               return Text(snapshot.error.toString());
             }
             if (snapshot.connectionState == ConnectionState.waiting) {
               return CircularProgressIndicator();
             }
             List<EventDataModel> data = snapshot.data!.docs.map((e){
               return e.data();
             }).toList();
             return Expanded(
               child: ListView.separated(
                 itemBuilder: (context, index) =>
                     EventCardWidget(
                       onTap: () {
                         Navigator.pushNamed(
                           context,
                           PagesRouteName.eventDetails,
                           arguments: data[index],
                         );
                       },
                       dataModel: data[index],
                     ),
                 itemCount: data.length,
                 separatorBuilder: (context, index) => SizedBox(height: 16),
               ),
             );
           })],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PagesRouteName.addEvent);
        },
        backgroundColor: ColorPalette.primaryLightColor,
        foregroundColor: ColorPalette.primaryDarkTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(50),
        ),
        child: Icon(Icons.add, size: 24),
      ),
    );
  }
}
