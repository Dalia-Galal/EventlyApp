import 'package:evently/models/user_data_model.dart';
import 'package:evently/services/snack_bar_services.dart';
import 'package:evently/utils/firebase_authentication_utils.dart';
import 'package:flutter/material.dart';

import '../../core/app_theme/color_palette.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/pages_route_name.dart';
import '../../core/widgets/elevated_button_widget.dart';
import '../../core/widgets/text_form_field_widget.dart';
import '../../gen/assets.gen.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController(
    // text: '1257Gy#02',
  );

  final _formKey = GlobalKey<FormState>();

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
                    AppStrings.createYourAccount,
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 20),

                  TextFormFieldWidget(
                    prefixIcon: $AssetsIconsGen().userUnSelceted.svg(),
                    hintText: AppStrings.enterYourName,
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
                    hintText: AppStrings.enterYourEmail,
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
                    hintText: AppStrings.enterYourPassword,
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
                    hintText: AppStrings.confirmYourPassword,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Confirm your password ';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        UserDataModel? user =
                            await FirebaseAuthenticationUtils.createUserWithEmailAndPassword(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text,
                            );
                        if (user != null) {
                          SnackBarServices.showSuccessMessage(
                            'Account created',
                          );
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            PagesRouteName.layout,
                            (route) => false,
                            arguments: user,
                          );
                        }
                      } else {}
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
                              Navigator.pop(context);
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
                        Text(AppStrings.signUpWithGoogle),
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
