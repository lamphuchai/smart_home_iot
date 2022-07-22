import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:ui' as ui;

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  Locale locale = ui.window.locale;
  String isLocale = "system";
  List<Locale> supportedLocales = const [
    Locale('vi', 'VN'),
    Locale('en', 'US'),
  ];
  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void changeLocale(String value) {
    switch (value) {
      case "system":
        supportedLocales.forEach((e) {
          if (e.languageCode == ui.window.locale.languageCode) {
            locale = e;
            isLocale = "system";
          }
        });
        break;
      case "en":
        locale = const Locale('en', 'US');
        isLocale = "en";
        break;
      case "vi":
        locale = const Locale('vi', 'VN');
        isLocale = "vi";
        break;
    }
    notifyListeners();
  }

  bool getIsLocale(String value) {
    if (value == isLocale) {
      return true;
    } else {
      return false;
    }
  }

  // Locale getLocale() {
  //   if (isLocale == "vi") {
  //     return const Locale('vi', 'VN');
  //   } else if (isLocale == "en") {
  //     return const Locale('en', 'US');
  //   } else {
  //     return ui.window.locale;
  //   }
  // }
}
