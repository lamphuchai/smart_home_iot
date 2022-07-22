import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/models/room/device.dart';
import 'package:smart_home_iot/models/room/favorites.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:smart_home_iot/widgets/app_cards/app_card_device.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListRoomProvider listRoomProvider = Provider.of<ListRoomProvider>(context);
    List<Favorites> favorites = listRoomProvider.getFavorites();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("favorites")),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: favorites.isEmpty
            ? _buildCardEmpty(context)
            : _buildGrildWiewDevice(context, favorites),
      ),
    );
  }

  Widget _buildCardEmpty(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: double.infinity,
          height: 120,
          child: Center(
            child: Text(
              "Khong co thiet bi",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrildWiewDevice(
      BuildContext context, List<Favorites> favorites) {
    Size size = MediaQuery.of(context).size;
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: ((size.width * 1 / 2 - 24) / 180),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: favorites.map((favorites) {
        Device device = favorites.device;
        if (favorites.device.typeDevice == "switch") {
          return Padding(
              padding: const EdgeInsets.all(3.0),
              child: appCardDeviceSwitch(
                  context: context,
                  title: device.name,
                  value: device.status,
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.swicthDevice,
                        arguments: {
                          "indexDevice": favorites.indexDevice,
                          "indexRoom": favorites.indexRoom
                        });
                  },
                  onChanged: (value) {}));
        } else if (device.typeDevice == "sensor") {
          return Padding(
              padding: const EdgeInsets.all(3.0),
              child: appCardDeviceSensor(
                  context: context,
                  name: device.name,
                  value: device.status,
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.sensorDevice,
                        arguments: {
                          "indexDevice": favorites.indexDevice,
                          "indexRoom": favorites.indexRoom
                        });
                  },
                  data: device.data.dataNow!,
                  onChanged: (value) {}));
        }
        return Container();
      }).toList(),
    );
  }
}
