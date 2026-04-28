import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:evently/core/providers/auth_provider/auth_provider.dart';
import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/core/widgets/elevated_button_widget.dart';
import 'package:evently/core/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/app_localizations.dart';
import '../../gen/assets.gen.dart';
import '../../services/snack_bar_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController(
    text: 'dollagalal@gmail.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '432257_Lm@',
  );

  @override
  Widget build(BuildContext context) {
    var appLocal = AppLocalizations.of(context);
    ThemeData theme = Theme.of(context);
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
                    appLocal!.loginToYourAccount,
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 20),
                  TextFormFieldWidget(
                    prefixIcon: $AssetsIconsGen().sms.svg(),
                    hintText: appLocal.enterYourEmail,
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
                    hintText: appLocal.enterYourPassword,
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
                      appLocal.forgetPassword,
                      style: isDark
                          ? theme.textTheme.titleSmall?.copyWith(
                              color: ColorPalette.primaryDarkColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorPalette.primaryDarkColor,
                            )
                          : theme.textTheme.titleSmall?.copyWith(
                              color: ColorPalette.primaryLightColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorPalette.primaryLightColor,
                            ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(height: 20),
                  Consumer<AuthenticationProvider>(
                    builder: (context,auth,_) {
                      if (auth.errorMessage != null) {
                        SnackBarServices.showErrorMessage(auth.errorMessage!);
                      }
                      return ElevatedButtonWidget(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await context.read<AuthenticationProvider>().signIn(
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (auth.user != null) {
                              SnackBarServices.showSuccessMessage(
                                'you are now logged in',
                              );
                              if(context.mounted) {
                                Navigator.pushNamedAndRemoveUntil(
                                context,
                                PagesRouteName.layout,
                                (route) => false,
                                arguments: auth.user,
                              );
                              }
                            }
                            // else{
                            //   SnackBarServices.showErrorMessage('login failed');
                            // }
                          }
                        },
                        buttonText: appLocal.login,
                      );
                    }
                  ),
                  SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: appLocal.doNotYouHaveAccount,
                          style: theme.textTheme.titleSmall
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
                              appLocal.signUP,
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
                    builder: (context,auth,_) {
                      return ElevatedButtonWidget(
                        onPressed: ()async {
                        await context.read<AuthenticationProvider>().signInWithGoogle();
                        if (auth.user != null) {
                          SnackBarServices.showSuccessMessage(
                            'you are now logged in',
                          );
                          if(context.mounted) {
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
                            ? ColorPalette.primaryDarkTextFieldColor
                            : ColorPalette.primaryDarkTextColor,
                        foregroundColor: isDark
                            ? ColorPalette.primaryDarkColor
                            : ColorPalette.primaryLightColor,
                        customChild: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Assets.icons.googleIconLogoSvgrepoCom.svg(
                              width: 24,
                              height: 24,
                            ),
                            Text(
                              appLocal.loginWithGoogle,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
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
