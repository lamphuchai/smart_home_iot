import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/mqtt/message_switch.dart';
import 'package:smart_home_iot/models/room/device.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:smart_home_iot/widgets/app_cards/app_card_device.dart';

class SwitchDevice extends StatefulWidget {
  final int indexRoom;
  final int indexDevice;
  const SwitchDevice(
      {Key? key, required this.indexDevice, required this.indexRoom})
      : super(key: key);

  @override
  State<SwitchDevice> createState() => _SwitchDeviceState();
}

class _SwitchDeviceState extends State<SwitchDevice> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Room room = Provider.of<ListRoomProvider>(context, listen: true)
        .getRoomIndex(index: widget.indexRoom);
    if (widget.indexDevice < room.devices.length) {
      Device device = room.devices[widget.indexDevice];
      MessageSwitch dataNow = MessageSwitch.fromJson(device.data.dataNow!);
      return Scaffold(
        appBar: AppBar(
          title:
              Text(AppText.checkDevice(value: device.name, context: context)),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                Navigator.pushNamed(context, RouteName.deviceOptions,
                    arguments: {
                      "indexRoom": widget.indexRoom,
                      "indexDevice": widget.indexDevice
                    });
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: size.height * 0.95 / 2,
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 190,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    appDeviceSwitch(
                        context: context,
                        onTap: () {
                          ListRoomProvider listRoomProvider =
                              Provider.of<ListRoomProvider>(context,
                                  listen: false);

                          listRoomProvider.publish(
                              topic: device.topic,
                              message: json.encode(
                                  dataNow.copyWith(switch1: !dataNow.switch1)));
                        },
                        status: dataNow.switch1,
                        title:
                            AppLocalizations.of(context).translate("switch1")),
                    appDeviceSwitch(
                        context: context,
                        onTap: () {
                          ListRoomProvider listRoomProvider =
                              Provider.of<ListRoomProvider>(context,
                                  listen: false);

                          listRoomProvider.publish(
                              topic: device.topic,
                              message: json.encode(
                                  dataNow.copyWith(switch2: !dataNow.switch2)));
                        },
                        status: dataNow.switch2,
                        title:
                            AppLocalizations.of(context).translate("switch1")),
                    appDeviceSwitch(
                        context: context,
                        onTap: () {
                          ListRoomProvider listRoomProvider =
                              Provider.of<ListRoomProvider>(context,
                                  listen: false);

                          listRoomProvider.publish(
                              topic: device.topic,
                              message: json.encode(
                                  dataNow.copyWith(switch3: !dataNow.switch3)));
                        },
                        status: dataNow.switch3,
                        title:
                            AppLocalizations.of(context).translate("switch1")),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buidlSwitchBottom(
                      onTap: () {
                        setState(() {
                          ListRoomProvider listRoomProvider =
                              Provider.of<ListRoomProvider>(context,
                                  listen: false);

                          listRoomProvider.publish(
                              topic: device.topic,
                              message: json.encode(dataNow.onAll()));
                        });
                      },
                      title: AppLocalizations.of(context).translate("on_all")),
                  _buidlSwitchBottom(
                      onTap: () {
                        setState(() {
                          ListRoomProvider listRoomProvider =
                              Provider.of<ListRoomProvider>(context,
                                  listen: false);

                          listRoomProvider.publish(
                              topic: device.topic,
                              message: json.encode(dataNow.onOFF()));
                        });
                      },
                      title: AppLocalizations.of(context).translate("off_all"))
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return const Scaffold();
    }
  }

  _buidlSwitchBottom({required VoidCallback onTap, required String title}) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          const Icon(
            Icons.power_settings_new,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(title),
          )
        ],
      ),
    );
  }
}
