import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_iot/models/events/condition.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';

class AppText {
  static checkNameRoom(String value, BuildContext context) {
    switch (value) {
      case "favorites":
        return AppLocalizations.of(context).translate("favorites");
      case "living_room":
        return AppLocalizations.of(context).translate("living_room");
      case "bedroom":
        return AppLocalizations.of(context).translate("bedroom");
      default:
        return value;
    }
  }

  static checkDevice({required String value, required BuildContext context}) {
    switch (value) {
      case "sensor":
        return AppLocalizations.of(context).translate("sensor");
      case "switch":
        return AppLocalizations.of(context).translate("switch");
      default:
        return value;
    }
  }

  static checkDisplayEvent(
      {required String type,
      required String value,
      required BuildContext context}) {
    if (type == "timer") {
      return value;
    } else {
      switch (value) {
        case "all":
          return AppLocalizations.of(context).translate("all");
        case "false":
          return "ffffff";

        default:
          return value;
      }
    }
  }

  static checkTest(
      {required BuildContext context,
      required String type,
      required Condition condition}) {
    if (type == "timer") {
      return condition.value.toString() + " " + condition.condiRun.toString();
    } else {
      switch (condition.value) {
        case "all":
          return AppLocalizations.of(context).translate("all") +
              AppLocalizations.of(context).translate("device") +
              " " +
              AppLocalizations.of(context).translate(condition.condiRun);

        default:
          return AppLocalizations.of(context).translate(condition.value!) +
              " " +
              AppLocalizations.of(context).translate(condition.condiRun);
      }
    }
  }

  testText(BuildContext context, String type, Condition condition) {
    if (type == "timer") {
      return getTextTimer(condition);
    } else {
      return getTextDevice(condition, context);
    }
  }

  getTextTimer(Condition condition) {
    return condition.value.toString() + " " + condition.condiRun.toString();
  }

  getTextDevice(Condition condition, BuildContext context) {
    switch (condition.value) {
      case "all":
        return AppLocalizations.of(context).translate("all") +
            AppLocalizations.of(context).translate("device") +
            " " +
            AppLocalizations.of(context).translate(condition.condiRun);
    }
  }
}
