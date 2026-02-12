import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../app_theme/color_palette.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final int? maxLines;
  // final void Function(String)? onFieldSubmitted;
  final Function? onPressed;
  final Function(String)? onChanged;
  const TextFormFieldWidget({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.isPassword = false,
    this.validator,
    this.maxLines,
    // this.onFieldSubmitted,
    this.onPressed,
    this.onChanged,
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
      onChanged: (value) {
        widget.onChanged?.call(value);
      },

      // autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.isPassword ? obscureText : false,
      cursorColor: ColorPalette.strokeLightColor,

      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: (widget.prefixIcon != null)
            ? Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: widget.prefixIcon,
              )
            : null,
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
            : (widget.suffixIcon != null)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.onPressed!.call();
                  });
                },
                icon: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: widget.suffixIcon,
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
      maxLines: widget.isPassword ? 1 : widget.maxLines,
    );
  }
}
