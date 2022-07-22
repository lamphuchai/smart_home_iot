import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_icons.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/events/event_model.dart';
import 'package:smart_home_iot/provider/events_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';

class EvenView extends StatelessWidget {
  const EvenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<EventModel> events = context.watch<EventsProvider>().events;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tự động"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              splashRadius: 25,
              onPressed: () {
                Navigator.pushNamed(context, RouteName.ifDddEvent);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [

          Container(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Chip(label: Text("ALL")),
                ),
                Chip(label: Text("Phong ngu")),
                Chip(label: Text("Phong ngu")),
                Chip(label: Text("Phong ngu")),
                Chip(label: Text("Phong ngu")),
                Chip(label: Text("Phong ngu")),
                Chip(label: Text("Phong ngu"))
              ],
            ),
          ),
          ListView.builder(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              itemCount: events.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  color: AppColors.inputColor,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.infoEvent,
                          arguments: event.id);
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 10, top: 4, bottom: 4),
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            event.eventName!,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.textSubtitle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  AppIcons.getIconDevice( event.ifEvent.type),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(Icons.timeline),
                                  ),
                                  AppIcons.getIconDevice( event.thenEvent.type)
                                ],
                              ),
                              Transform.scale(
                                scale: .6,
                                transformHitTests: false,
                                child: CupertinoSwitch(
                                  value: event.status,
                                  onChanged: (value) {
                                    EventsProvider eventsProvider =
                                        Provider.of<EventsProvider>(context,
                                            listen: false);
                                    eventsProvider.updateEvent(event.id!,
                                        event.copyWith(status: value));
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
