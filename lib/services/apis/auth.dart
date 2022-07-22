import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_iot/services/constants/url_api.dart';

class Auth {
  static Future login({required String email, required String password}) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {"email": email, "password": password};
      final response = await http.post(Uri.parse(Url.login),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw e;
    }
  }

  static Future register(
      {required String userName,
      required String email,
      required String password}) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {"email": email, "password": password,"userName":userName};
      final response = await http.post(Uri.parse(Url.register),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      throw e;
    }
  }
}
