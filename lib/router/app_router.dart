import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smart_home_iot/router/constants/router_name.dart';
import 'package:smart_home_iot/views/bottom_tabs.dart';
import 'package:smart_home_iot/views/events/add_new_events_view.dart';
import 'package:smart_home_iot/views/events/if_add_event.dart';
import 'package:smart_home_iot/views/events/info_event.dart';
import 'package:smart_home_iot/views/events/options/event_options_view.dart';
import 'package:smart_home_iot/views/events/options/sensor_device_event.dart';
import 'package:smart_home_iot/views/events/options/switch_device_event.dart';
import 'package:smart_home_iot/views/events/options/timer_event.dart';
import 'package:smart_home_iot/views/events/then_add_event.dart';
import 'package:smart_home_iot/views/home/add/add_device_in_room_view.dart';
import 'package:smart_home_iot/views/home/add/add_new_room_view.dart';
import 'package:smart_home_iot/views/home/add/search_device.dart';
import 'package:smart_home_iot/views/home/add/select_wifi_page.dart';
import 'package:smart_home_iot/views/home/device/sensor.dart';
import 'package:smart_home_iot/views/home/device/switch_device.dart';
import 'package:smart_home_iot/views/otherDevice/tab_bar_device_view.dart';
import 'package:smart_home_iot/views/home/notification/notification_view.dart';
import 'package:smart_home_iot/views/home/page/device_options_view.dart';
import 'package:smart_home_iot/views/home/room/edit_room_view.dart';
import 'package:smart_home_iot/views/home/room/room_manager_view.dart';
import 'package:smart_home_iot/views/login/login_view.dart';
import 'package:smart_home_iot/views/login/register_view.dart';
import 'package:smart_home_iot/views/splash/splash.dart';

class RouterRoot {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => const SplashPageScreen());
      // -------------------------------------------------------

      case RouteName.login:
        return PageTransition(
            child: const LoginView(),
            type: PageTransitionType.rightToLeftWithFade);
      case RouteName.register:
        return PageTransition(
            child: const RegisterView(),
            type: PageTransitionType.rightToLeftWithFade);

      // -------------------------------------------------------

      case RouteName.home:
        if (args != null && args is Map<String, dynamic>) {
          return PageTransition(
              child: BottomTabs(
                indexRoom: args["indexRoom"],
                indexPageBottom: args["index"],
              ),
              type: PageTransitionType.fade);
        } else {
          return PageTransition(
              child: const BottomTabs(), type: PageTransitionType.fade);
        }
      case RouteName.otherDevice:
        if (args != null && args is Map<String, dynamic>) {
          return PageTransition(
              child: TabBarDeviceView(
                indexOtherDevice: args["indexDevice"],
              ),
              type: PageTransitionType.rightToLeftWithFade);
        }
        return _errRoute();
      // -------------------------------------------------------

      case RouteName.searchDevice:
        return PageTransition(
            child: const SearchDevice(),
            type: PageTransitionType.rightToLeftWithFade);
      case RouteName.configWifi:
        return PageTransition(
            child: const SelectWifiPage(),
            type: PageTransitionType.rightToLeftWithFade);
      case RouteName.addDeviceRoom:
        return PageTransition(
            child: const AddDeviceInRoom(),
            type: PageTransitionType.rightToLeftWithFade);
      case RouteName.addRoom:
        return PageTransition(
            child: const AddNewRoomView(),
            type: PageTransitionType.rightToLeftWithFade);
      case RouteName.notification:
        return PageTransition(
            child: const NotificationView(),
            type: PageTransitionType.rightToLeftWithFade);
      // -------------------------------------------------------
      case RouteName.infoEvent:
        return PageTransition(
            child: InfoEvent(
              id: args.toString(),
            ),
            type: PageTransitionType.rightToLeftWithFade);
      case RouteName.eventOptinons:
        return PageTransition(
            child: EventOptionsView(
              id: args.toString(),
            ),
            type: PageTransitionType.rightToLeftWithFade);

      case RouteName.ifDddEvent:
        return PageTransition(
            child: const IfAddEvent(),
            type: PageTransitionType.rightToLeftWithFade);
      case RouteName.timerEvent:
        return PageTransition(
            child: const TimerEvent(),
            type: PageTransitionType.rightToLeftWithFade);
      case RouteName.thenAddVent:
        if (args != null && args is Map<String, dynamic>) {
          return PageTransition(
              child: ThenAddEvent(
                event: args["event"],
              ),
              type: PageTransitionType.rightToLeftWithFade);
        }
        return _errRoute();
      case RouteName.switchEvent:
        if (args != null && args is Map<String, dynamic>) {
          return PageTransition(
              child: SwitchDeviceEvent(
                event: args["event"],
                device: args["device"],
              ),
              type: PageTransitionType.rightToLeftWithFade);
        }
        return _errRoute();
      case RouteName.sensorEvent:
        return PageTransition(
            child: const SensorDeviceEvent(),
            type: PageTransitionType.rightToLeftWithFade);

      case RouteName.completeEvent:
        if (args != null && args is Map<String, dynamic>) {
          return PageTransition(
              child: AddNewEvents(
                eventModel: args["eventModel"],
              ),
              type: PageTransitionType.rightToLeftWithFade);
        }
        return _errRoute();

      case RouteName.roomManager:
        return PageTransition(
            child: const RoomManagerView(),
            type: PageTransitionType.rightToLeftWithFade);

      case RouteName.editRoom:
        if (args != null && args is int) {
          return PageTransition(
              child: EditRoomView(
                indexRoom: args,
              ),
              type: PageTransitionType.rightToLeftWithFade);
        }
        return _errRoute();

      case RouteName.sensorDevice:
        if (args != null && args is Map<String, dynamic>) {
          return PageTransition(
              child: Sensor(
                indexRoom: args["indexRoom"],
                indexDevice: args["indexDevice"],
              ),
              type: PageTransitionType.rightToLeftWithFade);
        }
        return _errRoute();
      case RouteName.deviceOptions:
        if (args != null && args is Map<String, dynamic>) {
          return PageTransition(
              child: DeviceOptionsView(
                indexRoom: args["indexRoom"],
                indexDevice: args["indexDevice"],
              ),
              type: PageTransitionType.rightToLeftWithFade);
        }
        return _errRoute();
      case RouteName.swicthDevice:
        if (args != null && args is Map<String, dynamic>) {
          return PageTransition(
              child: SwitchDevice(
                indexRoom: args["indexRoom"],
                indexDevice: args["indexDevice"],
              ),
              type: PageTransitionType.rightToLeftWithFade);
        }
        return _errRoute();

      default:
        return _errRoute();
    }
  }

  static Route<dynamic> _errRoute() {
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(
                child: Text("no route"),
              ),
            ));
  }
}
