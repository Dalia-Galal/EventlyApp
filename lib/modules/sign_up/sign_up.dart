import 'package:flutter/material.dart';

import '../../core/app_theme/color_palette.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/pages_route_name.dart';
import '../../core/widgets/elevated_button_widget.dart';
import '../../core/widgets/text_form_field_widget.dart';
import '../../gen/assets.gen.dart';

class SignUp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();
 SignUp({super.key});



  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                  AppStrings.createYourAccount,
                  style: theme.textTheme.headlineSmall,
                ),
                SizedBox(height: 20),
                TextFormFieldWidget(
                  prefixIcon: $AssetsIconsGen().userUnSelceted.svg(),
                  hintText: AppStrings.enterYourName,
                  controller: nameController,
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
                  isPassword: true,
                ),
                SizedBox(height: 20),
                TextFormFieldWidget(
                  prefixIcon: Assets.icons.lock.svg(),
                  hintText: AppStrings.confirmYourPassword,
                  controller: confirmPasswordController,
                  isPassword: true,
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                ElevatedButtonWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, PagesRouteName.layout);
                  },
                  buttonText: AppStrings.signUP,
                ),
                SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.alreadyHaveAccount,
                        style: theme.textTheme.titleSmall,
                      ),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, PagesRouteName.signIn);
                          },
                          child: Text(
                            AppStrings.login,
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
                    Text(AppStrings.or,style: theme.textTheme.titleMedium,),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Assets.icons.googleIconLogoSvgrepoCom.svg(width: 24,height: 24),
                      Text(AppStrings.signUpWithGoogle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),


    );
  }
}
