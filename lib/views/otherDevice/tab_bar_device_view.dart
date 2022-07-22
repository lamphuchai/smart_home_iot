import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/constants/app_styles.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/views/otherDevice/page/chart_page.dart';
import 'package:smart_home_iot/views/otherDevice/page/list_devices_page.dart';
import 'package:smart_home_iot/views/otherDevice/page/settings_page.dart';

class TabBarDeviceView extends StatefulWidget {
  final int indexOtherDevice;
  const TabBarDeviceView({Key? key, required this.indexOtherDevice})
      : super(key: key);

  @override
  State<TabBarDeviceView> createState() => _TabBarDeviceViewState();
}

class _TabBarDeviceViewState extends State<TabBarDeviceView> {
  late ListRoomProvider _listRoomProvider;
  String otherDevice = "";
  @override
  void initState() {
    super.initState();
    _listRoomProvider = Provider.of<ListRoomProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final List<IconData> _tabs = <IconData>[
      Icons.list,
      Icons.trending_up,
      Icons.settings
    ];
    if (widget.indexOtherDevice < _listRoomProvider.listOtherDevice.length) {
      otherDevice =
          _listRoomProvider.getOtherDevice(index: widget.indexOtherDevice);
      return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    // backgroundColor: AppColors.white,
                    leading: IconButton(
                        focusColor: AppColors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          color: Theme.of(context).iconTheme.color,
                        )),
                    // backgroundColor: AppColors.white,
                    title: Text(otherDevice),
                    titleTextStyle: Theme.of(context).textTheme.headline6,
                    floating: true,
                    pinned: true,
                    snap: false,
                    forceElevated: innerBoxIsScrolled,

                    bottom: TabBar(
                      // indicatorColor: AppColors.buttonColor,
                      // unselectedLabelColor: AppColors.buttonColor,
                      tabs: _tabs
                          .map((IconData ions) => SizedBox(
                                height: 40,
                                child: Icon(
                                  ions,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(children: [
              const ListDevicesPage(),
              const ChartPage(),
              SettingsPage(
                listRoomProvider: _listRoomProvider,
                indexOtherDevice: widget.indexOtherDevice,
              )
            ]),
          ),
        ),
      );
    }
    return Container();
  }
}
