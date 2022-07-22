import 'package:smart_home_iot/models/events/event.dart';

class EventModel {
  String? id;
  bool status;
  String? eventName;
  Event ifEvent;
  Event thenEvent;
  EventModel(
      { this.eventName,
       this.id,
      required this.ifEvent,
      required this.thenEvent,
      required this.status});
  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
      id: json["_id"],
      status: json["status"],
      eventName: json["eventName"],
      ifEvent: Event.fromJson(json["ifEvent"]),
      thenEvent: Event.fromJson(json["thenEvent"]));
  Map<String, dynamic> toJson() => {
        "eventName": eventName,
        "status": status,
        "ifEvent": ifEvent.toJson(),
        "thenEvent": thenEvent.toJson()
      };
  EventModel copyWith(
          {String? eventName,
          String? id,
          Event? ifEvent,
          Event? thenEvent,
          bool? status}) =>
      EventModel(
          id: id ?? this.id,
          eventName: eventName ?? this.eventName,
          status: status ?? this.status,
          ifEvent: ifEvent ?? this.ifEvent,
          thenEvent: thenEvent ?? this.thenEvent);
  get getIfEvent => ifEvent;
  get getThenEvent => thenEvent;
}
