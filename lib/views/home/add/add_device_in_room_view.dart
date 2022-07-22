import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';

class AddDeviceInRoom extends StatelessWidget {
  const AddDeviceInRoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm thiết bị"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.done))],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              // height: 400,
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text("1"),
                    ),
                    title: Text(
                      "Kết nối với thiết bị",
                      style: AppStyles.textMedium,
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text("2"),
                    ),
                    title: Text(
                      "Kết nối với thiết bị",
                      style: AppStyles.textMedium,
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text("3"),
                    ),
                    title: Text(
                      "Liên kết thiết bị với ứng dụng",
                      style: AppStyles.textMedium,
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text("4"),
                    ),
                    title: Text(
                      "Hoàn thành",
                      style: AppStyles.textMedium,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
