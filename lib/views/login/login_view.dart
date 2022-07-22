import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_assets.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/provider/auth_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/stores/form_value.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button_long.dart';
import 'package:smart_home_iot/widgets/text_field_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passowordController;
  late FocusNode _buttonNode;
  late AuthProvider _authProvider;
  bool showPassoword = false;
  late FormValue _formValue;
  @override
  void initState() {
    _buttonNode = FocusNode();
    _emailController = TextEditingController();
    _passowordController = TextEditingController();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _formValue = FormValue();
    super.initState();
  }

  @override
  void dispose() {
    _buttonNode.dispose();
    _emailController.dispose();
    _passowordController.dispose();
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
                  "Chào mừng bạn tới\n AppIot",
                  textAlign: TextAlign.center,
                  style: AppStyles.h3,
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
                    if (_formValue.validateEmail(value)) {
                      _formValue.setErrEmail("");
                      setState(() {});
                    } else {
                      setState(() {});
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 9),
                child: TextFieldWidget(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !showPassoword,
                  controller: _passowordController,
                  textInputAction: TextInputAction.done,
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
                          ? const Icon(
                              Icons.visibility_off,
                              color: AppColors.buttonColor,
                            )
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
                    if (_formValue.validatePassword(value)) {
                      _formValue.setErrPassword("");
                      setState(() {});
                    } else {
                      setState(() {});
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(primary: AppColors.buttonColor),
                    child: const Text("Quên mật khẩu ?"),
                    onPressed: () {},
                  ),
                ),
              ),
              AppButtonLong(
                  focusNode: _buttonNode,
                  label: "Đăng nhập",
                  onPressed: () async {
                    if (_formValue.validateEmail(_emailController.text) &&
                        _formValue
                            .validatePassword(_passowordController.text)) {
                      final login = await _authProvider.login(
                          email: _emailController.text,
                          password: _passowordController.text);
                      if (login == null) {
                        Navigator.pushReplacementNamed(
                            context, RouteName.splash);
                      } else {
                        if (login["email"] != null) {
                          _formValue.setErrEmail(login["email"]);
                        } else if (login["password"] != null) {
                          _formValue.setErrPassword(login["password"]);
                        }
                        setState(() {});
                      }
                    }
                  },
                  colorText: AppColors.white,
                  color: AppColors.buttonColor),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Hoặc đăng nhập bằng",
                  style: AppStyles.textSmall,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(50, 50)),
                      child: Image.asset(AppAssets.google),
                      onPressed: () async {
                        final loginGooole = await _authProvider.loginGoogle();
                        print(loginGooole);
                        loginGooole != null && loginGooole
                            ? Navigator.pushReplacementNamed(
                                context, RouteName.splash)
                            : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(50, 50)),
                      child: Image.asset(AppAssets.facebook),
                      onPressed: () async {
                        final facebook = await _authProvider.logInFacebook();
                        facebook != null && facebook
                            ? Navigator.pushReplacementNamed(
                                context, RouteName.splash)
                            : null;
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Bạn chưa có tài khoản?"),
                    TextButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, RouteName.register);
                        },
                        style: TextButton.styleFrom(
                            primary: AppColors.buttonColor),
                        child: const Text("Đăng ký"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onSubmit() {}
}
