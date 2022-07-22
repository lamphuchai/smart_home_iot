import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_home_iot/data/sharedpref/shared_preference_helper.dart';
import 'package:smart_home_iot/services/constants/url_api.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  String? token;
  bool? isLogin;
  bool isLoading = false;
  String typeLogin = "";
  late FirebaseAuth _auth;
  initAuthProvider() async {
    token = await SharedPreferenceHelper().authToken;
    isLogin = await SharedPreferenceHelper().isLogin;
    _auth = FirebaseAuth.instance;
    notifyListeners();
  }

  Future login({required String email, required String password}) async {
    setIsloading(true);
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {"email": email.toLowerCase(), "password": password};
      final response = await http.post(Uri.parse(Url.login),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        await SharedPreferenceHelper().saveIsLogin(true);
        await SharedPreferenceHelper().saveId(res["id"]);
        setIsloading(false);
        setTypeLogin("acc");
        return null;
      } else if (response.statusCode == 400) {
        Map<String, dynamic> res = json.decode(response.body);
        setIsloading(false);
        return res;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future register(
      {required String userName,
      required String email,
      required String password}) async {
    setIsloading(true);
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {"email": email, "password": password, "userName": userName};

      final response = await http.post(Uri.parse(Url.register),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        await SharedPreferenceHelper().saveIsLogin(true);
        return null;
      } else if (response.statusCode == 400) {
        Map<String, dynamic> res = json.decode(response.body);
        // setIsloading(false);
        return res;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future loginGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn().catchError((onError) => print(onError));
    if (googleSignInAccount == null) return null;
    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final data = {
      "userName": userCredential.user!.displayName,
      "email": userCredential.user!.email,
      "image": userCredential.user!.photoURL
    };
    final google = await loginOther(
        userName: userCredential.user!.displayName ?? "",
        email: userCredential.user!.email ?? "",
        image: userCredential.user!.photoURL);
    setTypeLogin("google");
    return google;
  }

  Future logOutGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    logOutAcc();
  }

  Future logInFacebook() async {
    FacebookAuth _facebookAuth = FacebookAuth.instance;
    final LoginResult result =
        await _facebookAuth.login(permissions: ["public_profile", "email"]);
    bool _isLogged = result.status == LoginStatus.success;
    if (_isLogged) {
      final userData = await _facebookAuth.getUserData(
        fields: "name,email,picture.width(200)",
      );
      return await loginOther(
          userName: userData["name"],
          email: userData["email"],
          image: userData["picture"]["data"]["url"]);
    }
  }

  Future logOutFacebook() async {
    FacebookAuth _facebookAuth = FacebookAuth.instance;
    _facebookAuth.logOut();
    logOutAcc();
  }

  Future<bool> loginOther(
      {required String email, required String userName, String? image}) async {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      Map body = {
        "email": email.toLowerCase(),
        "userName": userName,
        "image": image ?? ""
      };
      final response = await http.post(Uri.parse(Url.loginOther),
          headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);
        await SharedPreferenceHelper().saveIsLogin(true);
        await SharedPreferenceHelper().saveId(res["id"]);
        return true;
      } else if (response.statusCode == 400) {
        Map<String, dynamic> res = json.decode(response.body);
        return false;
      }
      return false;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  logOut() {
    switch (typeLogin) {
      case "facebook":
        return logOutFacebook();
      case "google":
        return logOutGoogle();
      default:
        return logOutAcc();
    }
  }

  logOutAcc() async {
    try {
      SharedPreferenceHelper().saveIsLogin(false);
      SharedPreferenceHelper().removeAuthToken();
      token = null;
      isLogin = false;
      notifyListeners();
      return true;
    } catch (e) {
      throw e;
    }
  }

  setIsloading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  setTypeLogin(String value) {
    typeLogin = value;
    notifyListeners();
  }
}
