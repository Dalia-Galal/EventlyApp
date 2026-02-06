import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/core/widgets/event_card_widget.dart';
import 'package:evently/modules/layout/home_view/widgets/TabBarItemWidget.dart';
import 'package:flutter/material.dart';

import '../../../core/app_theme/color_palette.dart';
import '../../../core/constants/app_strings.dart';
import '../../../gen/assets.gen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.welcome, style: theme.textTheme.titleSmall),
                  Text('John Safwat', style: theme.textTheme.titleLarge),
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
            length: 5,
            child: TabBar(
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(),
              tabAlignment: TabAlignment.start,
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              tabs: List.generate(5, (context) => TabBarItemWidget()),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => EventCardWidget(),
              itemCount: 5,
              separatorBuilder: (context, index) => SizedBox(height: 16),
            ),
          ),
        ],
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
