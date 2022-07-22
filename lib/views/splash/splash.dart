import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_iot/data/sharedpref/shared_preference_helper.dart';
import 'package:smart_home_iot/models/events/event_model.dart';
import 'package:smart_home_iot/provider/auth_provider.dart';
import 'package:smart_home_iot/provider/events_provider.dart';
import 'package:smart_home_iot/provider/list_room_provider.dart';
import 'package:smart_home_iot/provider/user_provider.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/services/apis/user.dart';

class SplashPageScreen extends StatefulWidget {
  const SplashPageScreen({Key? key}) : super(key: key);

  @override
  State<SplashPageScreen> createState() => _SplashPageScreen();
}

class _SplashPageScreen extends State<SplashPageScreen> {
  late ListRoomProvider _listRoomProvider;
  late AuthProvider _authProvider;
  late UserProvider _userProvider;
  late EventsProvider _eventsProvider;
  @override
  void initState() {
    _listRoomProvider = Provider.of<ListRoomProvider>(context, listen: false);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _userProvider = Provider.of<UserProvider>(context, listen: false);
    _eventsProvider = Provider.of<EventsProvider>(context, listen: false);

    _authProvider.initAuthProvider();
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Icon(Icons.headphones),
      ),
    );
  }

  startTimer() {
    var _duration = const Duration(milliseconds: 1000);
    return Timer(_duration, navigate);
  }

  void navigate() async {
    bool tmp = await SharedPreferenceHelper().isLogin;
    if (tmp) {
      await _listRoomProvider.initMqtt(_listRoomProvider);
      final dataUser = await UserApi.getDataUser();
      if (dataUser != null) {
        _listRoomProvider.setListRoom(dataUser["rooms"]);
        _listRoomProvider.setListOtherDevice(dataUser["otherDevices"]);
        _eventsProvider.setEvents(dataUser["events"]);
        _userProvider.initUser(
            userName: dataUser["userName"],
            email: dataUser["email"],
            image: dataUser["image"]);
        Navigator.of(context).pushReplacementNamed(RouteName.home);
      }
    } else {
      Navigator.of(context).pushReplacementNamed(RouteName.login);
    }
  }
}
