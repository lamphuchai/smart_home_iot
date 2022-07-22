import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/provider/auth_provider.dart';
import 'package:smart_home_iot/provider/theme_provider.dart';
import 'package:smart_home_iot/provider/user_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';

class PersonView extends StatelessWidget {
  const PersonView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    final themeProvide = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeProvide.isDarkMode
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).scaffoldBackgroundColor,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(children: [
          _buildContainerUser(size.height * 1 / 3, context),
          listTileWidget(context,
              title: "accInfo",
              leading: Icon(Icons.account_circle,
                  color: Theme.of(context).primaryIconTheme.color),
              trailing: Icon(Icons.chevron_right,
                  color: Theme.of(context).primaryIconTheme.color),
              onTap: () {}),
          _buildChangeLanguage(context, "language"),
          listTileWidget(
            context,
            title: "themeMode",
            leading: Icon(Icons.dark_mode,
                color: Theme.of(context).primaryIconTheme.color),
            trailing: Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                value: themeProvide.isDarkMode,
                activeColor:
                    themeProvide.isDarkMode ? AppColors.black : AppColors.white,
                onChanged: (value) {
                  themeProvide.toggleTheme(value);
                },
              ),
            ),
          ),
          listTileWidget(context,
              title: "setting",
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              trailing: Icon(Icons.chevron_right,
                  color: Theme.of(context).primaryIconTheme.color),
              onTap: () {}),
          listTileWidget(context,
              title: "appInfo",
              leading: Icon(Icons.info,
                  color: Theme.of(context).primaryIconTheme.color),
              trailing: Icon(Icons.chevron_right,
                  color: Theme.of(context).primaryIconTheme.color),
              onTap: () {}),
          listTileWidget(
            context,
            onTap: () async {
              await _authProvider.logOut();
              Navigator.pushReplacementNamed(context, RouteName.splash);
            },
            title: "logOut",
            leading: Icon(Icons.logout,
                color: Theme.of(context).primaryIconTheme.color),
          ),
          ElevatedButton(
              onPressed: check() ? () => show(context) : null,
              child: const Text("test"))
        ]),
      ),
    );
  }

  check() {
    if (1 == 1) {
      return true;
    }
    return false;
  }

  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text("Test"),
            ));
  }

  Widget listTileWidget(BuildContext context,
      {Icon? leading, Widget? trailing, String? title, VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      trailing: trailing,
      title: Text(
        AppLocalizations.of(context).translate(title!),
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  _buildChangeLanguage(BuildContext context, String title) {
    final themeProvide = Provider.of<ThemeProvider>(context);

    return ListTile(
        onTap: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              context: context,
              builder: (_) => Container(
                    height: 200,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () async {
                            themeProvide.changeLocale("system");
                            Navigator.pop(context);
                          },
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 5, bottom: 5),
                          leading: themeProvide.getIsLocale("system")
                              ? const Icon(
                                  Icons.done,
                                  color: AppColors.buttonColor,
                                )
                              : const SizedBox(
                                  height: 2,
                                  width: 9,
                                ),
                          title: Text(
                              AppLocalizations.of(context).translate('system')),
                        ),
                        ListTile(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15))),
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 5, bottom: 5),
                          onTap: () async {
                            themeProvide.changeLocale("vi");
                            Navigator.pop(context);
                          },
                          leading: themeProvide.getIsLocale("vi")
                              ? const Icon(
                                  Icons.done,
                                  color: AppColors.buttonColor,
                                )
                              : const SizedBox(
                                  height: 2,
                                  width: 9,
                                ),
                          title: Text(
                              AppLocalizations.of(context).translate('vi')),
                        ),
                        ListTile(
                          onTap: () async {
                            themeProvide.changeLocale("en");
                            Navigator.pop(context);
                          },
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 5, bottom: 5),
                          leading: themeProvide.getIsLocale("en")
                              ? const Icon(
                                  Icons.done,
                                  color: AppColors.buttonColor,
                                )
                              : const SizedBox(
                                  height: 2,
                                  width: 9,
                                ),
                          title: Text(
                              AppLocalizations.of(context).translate('en')),
                        )
                      ],
                    ),
                  ));
        },
        leading: Icon(Icons.language,
            color: Theme.of(context).primaryIconTheme.color),
        trailing: Icon(Icons.chevron_right,
            color: Theme.of(context).primaryIconTheme.color),
        title: Text(
          AppLocalizations.of(context).translate(title),
          style: Theme.of(context).textTheme.subtitle1,
        ));
  }

  _buildContainerUser(double height, BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(context);
    return Container(
        padding: const EdgeInsets.only(bottom: 40, left: 15),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.buttonColor,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(_userProvider.user.image),
                  ),
                ),
                Positioned(
                    bottom: 2,
                    left: 68,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.redColor,
                      ),
                      height: 25,
                      width: 25,
                      child: InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15))),
                              context: context,
                              builder: (_) => Container(
                                    height: 135,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(15))),
                                          contentPadding: const EdgeInsets.only(
                                              left: 20, top: 5, bottom: 5),
                                          onTap: () async {
                                            await _userProvider.upLoadImage(
                                                type: "camera");
                                            Navigator.pop(context);
                                          },
                                          leading: const Icon(
                                            Icons.camera,
                                            color: AppColors.buttonColor,
                                          ),
                                          title: const Text("Chụp ảnh"),
                                        ),
                                        ListTile(
                                          onTap: () async {
                                            await _userProvider.upLoadImage(
                                                type: "gallery");
                                            Navigator.pop(context);
                                          },
                                          contentPadding: const EdgeInsets.only(
                                              left: 20, top: 5, bottom: 5),
                                          leading: const Icon(
                                            Icons.image,
                                            color: AppColors.buttonColor,
                                          ),
                                          title:
                                              const Text("Tải lên từ thư viện"),
                                        )
                                      ],
                                    ),
                                  ));
                        },
                        child: const Icon(
                          Icons.local_see,
                          color: AppColors.white,
                          size: 15,
                        ),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userProvider.user.userName,
                    style: AppStyles.textSubtitle,
                  ),
                  Text(
                    _userProvider.user.email,
                    style: AppStyles.textCation
                        .copyWith(color: AppColors.iconColor),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
