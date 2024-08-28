import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final bool obscureText;
  TextEditingController?controller;
  final VoidCallback? onTap;
  final ValueChanged? onChanged;

  CustomTextFormField({
    super.key,
    this.hintText,
    this.hintStyle,
    this.fillColor,
    this.cursorColor,
    this.textStyle,
    this.contentPadding =
    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.autofillHints,
    this.obscureText = false,
    this.controller,
    this.onTap,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
  onTap: onTap,
      controller: controller,
      cursorColor: cursorColor ,
      style: textStyle ?? const TextStyle(color: Colors.black),
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
            const TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
        filled: true,
        fillColor: fillColor ,
        contentPadding: contentPadding,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius!,
          borderSide: BorderSide(color: borderColor ?? Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius!,
          borderSide: BorderSide(color: borderColor ?? Colors.grey),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
