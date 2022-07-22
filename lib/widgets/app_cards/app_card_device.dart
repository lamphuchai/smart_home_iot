import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_iot/utils/locale/app_localizations.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget appCardDeviceSensor({
  required BuildContext context,
  required bool value,
  required VoidCallback onTap,
  required String name,
  required Map data,
  Function(bool)? onChanged,
}) {
  Size size = MediaQuery.of(context).size;
  return Card(
    color: Colors.black12,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.transparent,
      child: Container(
        // padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Transform.scale(
                scale: 0.6,
                child: CupertinoSwitch(
                  value: value,
                  onChanged: onChanged,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              // color: AppColors.buttonColor,
              height: 100,
              child: SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                        cornerStyle: CornerStyle.bothCurve,
                        color: Colors.white30,
                        thickness: 8),
                    pointers: const <GaugePointer>[
                      RangePointer(
                          value: 37,
                          cornerStyle: CornerStyle.bothCurve,
                          width: 12,
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                          gradient: SweepGradient(colors: <Color>[
                            Color(0xFFCC2B5E),
                            Color(0xFF753A88)
                          ], stops: <double>[
                            0.25,
                            0.75
                          ])),
                      MarkerPointer(
                          value: 37,
                          enableDragging: true,
                          markerHeight: 16,
                          markerWidth: 16,
                          markerType: MarkerType.circle,
                          color: Color(0xFF753A88),
                          borderWidth: 2,
                          borderColor: Colors.white54)
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          angle: 90,
                          axisValue: 5,
                          positionFactor: 0.2,
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data["temperature"].toString() + "°C",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(data["humidity"].toString() + '%'),
                              const Text("")
                            ],
                          ))
                    ]),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(name),
            )
          ],
        ),
      ),
    ),
  );
}

Widget appCardDeviceSwitch(
    {required BuildContext context,
    required bool value,
    required String title,
    VoidCallback? onTap,
    Function(bool)? onChanged}) {
  return Card(
    color: Colors.black12,
    child: InkWell(
      onTap: value ? onTap : null,
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.transparent,
      child: Container(
        // padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Transform.scale(
                scale: 0.6,
                child: CupertinoSwitch(
                  value: value,
                  onChanged: onChanged,
                ),
              ),
            ),
            Container(
                height: 100,
                width: 150,
                child: const Icon(
                  Icons.touch_app,
                  size: 50,
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(title),
            )
          ],
        ),
      ),
    ),
  );
}

Widget appCardLoraDevice(
    {required BuildContext context,
    required bool value,
    required String title,
    VoidCallback? onTap,
    Function(bool)? onChanged}) {
  return Card(
    color: Colors.black12,
    child: InkWell(
      onTap: value ? onTap : null,
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.transparent,
      child: Container(
        // padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Transform.scale(
                scale: 0.6,
                child: CupertinoSwitch(
                  value: value,
                  onChanged: onChanged,
                ),
              ),
            ),
            Container(
                height: 100,
                width: 150,
                child: const Icon(
                  Icons.touch_app,
                  size: 50,
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(title),
            )
          ],
        ),
      ),
    ),
  );
}
Widget appDeviceSwitch(
    {required BuildContext context,
    required VoidCallback onTap,
    required bool status,
    required String title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Card(
        color: status ? Colors.blue[100] : Theme.of(context).primaryColor,
        child: InkWell(
          splashColor: !status ? Colors.blue[100] : Colors.white,
          highlightColor: !status ? Colors.blue[300] : Colors.white38,
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            width: 90,
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.circle,
                  size: 15,
                  color:
                      status ? Colors.blue : Theme.of(context).iconTheme.color,
                ),
                Text(
                  !status
                      ? AppLocalizations.of(context).translate("on")
                      : AppLocalizations.of(context).translate("off"),
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
      Text(title)
    ],
  );
  
}


