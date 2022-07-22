import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_assets.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/provider/auth_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/stores/form_value.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button_long.dart';
import 'package:smart_home_iot/widgets/text_field_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _emailController;
  late TextEditingController _passowordController;
  late TextEditingController _nameController;
  late FormValue _formValue;
  bool showPassoword = false;
  late AuthProvider _authProvider;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passowordController = TextEditingController();
    _nameController = TextEditingController();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _formValue = FormValue();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passowordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: size.height * 0.8 / 3,
                child: Image.asset(
                  AppAssets.house,
                  width: 100,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Đăng ký tài khoản ",
                  textAlign: TextAlign.center,
                  style: AppStyles.h3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: TextFieldWidget(
                  keyboardType: TextInputType.emailAddress,
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  hintText: "Tên tài khoản",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 9),
                    child: Icon(
                      Icons.person,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  errorText: _formValue.errUserName!.isEmpty
                      ? null
                      : _formValue.errUserName,
                  onChanged: (value) {
                    if (!_formValue.validateUserName(value)) {
                      setState(() {});
                    } else {
                      _formValue.setErrUserName();
                      setState(() {});
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: TextFieldWidget(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  hintText: "Email",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 9),
                    child: Icon(
                      Icons.mail,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  errorText:
                      _formValue.errEmail!.isEmpty ? null : _formValue.errEmail,
                  onChanged: (value) {
                    if (!_formValue.validateEmail(value)) {
                      setState(() {});
                    } else {
                      _formValue.setErrEmail("");
                      setState(() {});
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: TextFieldWidget(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !showPassoword,
                  controller: _passowordController,
                  hintText: "Mật khẩu",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 9),
                    child: Icon(
                      Icons.lock,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 9),
                    child: IconButton(
                      splashRadius: 30,
                      icon: showPassoword
                          ? const Icon(Icons.visibility_off,
                              color: AppColors.buttonColor)
                          : const Icon(Icons.visibility,
                              color: AppColors.buttonColor),
                      onPressed: () {
                        setState(() {
                          showPassoword = !showPassoword;
                        });
                      },
                    ),
                  ),
                  errorText: _formValue.errPassword!.isEmpty
                      ? null
                      : _formValue.errPassword,
                  onChanged: (value) {
                    if (!_formValue.validatePassword(value)) {
                      setState(() {});
                    } else {
                      _formValue.setErrPassword("");
                      setState(() {});
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: AppButtonLong(
                    label: "Đăng ký",
                    onPressed: () async {
                      if (_formValue.validateUserName(_nameController.text) &&
                          _formValue.validateEmail(_emailController.text) &&
                          _formValue
                              .validatePassword(_passowordController.text)) {
                        final register = await _authProvider.register(
                            userName: _nameController.text,
                            email: _emailController.text,
                            password: _passowordController.text);
                        if (register == null) {
                          _emailController.text = "";
                          _passowordController.text = "";
                          _nameController.text = "";
                          _showMyDialog();
                        } else {
                          if (register["email"] != null) {
                            _formValue.setErrEmail(register["email"]);
                          }
                          setState(() {});
                        }
                      }
                    },
                    colorText: AppColors.white,
                    color: AppColors.buttonColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Bạn đã có tài khoản?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            primary: AppColors.buttonColor),
                        child: const Text("Đăng nhập"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 25),
          content: Text(
            "Đăng ký tài khoản thành công",
            style: AppStyles.textLarge,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  onSubmit() {}
}
