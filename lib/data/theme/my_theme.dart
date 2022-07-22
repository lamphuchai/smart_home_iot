import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xff212121),
    primaryColorBrightness: Brightness.dark,
    iconTheme: const IconThemeData(color: Colors.white),
    tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        labelStyle: TextStyle(fontSize: 19),
        unselectedLabelColor: Colors.white38,
        unselectedLabelStyle: TextStyle(fontSize: 19)),
    popupMenuTheme: PopupMenuThemeData(
      elevation: 1,
      // color: Colors.,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.black12, width: 0.7),
      ),
    ),
    cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(width: 0.7))),
  );
  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      primaryColorBrightness: Brightness.light,
      // iconTheme: const IconThemeData(color: Colors.black),
      primaryIconTheme: const IconThemeData(color: Colors.black),
      // ----------App bar theme
      appBarTheme: const AppBarTheme(
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              fontSize: 19, color: Colors.black, fontWeight: FontWeight.w500)),
      tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 19),
          unselectedLabelColor: Colors.black38,
          unselectedLabelStyle: TextStyle(fontSize: 19)),
      popupMenuTheme: PopupMenuThemeData(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black12, width: 0.7)),
      ),
      cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.black12, width: 0.7)))
      // ----------App bar theme end
      );
}
