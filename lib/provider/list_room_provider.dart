import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:smart_home_iot/data/sharedpref/shared_preference_helper.dart';
import 'package:smart_home_iot/models/room/device.dart';
import 'package:smart_home_iot/models/room/favorites.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/services/apis/room_api.dart';
import 'package:smart_home_iot/services/mqtt_services.dart';

class ListRoomProvider extends ChangeNotifier {
  List<Room> listRoom = [];
  List<String> listOtherDevice = [];
  late MqttServices _mqttServices;

  late Map<String, dynamic> messageMqtt;

  // -----------------MQTT---------------------

  initMqtt(ListRoomProvider listRoomProvider) {
    _mqttServices = MqttServices(listRoomProvider: listRoomProvider);
  }

  setMessage(Map<String, dynamic> messageMqtt) {
    messageMqtt = messageMqtt;
    checkAndUpdate(messageMqtt);
    notifyListeners();
  }

  subscribe({required String topic}) {
    return _mqttServices.subscribe(topic: topic);
  }

  publish({required String topic, required String message}) {
    return _mqttServices.publish(message: message, topic: topic);
  }

  checkAndUpdate(Map<String, dynamic> message) {
    for (var room in listRoom) {
      for (int i = 0; i < room.devices.length; i++) {
        if (room.devices[i].topic == message["topic"]) {
          final payload = jsonDecode(message["payload"]);
          room.devices[i].data =
              room.devices[i].data.copyWith(dataNow: payload);
          notifyListeners();
        }
      }
    }
  }

  subscribeTopicList() async {
    Future.delayed(const Duration(seconds: 2), () {
      for (var room in listRoom) {
        for (var device in room.devices) {
          subscribe(topic: device.topic);
        }
      }
    });
  }
  // -----------------END - MQTT---------------
  // -------------------ROOM-------------------

  setListRoom(List tmp) async {
    listRoom = tmp.map((room) => Room.fromJson(room)).toList();
    notifyListeners();
  }

  addRoom({String? nameRoom}) async {
    try {
      final id = await SharedPreferenceHelper().getId();
      final data = await RoomApi.addRoom(id: id!, nameRoom: nameRoom);
      Room room = Room.fromJson(data);
      listRoom.add(room);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  List<Favorites> getFavorites() {
    List<Favorites> favorites = [];
    for (var room in listRoom) {
      for (int indexDevice = 0;
          indexDevice < room.devices.length;
          indexDevice++) {
        if (room.devices[indexDevice].isFavorites) {
          favorites.add(Favorites(
              indexRoom: listRoom.indexOf(room),
              indexDevice: indexDevice,
              device: room.devices[indexDevice]));
        }
      }
    }
    return favorites;
  }

  Room getRoomIndex({required int index}) {
    return listRoom[index];
  }

  getRoomId(String id) {
    return listRoom.where((room) => room.id == id);
  }

  upRoomIndex({required int index, required Room room}) async {
    final id = await SharedPreferenceHelper().getId();
    await RoomApi.upRoom(id: id!, idRoom: room.id!, room: room);
    listRoom[index] = room;
    notifyListeners();
  }

  upDeviceRoom(
      {required int indexRoom,
      required int indexDevice,
      required Device device}) async {
    final id = await SharedPreferenceHelper().getId();
    await RoomApi.upDeviceRoom(
        id: id!,
        indexRoom: indexRoom,
        indexDevice: indexDevice,
        device: device);

    listRoom[indexRoom].devices[indexDevice] = device;
    notifyListeners();
  }

  deleteRoomById(String idRoom) async {
    final id = await SharedPreferenceHelper().getId();
    await RoomApi.deleteRoom(id: id!, idDelete: idRoom);
    listRoom.removeWhere((room) => room.id == idRoom);
    notifyListeners();
  }

  findRoomById(String id) {
    return listRoom.where((room) => room.id == id);
  }

  getDeviceById(String id) {
    for (var room in listRoom) {
      for (var device in room.devices) {
        if (device.id == id) {

          return device;
        }
      }
    }
    return null;
  }

  deleteDeviceById({required String idRoom, required String idDevice}) async {
    int indeRoom = listRoom.indexWhere((room) => room.id == idRoom);
    if (indeRoom != -1) {
      final id = await SharedPreferenceHelper().getId();
      await RoomApi.deleteDeviceRoom(
          id: id!, idRoom: idRoom, idDevice: idDevice);
      listRoom[indeRoom].devices.removeWhere((device) => device.id == idDevice);
      notifyListeners();
      return true;
    }
    {
      return false;
    }
  }

  // -----------------END - Room----------------
  // ----------------Other Device---------------
  setListOtherDevice(value) {
    listOtherDevice = ["Chung cư Hà Thành", "Khu phố bạch đằng"];
  }

  getOtherDevice({required int index}) {
    return listOtherDevice[index];
  }

  deleteOtherDevice({required int index}) {
    listOtherDevice.removeAt(index);
    notifyListeners();
  }

  updateNodeOtherDevice({required int index, required String node}) {
    listOtherDevice[index] = node;
    notifyListeners();
  }
  // -------------END - Other - Device------------

}
