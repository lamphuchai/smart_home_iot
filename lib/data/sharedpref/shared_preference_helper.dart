import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home_iot/data/sharedpref/constants/preferences.dart';

class SharedPreferenceHelper {
  // Methods toke : ---------------------------------
  Future<String?> get authToken async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String token) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.setString(Preferences.auth_token, token);
  }

  Future<bool> removeAuthToken() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.remove(Preferences.auth_token);
  }

  // Login : ---------------------
  Future<bool> get isLogin async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(Preferences.is_login) ?? false;
  }

  Future<bool> saveIsLogin(bool value) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.setBool(Preferences.is_login, value);
  }

  Future<bool> saveId(String id) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.setString(Preferences.userId, id);
  }

  Future<String?> getId() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString(Preferences.userId);
  }
  
}
