import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_home_iot/models/room/device.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/services/constants/url_api.dart';

class RoomApi {
  static Future addRoom({required String id, String? nameRoom}) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {"nameRoom": nameRoom, "id": id};
      final response = await http.post(Uri.parse(Url.addRoom),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        return res;
      } else if (response.statusCode == 400) {
        return null;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future deleteRoom(
      {required String id, required String idDelete}) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {"idDelete": idDelete, "id": id};
      final response = await http.delete(Uri.parse(Url.deleteRoom),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        return res;
      } else if (response.statusCode == 400) {
        return null;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future upRoom(
      {required String id, required String idRoom, required Room room}) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {"idRoom": idRoom, "id": id, "room": room.toJson()};
      final response = await http.post(Uri.parse(Url.upRoom),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        return res;
      } else if (response.statusCode == 400) {
        return null;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future upDeviceRoom(
      {required String id,
      required int indexRoom,
      required int indexDevice,
      required Device device}) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {
        "indexRoom": indexRoom,
        "id": id,
        "indexDevice": indexDevice,
        "device": device
      };
      final response = await http.post(Uri.parse(Url.upDeviceRoom),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        return res;
      } else if (response.statusCode == 400) {




        return null;
        
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }


  static Future deleteDeviceRoom({
    required String id,
    required String idRoom,
    required String idDevice,
  }) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {
        "idRoom": idRoom,
        "id": id,
        "idDevice": idDevice,
      };
      final response = await http.post(Uri.parse(Url.deleteDeviceRoom),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        return res;
      } else if (response.statusCode == 400) {
        return null;
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
