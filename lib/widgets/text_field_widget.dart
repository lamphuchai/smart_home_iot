import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';

class TextFieldWidget extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final VoidCallback? onEditingComplete;
  final String? labelText;
  final String? hintText;
  final Color? fillColor;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  const TextFieldWidget(
      {Key? key,
      this.textInputAction,
      this.focusNode,
      this.obscureText,
      this.fillColor,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.errorText,
      this.onChanged,
      this.onEditingComplete,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.buttonColor,
      style: AppStyles.textLarge.copyWith(color: AppColors.iconColor),
      obscureText: obscureText ?? false,
      controller: controller,
      onEditingComplete: onEditingComplete,
      keyboardType: keyboardType,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onChanged: onChanged,
      decoration: InputDecoration(
          fillColor: fillColor,
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          errorText: errorText,
          errorStyle: AppStyles.textSmall.copyWith(color: AppColors.redColor),
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
          filled: true,
          border: _textInputBorder(),
          enabledBorder: _textInputEnableBorder(),
          focusedBorder: _textInpuFocusedBorder(),
          errorBorder: _textInpuErrorBorder()),
    );
  }

  OutlineInputBorder _textInputBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        borderSide: BorderSide(color: AppColors.iconColor, width: 2));
  }

  OutlineInputBorder _textInputEnableBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        borderSide: BorderSide(color: AppColors.inputColor, width: 2));
  }

  OutlineInputBorder _textInpuFocusedBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        borderSide: BorderSide(color: AppColors.buttonColor, width: 2));
  }

  OutlineInputBorder _textInpuErrorBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        borderSide: BorderSide(color: AppColors.redColor, width: 2));
  }
}
