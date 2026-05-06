import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:evently/core/providers/auth_provider/auth_provider.dart';
import 'package:evently/services/snack_bar_services.dart';
import 'package:evently/utils/firebase_authentication_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_theme/color_palette.dart';
import '../../core/routes/pages_route_name.dart';
import '../../core/widgets/elevated_button_widget.dart';
import '../../core/widgets/text_form_field_widget.dart';
import '../../gen/assets.gen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var appLocal = AppLocalizations.of(context);
    final provider = Provider.of<AppProvider>(context);
    bool isDark = provider.currentThemeMode == ThemeMode.dark;
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
                    isDark
                        ? Assets.images.eventelyDark.path
                        : Assets.images.eventelyLight.path,
                    width: 142,
                    height: 27,
                  ),
                  SizedBox(height: 20),
                  Text(
                    appLocal!.createYourAccount,
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 20),

                  TextFormFieldWidget(
                    prefixIcon: $AssetsIconsGen().userUnSelceted.svg(),
                    hintText: appLocal.enterYourName,
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 letters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormFieldWidget(
                    prefixIcon: $AssetsIconsGen().sms.svg(),
                    hintText: appLocal.enterYourEmail,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is Required';
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
                    hintText: appLocal.enterYourPassword,
                    controller: _passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password is required';
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
                  TextFormFieldWidget(
                    prefixIcon: Assets.icons.lock.svg(),
                    hintText: appLocal.confirmYourPassword,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Confirm your password ';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Consumer<AuthenticationProvider>(
                    builder: (context, auth, _) {
                      return ElevatedButtonWidget(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await auth.signUp(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (auth.user != null) {
                              SnackBarServices.showSuccessMessage(
                                'Account created',
                              );
                              if (context.mounted) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  PagesRouteName.layout,
                                  (route) => false,
                                  arguments: auth.user,
                                );
                              }
                            }
                          }
                        },
                        buttonText: appLocal.signUP,
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: appLocal.alreadyHaveAccount,
                          style: theme.textTheme.titleSmall,
                        ),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              appLocal.login,
                              style: isDark
                                  ? theme.textTheme.titleMedium!.copyWith(
                                      color: ColorPalette.primaryDarkColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          ColorPalette.primaryDarkColor,
                                    )
                                  : theme.textTheme.titleMedium?.copyWith(
                                      color: ColorPalette.primaryLightColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          ColorPalette.primaryLightColor,
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
                          color: isDark
                              ? ColorPalette.strokeDarkColor
                              : ColorPalette.strokeLightColor,
                        ),
                      ),
                      Text(
                        appLocal.or,
                        style: isDark
                            ? theme.textTheme.titleMedium!.copyWith(
                                color: ColorPalette.primaryDarkColor,
                              )
                            : theme.textTheme.titleMedium,
                      ),
                      Expanded(
                        child: Divider(
                          indent: 20,
                          endIndent: 20,
                          color: isDark
                              ? ColorPalette.strokeDarkColor
                              : ColorPalette.strokeLightColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Consumer<AuthenticationProvider>(
                    builder: (context, auth, _) {
                      return ElevatedButtonWidget(
                        onPressed: () async {
                          await context
                              .read<AuthenticationProvider>()
                              .signInWithGoogle();
                          if (auth.user != null) {
                            SnackBarServices.showSuccessMessage(
                              'you are now logged in',
                            );
                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                PagesRouteName.layout,
                                (route) => false,
                                arguments: auth.user,
                              );
                            }
                          }
                        },
                        backgroundColor: isDark
                            ? ColorPalette.backgroundDarkColor
                            : ColorPalette.primaryDarkTextColor,
                        foregroundColor: ColorPalette.primaryDarkColor,
                        customChild: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Assets.icons.googleIconLogoSvgrepoCom.svg(
                              width: 24,
                              height: 24,
                            ),
                            Text(
                              appLocal.signUpWithGoogle,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
