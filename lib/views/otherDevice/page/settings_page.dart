import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/widgets/modal/list_tile__modal_delete_bottom.dart';
import 'package:smart_home_iot/widgets/modal/list_tile_modal_text_input.dart';

class SettingsPage extends StatefulWidget {
  final int indexOtherDevice;
  final ListRoomProvider listRoomProvider;
  const SettingsPage(
      {Key? key,
      required this.indexOtherDevice,
      required this.listRoomProvider})
      : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 110),
      shrinkWrap: false,
      children: ListTile.divideTiles(context: context, tiles: [
        ListTileModalTextInput(
            title: "Thay đổi tên thiết bị",
            onSubmit: () {},
            textEditingController: _textEditingController),
        listTitleModelDelete(
            label: "xoa",
            context: context,
            buttonDelete: () {
              Navigator.pop(context);
              widget.listRoomProvider
                  .deleteOtherDevice(index: widget.indexOtherDevice);
              Navigator.pushReplacementNamed(context, RouteName.home);
            }),
      ]).toList(),
    );
  }
}
