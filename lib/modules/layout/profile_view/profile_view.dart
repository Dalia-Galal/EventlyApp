import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/constants/app_strings.dart';
import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:evently/core/providers/auth_provider/auth_provider.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:evently/modules/layout/profile_view/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthenticationProvider>().user!.userEmail;
    var appLocal = AppLocalizations.of(context);
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  Assets.images.routeProfileLight.path,
                ),
                radius: 80,
              ),
              Text(context.read<AuthenticationProvider>().user!.userName),
              Text(context.read<AuthenticationProvider>().user!.userEmail),

              CustomContainerWidget(
                text: appLocal!.darkMode,
                customWidget: Switch(
                  value: provider.isDark,
                  activeTrackColor:
                      ColorPalette.primaryDarkColor
                     ,inactiveTrackColor: ColorPalette.switchColor,
                  inactiveThumbColor: ColorPalette.primaryDarkTextColor,
                  trackOutlineColor:WidgetStatePropertyAll(Colors.transparent),

                  onChanged: (v) {
                    provider.changeCurrentThemeMode(
                      provider.isDark? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                ),
              ),
              CustomContainerWidget(
                text: appLocal.language,
                customWidget: IconButton(
                  onPressed: (){
                    provider.changeCurrentLanguage(
                      provider.currentLanguage == 'en' ? 'ar' : 'en',
                    );
                    provider.isEnglish?'ar':'en';
                  },
                icon:
                    Icon(Icons.arrow_forward_ios_rounded,
                    color: provider.isDark
                        ? ColorPalette.primaryDarkColor
                        : ColorPalette.primaryLightColor,

                  ),)
              ),
              CustomContainerWidget(
                text: appLocal.logout,
                customWidget: GestureDetector(
                  onTap: () {
                    context.read<AuthenticationProvider>().signOut();
                    Navigator.pushReplacementNamed(
                      context,
                      PagesRouteName.signIn,
                    );
                  },
                  child: Assets.icons.logout.svg(width: 24, height: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
