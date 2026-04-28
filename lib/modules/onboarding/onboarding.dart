import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/core/widgets/elevated_button_widget.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:evently/models/onboarding_data_model.dart';
import 'package:evently/modules/onboarding/widgets/custom_onboarding_page_widget.dart';
import 'package:evently/modules/onboarding/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;
    final provider = Provider.of<AppProvider>(context);
    final onboardingList = _buildOnboardingList(appLocal);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: currentIndex >= 1
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                color: provider.isDark
                    ? ColorPalette.secondaryDarkTextColor
                    : ColorPalette.primaryLightColor,
                onPressed: () {
                  _controller.animateToPage(
                    currentIndex - 1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );

                },
              )
            : SizedBox.shrink(),
        actionsPadding: EdgeInsetsGeometry.only(right: 20),
        title: Image.asset(
          Assets.images.eventelyLight.path,
          width: 147,
          height: 27,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButtonWidget(
              onPressed: () {
                Navigator.pushReplacementNamed(context, PagesRouteName.signIn);
              },
              isOnboardingSetting: true,
              buttonText: appLocal.skip,
              isSelected: true,
              backgroundColor: provider.isDark
                  ? ColorPalette.primaryDarkTextFieldColor
                  : ColorPalette.primaryDarkTextColor,
            ),
          ),
        ],
      ),

      body: PageView.builder(
        itemCount: onboardingList.length,
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          bool isSelectedLang = provider.isEnglish;
          bool isSelectedTheme = provider.isDark;
          return CustomOnboardingPageWidget(
            onboardingDataModel: onboardingList[index],
            currentIndex: currentIndex-1,
            onBoardingListLength: onboardingList.length-1,
            firstPage: index == 0
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      SettingsWidget(
                        key: ValueKey(appLocal.language),
                        title: appLocal.language,
                        firstButton: appLocal.arabic,
                        secondButton: appLocal.english,
                        isFirstButtonSelected: !isSelectedLang,
                        isSecondButtonSelected: isSelectedLang,
                        onFirstButtonPressed: () {
                          provider.changeCurrentLanguage('ar');
                        },
                        onSecondButtonPressed: () {
                          provider.changeCurrentLanguage('en');
                        },
                      ),
                      SettingsWidget(
                        key: ValueKey(appLocal.theme),
                        title: appLocal.theme,
                        isTheme: true,

                        isSecondButtonSelected: isSelectedTheme,
                        isFirstButtonSelected: !isSelectedTheme,
                        sunIcon: Assets.icons.sunLight.svg(
                          colorFilter: ColorFilter.mode(
                            provider.isDark
                                ? ColorPalette.primaryDarkColor
                                : ColorPalette.primaryDarkTextColor,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                          height: 24,
                        ),
                        moonIcon: provider.isDark
                            ? Assets.icons.moonDark.svg(width: 24, height: 24)
                            : Assets.icons.moonLight.svg(width: 24, height: 24),
                        onFirstButtonPressed: () {
                          provider.changeCurrentThemeMode(ThemeMode.light);
                        },
                        onSecondButtonPressed: () {
                          provider.changeCurrentThemeMode(ThemeMode.dark);
                        },
                      ),
                    ],
                  )
                : null,
            buttonText:(index == 0)
                ? appLocal.letsStart
                : (index == onboardingList.length - 1)
                ? appLocal.getStarted
                : appLocal.next,
            onPressed: () {

              if (currentIndex < onboardingList.length -1 ) {

                _controller.animateToPage(
                  currentIndex + 1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                provider.setOnboardingSeen();
                Navigator.pushReplacementNamed(context, PagesRouteName.signIn);
              }
            },
          );
        },
      ),
    );
  }

  void goNext() {}

  List<OnboardingDataModel> _buildOnboardingList(AppLocalizations appLocal) {
    return [
      OnboardingDataModel(
        title: appLocal.boardingTitle_1,
        description: appLocal.boardingDescription_1,
        imagePathLight: Assets.images.onboarding1Light.path,
        imagePathDark: Assets.images.onboarding1Dark.path,
      ),
      OnboardingDataModel(
        title: appLocal.boardingTitle_2,
        description: appLocal.boardingDescription_2,
        imagePathLight: Assets.images.onboarding2Light.path,
        imagePathDark: Assets.images.onboarding2Dark.path,
      ),
      OnboardingDataModel(
        title: appLocal.boardingTitle_3,
        description: appLocal.boardingDescription_3,
        imagePathLight: Assets.images.onboarding3Light.path,
        imagePathDark: Assets.images.onboarding3Dark.path,
      ),
      OnboardingDataModel(
        title: appLocal.boardingTitle_4,
        description: appLocal.boardingDescription,
        imagePathLight: Assets.images.onboarding4Light.path,
        imagePathDark: Assets.images.onboarding4Dark.path,
      ),
    ];
  }
}
