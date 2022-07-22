import 'package:flutter/material.dart';
import 'package:smart_home_iot/constants/app_colors.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2630000, size.height * -0.3300000);
    path_0.cubicTo(
        size.width * 0.3125000,
        size.height * -0.2720000,
        size.width * 0.3045000,
        size.height * -0.1620000,
        size.width * 0.3085000,
        size.height * -0.06550000);
    path_0.cubicTo(
        size.width * 0.3120000,
        size.height * 0.03100000,
        size.width * 0.3275000,
        size.height * 0.1145000,
        size.width * 0.3045000,
        size.height * 0.1950000);
    path_0.cubicTo(
        size.width * 0.2810000,
        size.height * 0.2760000,
        size.width * 0.2190000,
        size.height * 0.3535000,
        size.width * 0.1545000,
        size.height * 0.3410000);
    path_0.cubicTo(
        size.width * 0.09000000,
        size.height * 0.3280000,
        size.width * 0.02300000,
        size.height * 0.2250000,
        size.width * -0.03150000,
        size.height * 0.1695000);
    path_0.cubicTo(
        size.width * -0.08600000,
        size.height * 0.1140000,
        size.width * -0.1275000,
        size.height * 0.1055000,
        size.width * -0.1965000,
        size.height * 0.07200000);
    path_0.cubicTo(
        size.width * -0.2655000,
        size.height * 0.03800000,
        size.width * -0.3625000,
        size.height * -0.02150000,
        size.width * -0.3855000,
        size.height * -0.09850000);
    path_0.cubicTo(
        size.width * -0.4085000,
        size.height * -0.1760000,
        size.width * -0.3575000,
        size.height * -0.2710000,
        size.width * -0.2815000,
        size.height * -0.3245000);
    path_0.cubicTo(
        size.width * -0.2050000,
        size.height * -0.3780000,
        size.width * -0.1025000,
        size.height * -0.3895000,
        size.width * 0.002000000,
        size.height * -0.3925000);
    path_0.cubicTo(
        size.width * 0.1070000,
        size.height * -0.3950000,
        size.width * 0.2135000,
        size.height * -0.3885000,
        size.width * 0.2630000,
        size.height * -0.3300000);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffFF0066).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
