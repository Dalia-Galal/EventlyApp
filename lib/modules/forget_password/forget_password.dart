import 'package:evently/core/app_theme/color_palette.dart';
import 'package:evently/core/constants/app_strings.dart';
import 'package:evently/core/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.forgetPassword),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back_ios_new,color: ColorPalette.primaryLightColor,),
      ),
      body:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 20,
            children: [
              Image.asset(Assets.images.forgetPasswordLight.path),
              ElevatedButtonWidget(buttonText: AppStrings.resetPassword,),
            ],
          ),
        )
    );
  }
}
