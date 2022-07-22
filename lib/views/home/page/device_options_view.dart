import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/room/device.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:smart_home_iot/widgets/modal/list_tile__modal_delete_bottom.dart';
import 'package:smart_home_iot/widgets/modal/list_tile_modal_text_input.dart';
import 'package:smart_home_iot/widgets/modal/list_tile_widget.dart';

class DeviceOptionsView extends StatelessWidget {
  final int indexDevice;
  final int indexRoom;
  const DeviceOptionsView(
      {Key? key, required this.indexDevice, required this.indexRoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textRoomController = TextEditingController();
    ListRoomProvider listRoomProvider = Provider.of<ListRoomProvider>(context);
    Room room = listRoomProvider.getRoomIndex(index: indexRoom);
    if (indexDevice < room.devices.length) {
      Device device = room.devices[indexDevice];
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("deviceOptions")),
        ),
        body: Column(
          children: [
            ListTileModalTextInput(
                subtitle: Text(
                    AppText.checkDevice(value: device.name, context: context)),
                title: AppLocalizations.of(context).translate("name_room"),
                onSubmit: () {
                  listRoomProvider.upDeviceRoom(
                      indexRoom: indexRoom,
                      indexDevice: indexDevice,
                      device: device.copyWith(name: _textRoomController.text));
                  Navigator.pop(context);
                },
                textEditingController: _textRoomController),
            ListTileWidget(
                onTap: () {
                  listRoomProvider.upDeviceRoom(
                      indexRoom: indexRoom,
                      indexDevice: indexDevice,
                      device:
                          device.copyWith(isFavorites: !device.isFavorites));
                },
                title: device.isFavorites
                    ? AppLocalizations.of(context).translate("delete_favorites")
                    : AppLocalizations.of(context).translate("add_favorites")),
            listTitleModelDelete(
                context: context,
                label: AppLocalizations.of(context).translate("delete_device"),
                buttonDelete: () async {
                  listRoomProvider.deleteDeviceById(
                      idRoom: room.id!, idDevice: device.id);
                  Navigator.pushReplacementNamed(context, RouteName.home,
                      arguments: {"indexRoom": indexRoom});
                }),
          ],
        ),
      );
    } else {
      return const Scaffold();
    }
  }
}
