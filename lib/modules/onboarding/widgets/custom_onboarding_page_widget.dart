import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:evently/core/widgets/elevated_button_widget.dart';
import 'package:evently/gen/assets.gen.dart';
import 'package:evently/models/onboarding_data_model.dart';
import 'package:evently/modules/onboarding/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'indicator_widget.dart';

class CustomOnboardingPageWidget extends StatelessWidget {
  final OnboardingDataModel onboardingDataModel;
  final VoidCallback onPressed;
  final Widget? firstPage;
  final String buttonText;
  final int currentIndex;
  final int onBoardingListLength;
  const CustomOnboardingPageWidget({
    super.key,
    required this.onboardingDataModel,
    required this.onPressed,
    this.firstPage,
    required this.buttonText,
    required this.currentIndex,
    required this.onBoardingListLength,
  });

  @override
  Widget build(BuildContext context) {
    var appLocal = AppLocalizations.of(context);
    ThemeData theme = Theme.of(context);
    final provider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,

        children: [
          Image.asset(
            provider.isDark
                ? onboardingDataModel.imagePathDark
                : onboardingDataModel.imagePathLight,
            fit: BoxFit.contain,
            width: 300,
            height: 300,
          ),
          if (firstPage == null) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                onBoardingListLength,
                (index) => IndicatorWidget(isActive: index == currentIndex),
              ),
            ],
          ),
          Text(
            onboardingDataModel.title,
            style: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            onboardingDataModel.description,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          ?firstPage,
          ElevatedButtonWidget(
            onPressed: () {
              onPressed.call();
            },
            buttonText: buttonText,
          ),
        ],
      ),
    );
  }
}
