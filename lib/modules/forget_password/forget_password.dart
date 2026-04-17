import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/constants/app_strings.dart';
import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/providers/auth_provider/auth_provider.dart';
import 'package:evently/core/widgets/elevated_button_widget.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/pages_route_name.dart';
import '../../core/widgets/text_form_field_widget.dart';
import '../../gen/assets.gen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();}
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appLocal = AppLocalizations.of(context);
    final provider = Provider.of<AppProvider>(context);
    bool isDark = provider.currentThemeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocal!.forgetPassword,
          style: theme.textTheme.bodyMedium,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.popAndPushNamed(context, PagesRouteName.signIn);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: isDark
                ? ColorPalette.primaryDarkTextColor
                : ColorPalette.primaryLightColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 20,
              children: [
                Image.asset(
                  isDark
                      ? Assets.images.forgetPasswordDark.path
                      : Assets.images.forgetPasswordLight.path,
                ),
                TextFormFieldWidget(
                  prefixIcon: Assets.icons.sms.svg(),
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
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                ElevatedButtonWidget(
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){

                      await context.read<AuthenticationProvider>().resetPassword(
                      _emailController.text.trim()
                    ); }
                    Navigator.pop(context);
                  },
                  buttonText: appLocal.resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
