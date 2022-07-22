import 'package:smart_home_iot/models/events/condition.dart';

class Event {
  String type;
  String idDevice;
  Condition condition;
  Event({required this.type, required this.idDevice, required this.condition});
  factory Event.fromJson(Map<String, dynamic> json) => Event(
      type: json["type"],
      idDevice: json["idDevice"],
      condition: Condition.fromJson(json["condition"]));
  Map<String, dynamic> toJson() =>
      {"type": type, "idDevice": idDevice, "condition": condition.toJson()};
}
