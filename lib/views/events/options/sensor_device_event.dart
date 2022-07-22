import 'package:flutter/material.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';

class SensorDeviceEvent extends StatelessWidget {
  const SensorDeviceEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ten cam bien"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context).translate("temperature")),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {},
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate("humidity")),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
