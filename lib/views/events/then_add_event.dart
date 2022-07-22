import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/events/event.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';

class ThenAddEvent extends StatelessWidget {
  final Event? event;
  const ThenAddEvent({Key? key, this.event}) : super(key: key);

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
              Container(
                height: 100,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).translate("then") + ". . .",
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
              tiles: room.devices.map((device) => ListTile(
                    leading: const Icon(Icons.lock_clock),
                    title: Text(
                        AppText.checkDevice(
                            value: device.name, context: context),
                        style: AppStyles.textSmall),
                    trailing: const Icon(Icons.arrow_right),
                    onTap: () {
                      // int indexDeivce = room.devices.indexOf(device);
                      // print("indexRoom $indexRoom indexDevice $indexDeivce");
                      Navigator.pushNamed(context, RouteName.switchEvent,
                          arguments: {"device": device, "event": event});
                    },
                  ))).toList(),
        ),
      ],
    );
  }
}
