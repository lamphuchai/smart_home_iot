import 'dart:convert';
import 'package:smart_home_iot/models/events/event_model.dart';
import 'package:smart_home_iot/services/constants/url_api.dart';
import 'package:http/http.dart' as http;

class EventApi {
  static Future createEvent(String id, EventModel eventModel) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {"id": id, "event": eventModel};
      final response = await http.post(Uri.parse(Url.createEvent),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<bool> deleteEvent(String id, String idEvent) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {"id": id, "idEvent": idEvent};
      final response = await http.delete(Uri.parse(Url.deleteEvent),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<bool> updateEvent(
      String id, String idEvent, EventModel eventModel) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {"id": id, "idEvent": idEvent, "event": eventModel};
      final response = await http.post(Uri.parse(Url.updateEvent),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
