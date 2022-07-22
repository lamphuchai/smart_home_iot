import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button.dart';

class SearchDevice extends StatefulWidget {
  const SearchDevice({Key? key}) : super(key: key);

  @override
  State<SearchDevice> createState() => _SearchDeviceState();
}

class _SearchDeviceState extends State<SearchDevice> {
  late bool locationPermissions;
  late bool blutetoothPermissions = false;
  @override
  void initState() {
    super.initState();
    locationPermissions = false;
    blutetoothPermissions = true;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      if (!locationPermissions) {
        await _showModalLocationPermissions(context);
      }
      if (!blutetoothPermissions) {
        await _showModalBluetooth(context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tìm kiếm thiết bị"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.info))],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.configWifi);
              },
              child: const Text("next")),
        ),
      ),
    );
  }

  _showModalLocationPermissions(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(
                      "Cần có quyền vị trí để quét thiết bị xung quanh và kết nối với wifi",
                      textAlign: TextAlign.center,
                      style: AppStyles.textLarge,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(
                          lable: "Hủy",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Color(0xffc1d5e0)),
                      AppButton(
                          lable: "Đi tới cài đặt",
                          onPressed: () {
                            AppSettings.openLocationSettings();
                            Navigator.pop(context);
                          },
                          color: AppColors.buttonColor),
                    ],
                  ),
                ],
              ),
            ));
  }

  _showModalBluetooth(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(
                      "Cần có quyền bluetooth để quét thiết bị xung quanh",
                      textAlign: TextAlign.center,
                      style: AppStyles.textLarge,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(
                          lable: "Hủy",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Color(0xffc1d5e0)),
                      AppButton(
                          lable: "Đi tới cài đặt",
                          onPressed: () {
                            AppSettings.openBluetoothSettings();
                            Navigator.pop(context);
                          },
                          color: AppColors.buttonColor),
                    ],
                  ),
                ],
              ),
            ));
  }
}
