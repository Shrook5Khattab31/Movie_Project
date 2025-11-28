import 'package:flutter/material.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import '../theme/appColors.dart';

typedef onValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool isPassword;
  final VoidCallback? onToggleVisibility;
  final TextInputType? keyboardType;
  final onValidator? validatorFunc;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.hintStyle,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.controller,
    this.onChanged,
    this.isPassword = false,
    this.onToggleVisibility,
    this.keyboardType,
    this.validatorFunc,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      onChanged: onChanged,
      validator: validatorFunc,
      cursorColor: AppColors.secondColor,
      style: hintStyle ?? AppStyles.reg16White,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? AppColors.grayDarkColor,
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.reg16White,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconColor: prefixIconColor ?? AppColors.whiteColor,
        suffixIconColor: suffixIconColor ?? AppColors.whiteColor,

        enabledBorder: buildBorderDecoration(),
        focusedBorder: buildBorderDecoration(),
        focusedErrorBorder: buildBorderDecoration(),
        errorBorder: buildBorderDecoration(),
      ),
    );
  }

  OutlineInputBorder buildBorderDecoration() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: AppColors.grayDarkColor),
    );
  }
}
