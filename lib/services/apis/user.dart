import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:smart_home_iot/data/sharedpref/shared_preference_helper.dart';
import 'package:smart_home_iot/services/constants/url_api.dart';
import 'package:http_parser/http_parser.dart';

class UserApi {
  static Future getDataUser() async {
    try {
      final id = await SharedPreferenceHelper().getId();

      Map<String, String> headers = {"Content-type": "application/json"};
      final response =
          await http.get(Uri.parse(Url.getData + id!), headers: headers);
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

  static Future upImage({required String id,required String path}) async {
    try {
      final request = http.MultipartRequest("POST", Uri.parse(Url.upLoadImage));
      final pic = await http.MultipartFile.fromPath("Image", path,
          contentType: MediaType('image', 'jpeg'));

      request.files.add(pic);
      request.fields['id'] = id;
      await request.send();
      return true;
    } catch (err) {
      print(err.toString());
      throw err;
    }
  }
}
