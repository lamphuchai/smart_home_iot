import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/mqtt/message_sensor.dart';
import 'package:smart_home_iot/models/room/device.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';

class Sensor extends StatelessWidget {
  final int indexRoom;
  final int indexDevice;
  const Sensor({Key? key, required this.indexDevice, required this.indexRoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Room room =
        Provider.of<ListRoomProvider>(context).getRoomIndex(index: indexRoom);
    if (indexDevice < room.devices.length) {
      Device device = room.devices[indexDevice];
      MessageSensor sensor = MessageSensor.fromJson(device.data.dataNow!);
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
                      "indexRoom": indexRoom,
                      "indexDevice": indexDevice
                    });
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // color: Colors.red,
              height: size.height * 0.8 / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: sensor.temperature.toString(),
                            style: Theme.of(context).textTheme.headline1),
                        TextSpan(
                            text: "°C",
                            style: Theme.of(context).textTheme.headline3)
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: sensor.humidity.toString(),
                            style: Theme.of(context).textTheme.headline4),
                        TextSpan(
                            text: " %",
                            style: Theme.of(context).textTheme.headline6)
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return const Scaffold();
    }
  }
}
