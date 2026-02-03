import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../gen/assets.gen.dart';
import '../app_theme/color_palette.dart';
import '../constants/app_strings.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  // final void Function(String)? onFieldSubmitted;
  const TextFormFieldWidget({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.isPassword = false,
    this.validator,
    // this.onFieldSubmitted,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
     // onFieldSubmitted: widget.onFieldSubmitted,
     // autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.isPassword ? obscureText : false,
      cursorColor: ColorPalette.strokeLightColor,

      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: widget.prefixIcon,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: obscureText
                      ? Assets.icons.eye.svg(width: 24, height: 24)
                      : Assets.icons.eyeSlash.svg(width: 24, height: 24),
                ),
              )
            : null,

        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorPalette.strokeLightColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorPalette.strokeLightColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ColorPalette.strokeLightColor,
            width: 1,
          ),
          gapPadding: 50,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
      style: theme.textTheme.titleSmall,
    );
  }
}
