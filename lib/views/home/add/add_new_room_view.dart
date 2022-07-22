import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/widgets/text_field_widgets.dart';

class AddNewRoomView extends StatefulWidget {
  const AddNewRoomView({Key? key}) : super(key: key);

  @override
  State<AddNewRoomView> createState() => _AddNewRoomViewState();
}

class _AddNewRoomViewState extends State<AddNewRoomView> {
  late TextEditingController _textRoomController;
  late ListRoomProvider _listRoomProvider;
  @override
  void initState() {
    _textRoomController = TextEditingController();
    _listRoomProvider = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Thêm phòng"),
        actions: [
          IconButton(
              onPressed: () async {
                await _listRoomProvider.addRoom(
                    nameRoom: _textRoomController.text);
                Navigator.pushReplacementNamed(context, RouteName.home);
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFieldWidgets(
              textController: _textRoomController,
              hintText: "Nhập tên phòng",
              autofocus: false,
              textCapitalization: TextCapitalization.sentences,
            )
          ],
        ),
      ),
    );
  }
}
