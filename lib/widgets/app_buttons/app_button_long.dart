import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_styles.dart';

class AppButtonLong extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color color;
  final Color? colorText;
  final FocusNode? focusNode;
  const AppButtonLong(
      {Key? key,
      this.colorText,
      this.focusNode,
      required this.label,
      required this.onPressed,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
        focusNode: focusNode,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            primary: color,
            minimumSize: Size(size.width * 1.5 / 2, 55)),
        child: Text(
          label,
          style: AppStyles.h4.copyWith(color: colorText),
        ));
  }
}
