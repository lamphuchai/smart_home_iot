import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_home_iot/models/user/user.dart';
import 'package:smart_home_iot/services/apis/user.dart';

class UserProvider extends ChangeNotifier {
  late User user;
  initUser(
      {required String userName,
      required String email,
      required String image}) {
    user = User(userName: userName, email: email, image: image);
  }

  Future<bool> upLoadImage({required String type}) async {
    final ImagePicker _picker = ImagePicker();
    if (type == "camera") {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      final path = photo?.path;
      if (path != null) {
        await UserApi.upImage(path: path, id: "test");
        return true;
      }
      return false;
    } else {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      final path = image?.path;
      if (path != null) {
        await UserApi.upImage(path: path, id: "test");
        return true;
      }
      return false;
    }
  }
}
