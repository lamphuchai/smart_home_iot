import 'package:smart_home_iot/models/room/data_device.dart';

class Device {
  String id;
  String name;
  String topic;
  String typeDevice;
  bool isFavorites;
  bool status;
  List<dynamic> nameSwitches;
  DataDevice data;
  Device(
      {required this.id,
      required this.name,
      required this.status,
      required this.isFavorites,
      required this.topic,
      required this.typeDevice,
      required this.nameSwitches,
      required this.data});
  factory Device.fromJson(Map<String, dynamic> json) {
    final id = json["_id"] ?? "";
    final name = json["name"] as String;
    final topic = json["topic"] as String;
    final isFavorites = json["isFavorites"] ?? false;
    final status = json["status"] as bool;
    final typeDevice = json["typeDevice"] as String;
    // final List nameSwitches = json["nameSwitch"] ?? [];
    // print(json["nameSwitches"]);
    final data = DataDevice.fromJson(json["data"]);
    return Device(
        id: id,
        isFavorites: isFavorites,
        status: status,
        name: name,
        topic: topic,
        typeDevice: typeDevice,
        nameSwitches: typeDevice == "switch" ? ["switch1","switch2","switch3"] : [],
        data: data);
  }
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "isFavorites": isFavorites,
      "name": name,
      "topic": topic,
      "status": status,
      "typeDevice": typeDevice,
      "nameSwitch": nameSwitches.toString(),
      "data": data.toJson()
    };
  }

  Device copyWith(
          {String? id,
          String? name,
          bool? isFavorites,
          String? topic,
          String? typeDevice,
          bool? status,
          List<dynamic>? nameSwitches,
          DataDevice? data}) =>
      Device(
          id: id ?? this.id,
          isFavorites: isFavorites ?? this.isFavorites,
          status: status ?? this.status,
          name: name ?? this.name,
          topic: topic ?? this.topic,
          typeDevice: typeDevice ?? this.typeDevice,
          nameSwitches: nameSwitches ?? this.nameSwitches,
          data: data ?? this.data);
}
