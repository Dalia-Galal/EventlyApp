import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/constants/app_strings.dart';
import 'package:evently/modules/layout/favorite_view/favorite_view.dart';
import 'package:evently/modules/layout/home_view/home_view.dart';
import 'package:evently/modules/layout/profile_view/profile_view.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentItemIndex = 0;
  final List<Widget> _pages = [HomeView(), FavoriteView(), ProfileView()];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _pages[currentItemIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentItemIndex,
          onTap: (index) {
            setState(() {
              currentItemIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: AppStrings.home,
              icon: Assets.icons.homeUnSelected.svg(),
              activeIcon: Assets.icons.homeSelected.svg(),
            ),
            BottomNavigationBarItem(
              label: AppStrings.favorite,
              icon: Assets.icons.heartUnSelected.svg(),
              activeIcon: Assets.icons.heartSelected.svg(),
            ),
            BottomNavigationBarItem(
              label: AppStrings.profile,
              icon: Assets.icons.userUnSelceted.svg(),
              activeIcon: Assets.icons.userSelected.svg(),
            ),
          ],
        ),
      ),
    );
  }
}
