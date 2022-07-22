import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';

class OtherDeviceView extends StatelessWidget {
  const OtherDeviceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildCardOtherDevice(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text("Thiet bi moi truong"),
    );
  }

  Card _buildCardOtherDevice(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        splashColor: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.pushNamed(context, RouteName.otherDevice,
              arguments: {"indexDevice": 0});
        },
        child: Container(
          color: AppColors.buttonColor,
          height: 180,
          width: 200,
        ),
      ),
    );
  }
}
