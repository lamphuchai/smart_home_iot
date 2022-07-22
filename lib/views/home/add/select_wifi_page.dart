import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button.dart';
import 'package:smart_home_iot/widgets/app_buttons/app_button_long.dart';
import 'package:smart_home_iot/widgets/text_field_widgets.dart';

class SelectWifiPage extends StatefulWidget {
  const SelectWifiPage({Key? key}) : super(key: key);
  @override
  State<SelectWifiPage> createState() => _SelectWifiPageState();
}

class _SelectWifiPageState extends State<SelectWifiPage> {
  late TextEditingController _textPassawordController;
  @override
  void initState() {
    _textPassawordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cấu hình wifi"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.autorenew))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: 2,
                    itemBuilder: (context, index) => _buildWifi(context))),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      minimumSize: const Size(120, 40)),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.addDeviceRoom);
                  },
                  child: const Text("Tiếp theo"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildWifi(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.wifi),
      title: Text("Viettel"),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_right),
        onPressed: () {
          _showModalBluetooth(context);
        },
      ),
    );
  }

  _showModalBluetooth(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Viettel",
                      textAlign: TextAlign.center,
                      style: AppStyles.h4,
                    ),
                    TextFieldWidgets(
                      textController: _textPassawordController,
                      label: "Nhập mật khẩu",
                    ),
                    AppButtonLong(
                        label: "Kết nối",
                        onPressed: () {},
                        color: AppColors.buttonColor),
                  ],
                ),
              ),
            ));
  }
}
