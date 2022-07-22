import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/widgets/app_cards/app_card_device.dart';

class RoomPage extends StatelessWidget {
  final int indexRoom;
  final VoidCallback onTap;
  const RoomPage({Key? key, required this.indexRoom, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListRoomProvider listRoomProvider = Provider.of<ListRoomProvider>(context);
    Room room = listRoomProvider.getRoomIndex(index: indexRoom);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: room.devices.isEmpty
            ? _buildCardEmpty(context)
            : _buildGrildWiewDevice(context, room),
      ),
    );
  }

  Widget _buildCardEmpty(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 70),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: 120,
          child: Center(
            child: Text(
              "Không có thiết bị",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrildWiewDevice(BuildContext context, Room room) {
    Size size = MediaQuery.of(context).size;
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: ((size.width * 1 / 2 - 24) / 180),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: room.devices.map((device) {
        int indexDevice = room.devices.indexOf(device);
        switch (device.typeDevice) {
          case "switch":
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: appCardDeviceSwitch(
                  title:
                      AppText.checkDevice(value: device.name, context: context),
                  context: context,
                  value: device.status,
                  onChanged: (value) {
                    ListRoomProvider listRoomProvider =
                        Provider.of<ListRoomProvider>(context, listen: false);
                    listRoomProvider.upDeviceRoom(
                        indexRoom: indexRoom,
                        indexDevice: indexDevice,
                        device: device.copyWith(status: value));
                  },
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.swicthDevice,
                        arguments: {
                          "indexDevice": room.devices.indexOf(device),
                          "indexRoom": indexRoom
                        });
                  }),
            );

          case "sensor":
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: appCardDeviceSensor(
                  name:
                      AppText.checkDevice(value: device.name, context: context),
                  data: device.data.dataNow!,
                  context: context,
                  value: device.status,
                  onChanged: (value) {
                    ListRoomProvider listRoomProvider =
                        Provider.of<ListRoomProvider>(context, listen: false);
                    listRoomProvider.upDeviceRoom(
                        indexRoom: indexRoom,
                        indexDevice: indexDevice,
                        device: device.copyWith(status: value));
                  },
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.sensorDevice,
                        arguments: {
                          "indexDevice": room.devices.indexOf(device),
                          "indexRoom": indexRoom
                        });
                  }),
            );

          case "loraDevice":
            return Padding(
                padding: const EdgeInsets.all(3.0),
                child: appCardLoraDevice(
                    context: context,
                    title: device.name,
                    value: device.status,
                    onChanged: (value) {
                      ListRoomProvider listRoomProvider =
                          Provider.of<ListRoomProvider>(context, listen: false);
                      listRoomProvider.upDeviceRoom(
                          indexRoom: indexRoom,
                          indexDevice: indexDevice,
                          device: device.copyWith(status: value));
                    },
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.otherDevice,
                          arguments: {"indexDevice": 1});
                    }));
          default:
            return Container();
        }
      }).toList(),
    );
  }
}
