import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';

class TextFieldWidgets extends StatelessWidget {
  final TextEditingController textController;
  final bool? autofocus;
  final TextCapitalization? textCapitalization;
  final String? label;
  final String? hintText;
  const TextFieldWidgets(
      {Key? key,
      required this.textController,
      this.label,
      this.hintText,
      this.textCapitalization,
      this.autofocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        autofocus: autofocus ?? false,
        controller: textController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 19),
          labelText: label,
          labelStyle: AppStyles.textLarge,
          hintText: hintText,
          hintStyle: AppStyles.textLarge.copyWith(color: AppColors.iconColor),
          filled: true,
          focusedBorder: _outlineInputBorder(),
          enabledBorder: _outlineInputBorder(),
          border: _outlineInputBorder(),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: IconButton(
              splashRadius: 30,
              icon: const Icon(
                Icons.close,
                color: AppColors.iconColor,
              ),
              onPressed: () {
                textController.text = "";
              },
            ),
          ),
        ));
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: AppColors.inputColor));
  }
}
