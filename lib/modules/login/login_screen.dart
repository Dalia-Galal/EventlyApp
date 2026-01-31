import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/app_theme/theme_manager.dart';
import 'package:evently/core/constants/app_strings.dart';
import 'package:evently/core/widgets/elevated_button_widget.dart';
import 'package:evently/core/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                Assets.images.eventelyLight.path,
                width: 142,
                height: 27,
              ),
              SizedBox(height: 20),
              Text(
                AppStrings.loginToYourAccount,
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 20),
              TextFormFieldWidget(
                prefixIcon: $AssetsIconsGen().sms.svg(),
                hintText: AppStrings.enterYourEmail,
                controller: emailController,
              ),
              SizedBox(height: 20),
              TextFormFieldWidget(
                prefixIcon: Assets.icons.lock.svg(),
                hintText: AppStrings.enterYourPassword,
                controller: passwordController,
                suffixIcon: Assets.icons.eye.svg(width: 24, height: 24),
              ),
              SizedBox(height: 20),
              Text(
                AppStrings.forgetPassword,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: ColorPalette.primaryLightColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorPalette.primaryLightColor,
                ),
                textAlign: TextAlign.end,
              ),
              SizedBox(height: 20),
              ElevatedButtonWidget(
                onPressed: () {},
                buttonText: AppStrings.login,

                //backgroundColor:ColorPalette.primaryLightColor ,
                //foregroundColor: ColorPalette.primaryDarkTextColor,
              ),

              SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppStrings.doNotYouHaveAccount,
                      style: theme.textTheme.titleSmall,
                    ),
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          AppStrings.signUP,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: ColorPalette.primaryLightColor,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorPalette.primaryLightColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                      color: ColorPalette.strokeLightColor,
                    ),
                  ),
                  Text(AppStrings.or),
                  Expanded(
                    child: Divider(
                      indent: 20,
                      endIndent: 20,
                      color: ColorPalette.strokeLightColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButtonWidget(
                backgroundColor: ColorPalette.primaryDarkTextColor,
                foregroundColor: ColorPalette.primaryLightColor,
                customChild: Row(

                  children: [
                    Assets.icons.googleIconLogoSvgrepoCom.svg(width: 24,height: 24),
                    SizedBox(
                      width: 20,
                    ),
                    Text(AppStrings.loginWithGoogle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
