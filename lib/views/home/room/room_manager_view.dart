import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';

class RoomManagerView extends StatelessWidget {
  const RoomManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Room> listRoom = Provider.of<ListRoomProvider>(context).listRoom;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("room_manager")),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: listRoom.length,
          itemBuilder: (context, index) {
            Room room = listRoom[index];
            return ListTile(
              key: ValueKey(room),
              title: Text(AppText.checkNameRoom(room.nameRoom, context) ??
                  room.nameRoom),
              subtitle: Text(room.devices.length.toString() +
                  AppLocalizations.of(context).translate("device")),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, RouteName.editRoom,
                    arguments: index);
              },
            );
          }),
    );
  }
}
