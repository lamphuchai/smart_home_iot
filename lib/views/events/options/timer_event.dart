import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/models/events/condition.dart';
import 'package:smart_home_iot/models/events/event.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';

class TimerEvent extends StatefulWidget {
  const TimerEvent({Key? key}) : super(key: key);

  @override
  State<TimerEvent> createState() => _TimerEventState();
}

class _TimerEventState extends State<TimerEvent> {
  int timeEvent = 0;
  String typeTime = "Một lần";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: Text(
            "Hủy",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("schedule")),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            child: Text(
              "Ok",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onPressed: timeEvent != 0
                ? () {
                    Condition condition =
                        Condition(value: typeTime, condiRun: timeEvent);
                    Event event = Event(
                        type: "timer", idDevice: "timer", condition: condition);
                    Navigator.pushNamed(context, RouteName.thenAddVent,
                        arguments: {"event": event});
                  }
                : null,
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                trailing: const Icon(Icons.chevron_right),
                title: Text(
                  "Lặp lại",
                  style: AppStyles.textMedium,
                ),
                subtitle: Text(
                  typeTime,
                  style:
                      AppStyles.textCation.copyWith(color: AppColors.iconColor),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                        color: AppColors.inputColor, width: 1)),
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15))),
                      context: context,
                      builder: (context) => Container(
                            height: 115,
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    setState(() {
                                      typeTime = "Một lần";
                                    });
                                    Navigator.pop(context);
                                  },
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(15))),
                                  title: const Text("Một lần"),
                                  leading: Icon(Icons.navigate_next,
                                      color: typeTime == "Một lần"
                                          ? AppColors.buttonColor
                                          : AppColors.white),
                                ),
                                ListTile(
                                  onTap: () {
                                    setState(() {
                                      typeTime = "Hằng ngày";
                                    });
                                    Navigator.pop(context);
                                  },
                                  title: const Text("Hằng ngày"),
                                  leading: Icon(Icons.navigate_next,
                                      color: typeTime == "Hằng ngày"
                                          ? AppColors.buttonColor
                                          : AppColors.white),
                                )
                              ],
                            ),
                          ));
                },
              ),
              CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (value) {
                  int m = value.inMinutes.remainder(60);
                  int h = value.inHours;
                  setState(() {
                    timeEvent = 3;
                  });
                },
              ),
            ],
          )),
    );
  }
}
