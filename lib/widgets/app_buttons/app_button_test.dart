import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appButton(BuildContext context, {required String title,required VoidCallback onPressed,Color ? color}) {
  Size size = MediaQuery.of(context).size;
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
          minimumSize: Size(size.width * 1.2 / 3, 45),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      onPressed:onPressed,
      child: Text(title));
}
