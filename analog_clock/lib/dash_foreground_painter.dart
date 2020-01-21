import 'dart:math' as math;
import 'app_colors.dart' as appColors;

import 'package:flutter/material.dart';

class DashForegroundPainter extends CustomPainter {
  const DashForegroundPainter({
    @required this.secondAngleRadians,
    @required this.minuteAngleRadians,
    @required this.hourAngleRadians,
    @required this.colors,
  })  : assert(secondAngleRadians != null),
        assert(minuteAngleRadians != null),
        assert(hourAngleRadians != null),
        assert(colors != null),
        super();

  final double secondAngleRadians;
  final double minuteAngleRadians;
  final double hourAngleRadians;
  final Map<appColors.Element, Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final startAngle = -math.pi / 2;
    var distance = 0.06 * size.height;
    final rectEye1 = Rect.fromCenter(
        center: Offset(0.31 * size.width, 0.4 * size.height),
        width: 0.20 * size.width,
        height: 0.20 * size.width);
    final rectEye2 = Rect.fromCenter(
        center: Offset(0.69 * size.width, 0.4 * size.height),
        width: 0.20 * size.width,
        height: 0.20 * size.width);
    final sweepSecondAngle = this.secondAngleRadians;
    final sweepMinuteAngle = this.minuteAngleRadians;
    final sweepHourAngle = this.hourAngleRadians;
    final useCenter = false;
    final paint = Paint()
      ..color = colors[appColors.Element.eyesOutlineSecond]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.01 * size.width;
    final paintOutline = Paint()
      ..color = colors[appColors.Element.eyesOutline]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.014 * size.width;

    final paintWhite = Paint()
      ..color = colors[appColors.Element.eyesDot]
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(0.69 * size.width, 0.4 * size.height),
        0.10 * size.width, paintOutline);
    canvas.drawCircle(Offset(0.31 * size.width, 0.4 * size.height),
        0.10 * size.width, paintOutline);

    canvas.drawArc(rectEye1, startAngle, sweepMinuteAngle, useCenter, paint);
    canvas.drawArc(rectEye2, startAngle, sweepSecondAngle, useCenter, paint);

    canvas.drawCircle(
        Offset(
            0.69 * size.width +
                distance * math.cos(math.pi / 2 - sweepMinuteAngle),
            0.4 * size.height -
                distance * math.sin(math.pi / 2 - sweepMinuteAngle)),
        0.012 * size.width,
        paintWhite);

    canvas.drawCircle(
        Offset(
            0.31 * size.width +
                distance * math.cos(math.pi / 2 - sweepHourAngle),
            0.4 * size.height -
                distance * math.sin(math.pi / 2 - sweepHourAngle)),
        0.012 * size.width,
        paintWhite);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
