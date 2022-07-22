import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_icons.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/events/event.dart';
import 'package:smart_home_iot/models/events/event_model.dart';
import 'package:smart_home_iot/models/room/device.dart';
import 'package:smart_home_iot/provider/events_provider.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button_test.dart';
import 'package:smart_home_iot/widgets/text_field_widgets.dart';

class AddNewEvents extends StatelessWidget {
  EventModel eventModel;
  AddNewEvents({Key? key, required this.eventModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListRoomProvider listRoomProvider = Provider.of<ListRoomProvider>(context);
    Event ifEvent = eventModel.getIfEvent;
    Event thenEvent = eventModel.getThenEvent;
    late Device ifDevice;
    late Device thenDevice;
    final tmpIfDevice = listRoomProvider.getDeviceById(ifEvent.idDevice);
    final tmpThenDevice = listRoomProvider.getDeviceById(thenEvent.idDevice);
    if (tmpIfDevice != null) {
      ifDevice = tmpIfDevice;
    }
    if (tmpThenDevice != null) {
      thenDevice = tmpThenDevice;
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("add_new_events")),
        actions: [
          IconButton(
              splashRadius: 27,
              onPressed: () {
                _buildShowModelTextField(context);
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            _buildListTile(
                context: context,
                title: AppLocalizations.of(context).translate("if")),
            _buildItemEvent(size, context, ifEvent,
                ifEvent.type == "timer" ? null : ifDevice),
            _buildListTile(
                context: context,
                title: AppLocalizations.of(context).translate("then")),
            _buildItemEvent(size, context, thenEvent, thenDevice),
          ],
        ),
      ),
    );
  }

  Row _buildItemEvent(
      Size size, BuildContext context, Event event, Device? device) {
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
        Container(
          width: size.width * 1 / 2 - 15,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(event.type == "timer"
                  ? "Hen gio su kien"
                  : AppLocalizations.of(context).translate(device!.name)),
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

  _buildShowModelTextField(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate("set_name"),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextFieldWidgets(
                      textController: textEditingController,
                      autofocus: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppButton(
                            lable: AppLocalizations.of(context)
                                .translate("cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        AppButton(
                            lable:
                                AppLocalizations.of(context).translate("save"),
                            onPressed: () async {
                              EventsProvider eventsProvider =
                                  Provider.of<EventsProvider>(context,
                                      listen: false);
                              eventModel = eventModel.copyWith(
                                  eventName: textEditingController.text);
                              final eventApi =
                                  await eventsProvider.createEvent(eventModel);
                              eventApi
                                  ? Navigator.pushReplacementNamed(
                                      context, RouteName.home,
                                      arguments: {"index": 2})
                                  : null;
                            })
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
