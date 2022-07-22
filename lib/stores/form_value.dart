import 'package:email_validator/email_validator.dart';

class FormValue {
  String? errUserName = "";
  String? errEmail = "";
  String? errPassword = "";

  bool validateUserName(String userName) {
    if (userName.isEmpty) {
      errUserName = "Tên tài khoản không thế trống";
      return false;
    } else if (userName.length < 4) {
      errUserName = "Tên tài khoản ít nhất 4 ký tự";
      return false;
    }
    return true;
  }

  setErrUserName() => errUserName = "";
  setErrEmail(String? value) => errEmail = value;
  setErrPassword(String? value) => errPassword = value;

  bool validateEmail(String email) {
    if (email.isEmpty) {
      errEmail = "Email không thế trống";
      return false;
    } else if (!EmailValidator.validate(email)) {
      errEmail = "Định dạng email không hợp lệ";
      return false;
    }
    return true;
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      errPassword = "Mật khẩu không thế trống";
      return false;
    } else if (password.length < 6) {
      errPassword = "Mật khẩu ít nhất có 6 ký tự";
      return false;
    }
    return true;
  }
}
