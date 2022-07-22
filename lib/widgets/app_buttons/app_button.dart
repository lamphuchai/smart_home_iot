import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';

class AppButton extends StatelessWidget {
  final String lable;
  final VoidCallback onPressed;
  final Color ?color;
  const AppButton(
      {Key? key,
      required this.lable,
      required this.onPressed,
       this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minimumSize: Size(size.width * 1 / 3 + 30, 45)),
        onPressed: onPressed,
        child: Text(
          lable,
          style: AppStyles.textLarge.copyWith(color: AppColors.white),
        ));
  }
}
