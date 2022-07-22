import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/models/events/condition.dart';
import 'package:smart_home_iot/models/events/event.dart';
import 'package:smart_home_iot/models/events/event_model.dart';
import 'package:smart_home_iot/models/room/device.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';

class SwitchDeviceEvent extends StatefulWidget {
  final Event? event;
  final Device device;
  const SwitchDeviceEvent({Key? key, this.event, required this.device})
      : super(key: key);

  @override
  State<SwitchDeviceEvent> createState() => _SwitchDeviceEventState();
}

class _SwitchDeviceEventState extends State<SwitchDeviceEvent> {
  String eventValue = "all";
  String switchStatus = "on";
  String _displayNameDeivce = "all";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Thêm sự kiện"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            child: Text(
              "Ok",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onPressed: () {
              Condition condition =
                  Condition(value: _displayNameDeivce, condiRun: switchStatus);
              Event event = Event(
                  type: "switch",
                  idDevice: widget.device.id,
                  condition: condition);
              if (widget.event == null) {
                Navigator.pushNamed(context, RouteName.thenAddVent,
                    arguments: {"event": event});
              } else {
                EventModel eventModel = EventModel(
                    ifEvent: widget.event!, thenEvent: event, status: true);
                Navigator.pushNamed(context, RouteName.completeEvent,
                    arguments: {"eventModel": eventModel});
              }
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15))),
                    context: context,
                    builder: (context) => SizedBox(
                          height: 200,
                          child: Center(
                              child: CupertinoPicker(
                            useMagnifier: true,
                            magnification: 1,
                            itemExtent: 50,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(AppLocalizations.of(context)
                                    .translate("all")),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(AppLocalizations.of(context)
                                    .translate(widget.device.nameSwitches[0])),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(AppLocalizations.of(context)
                                      .translate(
                                          widget.device.nameSwitches[1]))),
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(AppLocalizations.of(context)
                                      .translate(
                                          widget.device.nameSwitches[2])))
                            ],
                            onSelectedItemChanged: (value) {
                              switch (value) {
                                case 0:
                                  setState(() {
                                    eventValue = "all";
                                    _displayNameDeivce = "all";
                                  });
                                  break;
                                case 1:
                                  setState(() {
                                    eventValue = "switch1";
                                    _displayNameDeivce =
                                        widget.device.nameSwitches[0];
                                  });
                                  break;
                                case 2:
                                  setState(() {
                                    eventValue = "switch2";
                                    _displayNameDeivce =
                                        widget.device.nameSwitches[1];
                                  });
                                  break;

                                case 3:
                                  setState(() {
                                    eventValue = "switch3";
                                    _displayNameDeivce =
                                        widget.device.nameSwitches[2];
                                  });
                                  break;
                              }
                            },
                          )),
                        ));
              },
              customBorder: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(15))),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: size.width * 1 / 2 - 20,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.iconColor),
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(15))),
                child: Text(_displayNameDeivce == "all"
                    ? AppLocalizations.of(context).translate("all")
                    : AppLocalizations.of(context)
                        .translate(_displayNameDeivce)),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15))),
                    context: context,
                    builder: (context) => SizedBox(
                          height: 150,
                          child: Center(
                              child: CupertinoPicker(
                            useMagnifier: true,
                            magnification: 1,
                            itemExtent: 50,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(AppLocalizations.of(context)
                                    .translate("on")),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(AppLocalizations.of(context)
                                    .translate("off")),
                              )
                            ],
                            onSelectedItemChanged: (value) {
                              switch (value) {
                                case 0:
                                  setState(() {
                                    switchStatus = "on";
                                  });
                                  break;
                                case 1:
                                  setState(() {
                                    switchStatus = "off";
                                  });
                                  break;
                              }
                            },
                          )),
                        ));
              },
              customBorder: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(15))),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: size.width * 1 / 2 - 20,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.iconColor),
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(15))),
                child:
                    Text(AppLocalizations.of(context).translate(switchStatus)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
