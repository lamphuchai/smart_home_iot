import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:smart_home_iot/data/sharedpref/shared_preference_helper.dart';
import 'package:smart_home_iot/models/events/event_model.dart';
import 'package:smart_home_iot/services/apis/event_api.dart';

class EventsProvider extends ChangeNotifier {
  List<EventModel> events = [];
  setEvents(List tmp) {
    events = tmp.map((e) => EventModel.fromJson(e)).toList();
    notifyListeners();
  }

  Future<bool> createEvent(EventModel eventModel) async {
    final id = await SharedPreferenceHelper().getId();
    final eventApi = await EventApi.createEvent(id!, eventModel);
    if (eventApi != null) {
      events.add(EventModel.fromJson(eventApi));
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  getEventById(String id) {
    for (var event in events) {
      if (event.id == id) {
        return event;
      }
    }
    return null;
  }

  Future updateEvent(String idEvent, EventModel eventModel) async {
    final id = await SharedPreferenceHelper().getId();
    await EventApi.updateEvent(id!, idEvent, eventModel);
    for (var event in events) {
      if (event.id == idEvent) {
        int index = events.indexOf(event);
        events[index] = eventModel;
        notifyListeners();
      }
    }
  }

  Future deleteEvent(String idEvent) async {
    final id = await SharedPreferenceHelper().getId();
    final delete = await EventApi.deleteEvent(id!, idEvent);
    if (delete) {
      events = events.where((event) => event.id != idEvent).toList();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
