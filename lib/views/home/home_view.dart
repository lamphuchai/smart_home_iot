import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home_iot/constants/app_text.dart';
import 'package:smart_home_iot/models/room/room.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:smart_home_iot/views/home/page/room_page.dart';

class Homeview extends StatefulWidget {
  final int? indexRoom;
  const Homeview({Key? key, this.indexRoom}) : super(key: key);

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> with TickerProviderStateMixin {
  late int _lenth;
  late TabController _tabController;
  List<String> tabText = [];
  @override
  void initState() {
    super.initState();

    _lenth =
        Provider.of<ListRoomProvider>(context, listen: false).listRoom.length;
    _tabController = TabController(
        length: _lenth, vsync: this, initialIndex: widget.indexRoom ?? 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Room> listRoom = context.watch<ListRoomProvider>().listRoom;
    Size size = MediaQuery.of(context).size;
    if (_lenth == listRoom.length) {
      return _buildAppBar(listRoom, size);
    } else {
      setState(() {
        _lenth = listRoom.length;
      });
      _tabController.dispose();
      _tabController = TabController(
        length: listRoom.length,
        vsync: this,
      );
      return _buildAppBar(listRoom, size);
    }
  }

  DefaultTabController _buildAppBar(List<Room> listRoom, Size size) {
    return DefaultTabController(
      length: listRoom.length,
      child: NestedScrollView(
          floatHeaderSlivers: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  forceElevated: boxIsScrolled,
                  title: const Text("nha cua ban"),
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                  ),
                  actions: [
                    Theme(
                      data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent),
                      child: PopupMenuButton(
                        onSelected: (int value) {
                          value == 0
                              ? Navigator.pushNamed(
                                  context, RouteName.searchDevice)
                              : Navigator.pushNamed(context, RouteName.addRoom);
                        },
                        icon: Icon(Icons.add,
                            color: Theme.of(context).primaryIconTheme.color),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            child: Text(AppLocalizations.of(context)
                                .translate("add_new_device")),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Text(AppLocalizations.of(context)
                                .translate("add_new_room")),
                          )
                        ],
                      ),
                    )
                  ],
                  titleTextStyle: Theme.of(context).textTheme.headline6,
                  floating: true,
                  pinned: true,
                  snap: false,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(40.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(splashColor: Colors.transparent),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size.width - 50,
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TabBar(
                                    controller: _tabController,
                                    indicatorColor:
                                        Theme.of(context).bottomAppBarColor,
                                    isScrollable: true,
                                    automaticIndicatorColorAdjustment: false,
                                    tabs: listRoom.map((room) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 2,
                                          vertical: 4,
                                        ),
                                        child: Text(AppText.checkNameRoom(
                                            room.nameRoom, context)),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Theme.of(context).bottomAppBarColor,
                              height: 40,
                              width: 50,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent),
                                child: PopupMenuButton(
                                    onSelected: (value) {
                                      Navigator.pushNamed(
                                          context, RouteName.roomManager);
                                    },
                                    padding: const EdgeInsets.all(0),
                                    icon: Icon(Icons.menu,
                                        color: Theme.of(context)
                                            .primaryIconTheme
                                            .color),
                                    itemBuilder: (context) {
                                      return _buildPopupMenu(listRoom);
                                    }),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: TabBarView(
              controller: _tabController,
              children: listRoom.map((room) {
                return RoomPage(
                  key: ValueKey(room),
                  indexRoom: listRoom.indexOf(room),
                  onTap: () {},
                );
              }).toList(),
            ),
          )),
    );
  }

  _buildPopupMenu(List<Room> listRoom) {
    PopupMenuItem manageRoom = PopupMenuItem(
      value: "addRoom",
      textStyle: Theme.of(context).textTheme.subtitle2,
      child: ListTile(
        trailing: const Icon(Icons.settings),
        title: Text(AppLocalizations.of(context).translate("room_manager")),
      ),
    );
    return [
      listRoom
          .map((room) => PopupMenuItem(
                child: ListTile(
                  title: Text(AppText.checkNameRoom(room.nameRoom, context)),
                  trailing: Container(
                    alignment: Alignment.center,
                    width: 25,
                    child: Text(
                      room.devices.length.toString(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
                onTap: () {
                  _tabController.animateTo(listRoom.indexOf(room));
                },
              ))
          .toList(),
      [manageRoom]
    ].expand((e) => e).toList();
  }
}
