// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_home_iot/constants/app_colors.dart';
// import 'package:smart_home_iot/constants/app_styles.dart';
// import 'package:smart_home_iot/models/room/data.dart';
// import 'package:smart_home_iot/models/room/device.dart';
// import 'package:smart_home_iot/provider/list_room_provider.dart';

// class AppDeviceButton extends StatefulWidget {
//   final ListRoomProvider listRoomProvider;
//   final VoidCallback onPressed;
//   final Device device;
//   const AppDeviceButton(
//       {Key? key,
//       required this.onPressed,
//       required this.device,
//       required this.listRoomProvider})
//       : super(key: key);

//   @override
//   State<AppDeviceButton> createState() => _AppDeviceButtonState();
// }

// class _AppDeviceButtonState extends State<AppDeviceButton> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     Data statusSwitch = widget.device.data;
//     return Card(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//           side: const BorderSide(color: AppColors.inputColor, width: 1)),
//       elevation: 1,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         height: 160,
//         width: double.infinity,
//         child: Column(
//           children: [
//             ListTile(
//               title: Text(
//                 widget.device.name,
//                 style: AppStyles.h4.copyWith(fontWeight: FontWeight.w500),
//               ),
//               trailing: IconButton(
//                 icon: const Icon(Icons.more_vert),
//                 onPressed: widget.onPressed,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   width: width * 1 / 3 - 10,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CupertinoSwitch(
//                           value: false,
//                           onChanged: (bool value) {
//                             // statusSwitch["switch1"] = value;
//                             widget.listRoomProvider.publish(
//                                 topic: widget.device.topic,
//                                 message: jsonEncode(statusSwitch));
//                             setState(() {});
//                           }),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: Text(
//                           widget.device.nameSwitches[0],
//                           style: AppStyles.textMedium,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: width * 1 / 3 - 10,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CupertinoSwitch(
//                           value: statusSwitch["switch2"],
//                           onChanged: (bool value) {
//                             statusSwitch["switch2"] = value;
//                             widget.listRoomProvider.publish(
//                                 topic: widget.device.topic,
//                                 message: jsonEncode(statusSwitch));
//                             setState(() {});
//                             setState(() {});
//                           }),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: Text(
//                           widget.device.nameSwitches[1],
//                           style: AppStyles.textMedium,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: width * 1 / 3 - 10,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CupertinoSwitch(
//                           value: statusSwitch["switch3"],
//                           onChanged: (bool value) {
//                             statusSwitch["switch3"] = value;
//                             widget.listRoomProvider.publish(
//                                 topic: widget.device.topic,
//                                 message: jsonEncode(statusSwitch));
//                             setState(() {});
//                             setState(() {});
//                           }),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: Text(
//                           widget.device.nameSwitches[2],
//                           style: AppStyles.textMedium,
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
