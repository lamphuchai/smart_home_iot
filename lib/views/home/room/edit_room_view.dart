import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:smart_home_iot/widgets/modal/list_tile__modal_delete_bottom.dart';
import 'package:smart_home_iot/widgets/modal/list_tile_modal_text_input.dart';

class EditRoomView extends StatelessWidget {
  final int indexRoom;
  const EditRoomView({Key? key, required this.indexRoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textRoomController = TextEditingController();
    ListRoomProvider listRoomProvider = Provider.of<ListRoomProvider>(context);
    if (indexRoom < listRoomProvider.listRoom.length) {
      Room room = listRoomProvider.getRoomIndex(index: indexRoom);
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("edit_room")),
        ),
        body: Column(
          children: [
            ListTileModalTextInput(
                subtitle: Text(AppText.checkNameRoom(room.nameRoom, context)),
                title: AppLocalizations.of(context).translate("name_room"),
                onSubmit: () {
                  listRoomProvider.upRoomIndex(
                      index: indexRoom,
                      room: room.copyWith(nameRoom: _textRoomController.text));
                  Navigator.pop(context);
                },
                textEditingController: _textRoomController),
            const Divider(
              height: 1,
            ),
            _buildTmp(context, listRoomProvider, room.id!)
          ],
        ),
      );
    } else {
      return Scaffold();
    }
  }

  _buildTmp(BuildContext context, ListRoomProvider tmp, String id) {
    if (indexRoom == 0) {
      return Container();
    } else {
      return listTitleModelDelete(
          context: context,
          label: AppLocalizations.of(context).translate("delete_room"),
          buttonDelete: () async {
            tmp.deleteRoomById(id);
            Navigator.pushReplacementNamed(context, RouteName.home);
          });
    }
  }
}
