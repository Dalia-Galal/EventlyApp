import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/constants/app_strings.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/core/widgets/elevated_button_widget.dart';
import 'package:evently/core/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController(text: 'Dalia@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: 'kfj1Rt#123');
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
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
                    AppStrings.loginToYourAccount,
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 20),
                  TextFormFieldWidget(
                    prefixIcon: $AssetsIconsGen().sms.svg(),
                    hintText: AppStrings.enterYourEmail,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your email';
                      }
                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormFieldWidget(
                    prefixIcon: Assets.icons.lock.svg(),
                    hintText: AppStrings.enterYourPassword,
                    controller: _passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your password ';
                      }
                      final passwordRegex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$',
                      );
                      if (!passwordRegex.hasMatch(value)) {
                        return 'Password must contain at least 8 chars, one uppercase, one lowercase, one number, and one special character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PagesRouteName.forgetPassword,
                      );
                    },
                    child: Text(
                      '${AppStrings.forgetPassword}?',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: ColorPalette.primaryLightColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorPalette.primaryLightColor,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButtonWidget(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          PagesRouteName.layout,
                          (route) => false,
                        );
                      }
                    },
                    buttonText: AppStrings.login,
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
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PagesRouteName.signUp,
                              );
                            },
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
                      Text(AppStrings.or, style: theme.textTheme.titleMedium),
                      Expanded(
                        child: Divider(
                          indent: 20,
                          endIndent: 20,
                          color: ColorPalette.strokeLightColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButtonWidget(
                    onPressed: () {},
                    backgroundColor: ColorPalette.primaryDarkTextColor,
                    foregroundColor: ColorPalette.primaryLightColor,
                    customChild: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Assets.icons.googleIconLogoSvgrepoCom.svg(
                          width: 24,
                          height: 24,
                        ),
                        Text(AppStrings.loginWithGoogle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
