import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:evently/models/onboarding_data_model.dart';
import 'package:evently/modules/onboarding/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/elevated_button_widget.dart';

// class FirstOnboardingPage extends StatelessWidget {
//   final OnboardingDataModel onboardingDataModel;
//   final VoidCallback onPressed;
//   const FirstOnboardingPage({
//     super.key,
//     required this.onboardingDataModel,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var appLocal = AppLocalizations.of(context);
//     ThemeData theme = Theme.of(context);
//     final provider = Provider.of<AppProvider>(context);
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisSize: MainAxisSize.max,
//
//         children: [
//           Image.asset(
//             provider.isDark
//                 ? onboardingDataModel.imagePathDark
//                 : onboardingDataModel.imagePathLight,
//             fit: BoxFit.contain,
//             width: 300,
//             height: 300,
//           ),
//           Text(
//             onboardingDataModel.title,
//             style: theme.textTheme.titleLarge!.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Text(
//             onboardingDataModel.description,
//             style: theme.textTheme.bodyMedium!.copyWith(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           SettingsWidget(
//             title: appLocal!.language,
//             theme: appLocal.english,
//             language: appLocal.arabic,
//             onFirstButtonPressed: () {
//               provider.changeCurrentLanguage('ar');
//             },
//             onSecondButtonPressed: () {
//               provider.changeCurrentLanguage('en');
//             },
//             activeBackgroundColor: provider.isEnglish?ColorPalette.primaryLightColor:Colors.transparent,
//           ),
//
//           SettingsWidget(
//             title: appLocal.theme,
//             isTheme: true,
//             sunIcon: Assets.icons.sunLight.svg(width: 24, height: 24),
//             moonIcon: Assets.icons.moonLight.svg(width: 24, height: 24),
//             onFirstButtonPressed: () {
//               provider.changeCurrentThemeMode(
//                 ThemeMode.light
//               );
//             },
//             onSecondButtonPressed: () {
//               provider.changeCurrentThemeMode(
//                ThemeMode.dark,
//               );
//             },
//             activeBackgroundColor: provider.isDark?ColorPalette.primaryDarkColor:Colors.transparent,
//             //   custom:InkWell(
//             //   onTap: () {
//             //     provider.changeCurrentThemeMode(
//             //       provider.isDark ? ThemeMode.light : ThemeMode.dark,
//             //     );
//             //   },
//             //   child: provider.isDark
//             //       ? Assets.icons.moonLight.svg(width: 24, height: 24)
//             //       : Assets.icons.sunLight.svg(width: 24, height: 24),
//             // ),
//           ),
//           ElevatedButtonWidget(
//             onPressed: () {
//               onPressed.call();
//             },
//             buttonText: appLocal.getStarted,
//           ),
//         ],
//       ),
//     );
//   }
// }
