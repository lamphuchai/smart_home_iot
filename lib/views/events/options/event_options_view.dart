import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/models/events/event_model.dart';
import 'package:smart_home_iot/provider/events_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:smart_home_iot/widgets/modal/list_tile__modal_delete_bottom.dart';
import 'package:smart_home_iot/widgets/modal/list_tile_modal_text_input.dart';

class EventOptionsView extends StatelessWidget {
  final String id;
  const EventOptionsView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    final tmp = Provider.of<EventsProvider>(context).getEventById(id);
    if (tmp != null) {
      EventModel eventModel = tmp;
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("options")),
        ),
        body: Column(
          children: [
            ListTileModalTextInput(
              title: "Name Event",
              textEditingController: textEditingController,
              subtitle: Text(eventModel.eventName!),
              onSubmit: () {
                eventsProvider.updateEvent(id,
                    eventModel.copyWith(eventName: textEditingController.text));
                Navigator.pop(context);
              },
            ),
            listTitleModelDelete(
                context: context,
                label: "ff",
                buttonDelete: () async {
                  await eventsProvider.deleteEvent(id);
                  Navigator.pushReplacementNamed(context, RouteName.home,
                      arguments: {"index": 2});
                })
          ],
        ),
      );
    } else {
      return const Scaffold();
    }
  }
}
