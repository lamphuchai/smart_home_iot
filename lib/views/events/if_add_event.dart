import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_icons.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';

class IfAddEvent extends StatelessWidget {
  const IfAddEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Room> listRoom = Provider.of<ListRoomProvider>(context).listRoom;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context).translate("select_conditions")),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("if") + ". . .",
                    style: AppStyles.h3.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Sự kiện sẳn có",
                      style: AppStyles.textLarge,
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.alarm_on,
                          color: AppColors.buttonColor,
                        ),
                        title: Text(
                          "Hẹn giờ",
                          style: AppStyles.textSmall,
                        ),
                        trailing: const Icon(Icons.arrow_right),
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.timerEvent);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 1,
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: listRoom.map((room) {
                  if (room.devices.isEmpty) {
                    return Container();
                  } else {
                    return _buildEvenDeviceRoom(
                        context, room, listRoom.indexOf(room));
                  }
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildEvenDeviceRoom(BuildContext context, Room room, int indexRoom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            AppText.checkNameRoom(room.nameRoom, context),
            style: AppStyles.textLarge,
          ),
        ),
        const Divider(
          height: 1,
        ),
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: ListTile.divideTiles(
              context: context,
              tiles: room.devices.map((device) {
                return ListTile(
                  leading: AppIcons.getIconDevice(device.typeDevice),
                  title: Text(
                      AppText.checkDevice(value: device.name, context: context),
                      style: AppStyles.textSmall),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    switch (device.typeDevice) {
                      case "switch":
                        Navigator.pushNamed(context, RouteName.switchEvent,
                            arguments: {"device": device});
                        break;
                      case "sensor":
                        Navigator.pushNamed(context, RouteName.sensorEvent);
                        break;
                    }
                  },
                );
              })).toList(),
        ),
      ],
    );
  }
}
