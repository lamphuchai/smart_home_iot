import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:smart_home_iot/views/events/event_view.dart';
import 'package:smart_home_iot/views/favorite/favorite_view.dart';
import 'package:smart_home_iot/views/home/home_view.dart';
import 'package:smart_home_iot/views/otherDevice/other_device_view.dart';
import 'package:smart_home_iot/views/person/person_view.dart';

class BottomTabs extends StatefulWidget {
  final int? indexRoom;
  final int? indexPageBottom;
  const BottomTabs({Key? key, this.indexRoom, this.indexPageBottom})
      : super(key: key);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedIndex = 0;
  late final List<Widget> _listWidget;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.indexPageBottom ?? 0;
    _listWidget = [
      Homeview(
        indexRoom: widget.indexRoom ?? 0,
      ),
      const FavoriteView(),
      const EvenView(),
      const PersonView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              context: context,
              builder: (context) => Container(
                    height: 120,
                    child: Column(
                      children: [
                        ListTile(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15))),
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.searchDevice);
                          },
                          title: Text(AppLocalizations.of(context)
                              .translate("add_new_device")),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)
                              .translate("add_new_room")),
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.addRoom);
                          },
                        )
                      ],
                    ),
                  ));
        },
        child: Container(
          margin: const EdgeInsets.all(15),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        children: _listWidget,
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButtonBottom(
                  index: 0,
                  icon: _selectedIndex == 0
                      ? const Icon(
                          Icons.home,
                          color: AppColors.buttonColor,
                        )
                      : const Icon(Icons.home_outlined,
                          color: AppColors.iconColor),
                  lable: "Home",
                  width: size.width),
              SizedBox(
                width: size.width * 1.2 / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildButtonBottom(
                        index: 1,
                        icon: _selectedIndex == 1
                            ? const Icon(Icons.favorite,
                                color: AppColors.buttonColor)
                            : const Icon(Icons.favorite_outline,
                                color: AppColors.iconColor),
                        lable: "Home",
                        width: size.width),
                    _buildButtonBottom(
                        index: 2,
                        icon: _selectedIndex == 2
                            ? const Icon(Icons.menu,
                                color: AppColors.buttonColor)
                            : const Icon(Icons.menu_outlined,
                                color: AppColors.iconColor),
                        lable: "Home",
                        width: size.width)
                  ],
                ),
              ),
              _buildButtonBottom(
                  index: 3,
                  icon: _selectedIndex == 3
                      ? const Icon(Icons.person, color: AppColors.buttonColor)
                      : const Icon(Icons.person_outline,
                          color: AppColors.iconColor),
                  lable: "Home",
                  width: size.width)
            ],
          ),
        ),
      ),
    );
  }

  _buildButtonBottom(
      {required int index,
      required Icon icon,
      required String lable,
      required double width}) {
    return MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        minWidth: width * 1 / 5,
        onPressed: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Container(
              margin: const EdgeInsets.only(top: 3),
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: _selectedIndex == index
                    ? AppColors.buttonColor
                    : AppColors.white,
              ),
            )
          ],
        ));
  }
}
