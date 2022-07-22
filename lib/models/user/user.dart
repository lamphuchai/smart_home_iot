import 'package:get/get_connect/http/src/request/request.dart';

class User {
  final String userName;
  final String email;
  final String image;
  User({required this.userName, required this.email, required this.image});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userName: json["userName"], email: json["email"], image: json["image"]);
  }
  User copyWith({String? userName, String? email, String? image}) {
    return User(
        userName: userName ?? this.userName,
        email: email ?? this.email,
        image: image ?? this.image);
  }
}
