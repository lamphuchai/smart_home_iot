import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_icons.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/events/event.dart';
import 'package:smart_home_iot/models/events/event_model.dart';
import 'package:smart_home_iot/models/room/device.dart';
import 'package:smart_home_iot/provider/events_provider.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';

class InfoEvent extends StatelessWidget {
  final String id;
  const InfoEvent({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final event = Provider.of<EventsProvider>(context).getEventById(id);
    if (event != null) {
      EventModel eventModel = event;
      return Scaffold(
        appBar: AppBar(
          title: Text(eventModel.eventName!),
          actions: [
            IconButton(
                splashRadius: 27,
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.eventOptinons,
                      arguments: id);
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _buildListTile(
                  context: context,
                  title: AppLocalizations.of(context).translate("if")),
              _buildItemEvent(
                  size,
                  context,
                  eventModel.ifEvent,
                  _getNameDeivce(context, eventModel.ifEvent.idDevice,
                      eventModel.ifEvent.type)),
              _buildListTile(
                  context: context,
                  title: AppLocalizations.of(context).translate("then")),
              _buildItemEvent(
                  size,
                  context,
                  eventModel.ifEvent,
                  _getNameDeivce(context, eventModel.thenEvent.idDevice,
                      eventModel.thenEvent.type))
            ],
          ),
        ),
      );
    } else {
      return const Scaffold();
    }
  }

  Row _buildItemEvent(
      Size size, BuildContext context, Event event, String nameDevice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: size.width * 1 / 2 - 15,
          height: 60,
          // color: AppColors.buttonColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  AppText.checkTest(
                      context: context,
                      type: event.type,
                      condition: event.condition),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis)
            ],
          ),
        ),
        SizedBox(
          width: size.width * 1 / 2 - 15,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppText.checkDevice(value: nameDevice, context: context),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              AppIcons.getIconDevice(event.type)
            ],
          ),
        )
      ],
    );
  }

  ListTile _buildListTile(
      {required String title, required BuildContext context}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.inputColor),
        child: const Icon(
          Icons.list,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  _getNameDeivce(BuildContext context, String id, String type) {
    if (type == "timer") {
      return ("Hen Gio ");
    } else {
      ListRoomProvider listRoomProvider =
          Provider.of<ListRoomProvider>(context);
      final tmp = listRoomProvider.getDeviceById(id);
      if (tmp == null) {
        return "";
      } else {
        Device device = tmp;
        return device.name;
      }
    }
  }
}
