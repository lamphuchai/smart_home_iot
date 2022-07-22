import 'package:smart_home_iot/models/room/device.dart';

class Room {
  final String nameRoom;
  final String? id;
  final String? color;
  final String? icon;

  final List<Device> devices;
  Room({
    this.id,
    required this.nameRoom,
    this.color,
    required this.devices,
    required this.icon,
  });
  factory Room.fromJson(Map<String, dynamic> json) {
    final id = json["_id"];
    final nameRoom = json["nameRoom"] as String;
    final color = json["color"];
    final icon = json["icon"];
    final devicesData = json["devices"] as List<dynamic>?;
    final devices = devicesData != null
        ? devicesData
            .map((devicesData) => Device.fromJson(devicesData))
            .toList()
        : <Device>[];
    return Room(
        nameRoom: nameRoom,
        color: color ?? "",
        devices: devices,
        icon: icon ?? "",
        id: id ?? "");
  }
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "nameRoom": nameRoom,
      "color": color,
      "icon": icon,
      "devices": devices.map((e) => e.toJson()).toList()
    };
  }

  Room copyWith(
      {String? nameRoom,
      String? id,
      String? color,
      String? icon,
      List<Device>? devices}) {
    return Room(
        nameRoom: nameRoom ?? this.nameRoom,
        id: id ?? this.id,
        color: color ?? this.color,
        icon: icon ?? this.icon,
        devices: devices ?? this.devices);
  }

  Room withDevice({required Device device, required int indexDevice}) {
    devices[0] = device;
    return copyWith(devices: devices);
  }

  void deleteDevice({required int indexDevice}) {
    devices.removeAt(indexDevice);
  }

  upDevice({required int indexDevice, required Device device}) {
    devices[indexDevice] = device;
    return devices;
  }

  deviceById(String id) {
    for (var device in devices) {
      if (device.id == id) {
        return device;
      }
    }
    return null;
  }
}
