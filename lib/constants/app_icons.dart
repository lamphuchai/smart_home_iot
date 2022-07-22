import 'package:flutter/material.dart';

class AppIcons {
  static String pathIcon = "assets/icons/";
  static String home = pathIcon + "Home.png";

  static getIconDevice(String typeDevice) {
    switch (typeDevice) {
      case "timer":
        return const Icon(Icons.schedule);
      case "switch":
        return const Icon(Icons.touch_app);
      case "sensor":
        return const Icon(Icons.device_thermostat);
      case "loraDevice":
        return const Icon(Icons.add);
    }
  }
}
