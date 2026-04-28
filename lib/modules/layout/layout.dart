import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:evently/modules/layout/favorite_view/favorite_view.dart';
import 'package:evently/modules/layout/home_view/home_view.dart';
import 'package:evently/modules/layout/profile_view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var appLocal = AppLocalizations.of(context);
    final provider = Provider.of<AppProvider>(context);
    bool isDark = provider.currentThemeMode == ThemeMode.dark;
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
              label: appLocal!.home,
              icon: isDark
                  ? Assets.icons.homeUnSelected.svg()
                  : Assets.icons.homeUnSelected.svg(),
              activeIcon: isDark
                  ? Assets.icons.homeDark.svg()
                  : Assets.icons.homeSelected.svg(),
            ),
            BottomNavigationBarItem(
              label: appLocal.favorite,
              icon: Assets.icons.heartUnSelected.svg(),
              activeIcon: isDark
                  ? Assets.icons.heartDark.svg()
                  : Assets.icons.heartSelected.svg(),
            ),
            BottomNavigationBarItem(
              label: appLocal.profile,
              icon: Assets.icons.userUnSelceted.svg(),
              activeIcon: isDark
                  ? Assets.icons.userDark.svg()
                  : Assets.icons.userSelected.svg(),
            ),
          ],
        ),
      ),
    );
  }
}
