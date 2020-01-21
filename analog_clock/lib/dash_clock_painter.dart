import 'dart:math' as math;
import 'dart:ui' as ui;
import 'app_colors.dart' as appColors;

import 'package:flutter/material.dart';

/// A clock hand that is drawn with [CustomPainter]
///
/// The hand's length scales based on the clock's size.
/// This hand is used to build the second and minute hands, and demonstrates
/// building a custom hand.
class DashClockPainter extends CustomPainter {
  const DashClockPainter({
    @required this.periods,
    @required this.colors,
  })  : assert(periods != null),
        assert(colors != null),
        super();

  final String periods;
  final Map<appColors.Element, Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    Rect corpuse = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 0.9 * size.width,
        height: 0.8 * size.width);

    Paint corpusePaint = Paint()
      ..color = colors[appColors.Element.corpuse]
      ..style = PaintingStyle.fill;

    Paint wingsOReyesPaint = Paint()
      ..color = colors[appColors.Element.wingsOReyes]
      ..style = PaintingStyle.fill;

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(0.1 * size.width, 0.4 * size.height),
            width: 0.2 * size.width,
            height: 0.5 * size.width),
        wingsOReyesPaint);

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(0.9 * size.width, 0.4 * size.height),
            width: 0.2 * size.width,
            height: 0.5 * size.width),
        wingsOReyesPaint);

    //corpuse
    canvas.drawOval(corpuse, corpusePaint);

    canvas.save();
    Path p = Path();
    p.addOval(corpuse);
    canvas.clipPath(p, doAntiAlias: true);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height),
            width: 0.85 * size.width,
            height: size.height),
        Paint()
          ..color = colors[appColors.Element.tummy]
          ..style = PaintingStyle.fill);

    canvas.restore();

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(0.5 * size.width, 0.4 * size.height),
            width: 0.75 * size.width,
            height: 0.6 * size.height),
        Paint()
          ..color = colors[appColors.Element.corpuse]
          ..style = PaintingStyle.fill);
    // below one is big circle and instead of this circle you can draw your shape here.

    //eyes
    canvas.drawCircle(Offset(0.32 * size.width, 0.4 * size.height),
        0.2 * size.width, wingsOReyesPaint);
    canvas.drawCircle(Offset(0.68 * size.width, 0.4 * size.height),
        0.2 * size.width, wingsOReyesPaint);

    canvas.drawCircle(
        Offset(0.31 * size.width, 0.4 * size.height),
        0.10 * size.width,
        Paint()
          ..color = colors[appColors.Element.eyesSecond]
          ..style = PaintingStyle.fill);

    canvas.drawCircle(
        Offset(0.69 * size.width, 0.4 * size.height),
        0.10 * size.width,
        Paint()
          ..color = colors[appColors.Element.eyesSecond]
          ..style = PaintingStyle.fill);

    canvas.drawCircle(
        Offset(0.69 * size.width, 0.4 * size.height),
        0.10 * size.width,
        Paint()
          ..color = colors[appColors.Element.eyesOutline]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.014 * size.width);

    final rect = Rect.fromCenter(
        center: Offset(0.69 * size.width, 0.4 * size.height),
        width: 0.20 * size.width,
        height: 0.20 * size.width);

    final startAngle = -math.pi / 2;
    final sweepAngle = math.pi;
    final useCenter = false;
    final paint = Paint()
      ..color = colors[appColors.Element.eyesOutlineSecond]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.01 * size.width;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);

    canvas.drawCircle(
        Offset(0.69 * size.width, 0.4 * size.height),
        0.025 * size.width,
        Paint()
          ..color = colors[appColors.Element.eyesDot]
          ..style = PaintingStyle.fill);
    canvas.drawCircle(
        Offset(0.31 * size.width, 0.4 * size.height),
        0.025 * size.width,
        Paint()
          ..color = colors[appColors.Element.eyesDot]
          ..style = PaintingStyle.fill);

    Path hairPath = Path();
    hairPath.moveTo(0, 0);
    hairPath.lineTo(-0.01 * size.width, -0.1 * size.height);
    hairPath.lineTo(0.01 * size.width, -0.04 * size.height);
    hairPath.lineTo(0.02 * size.width, -0.12 * size.height);
    hairPath.lineTo(0.03 * size.width, -0.04 * size.height);
    hairPath.lineTo(0.08 * size.width, -0.08 * size.height);
    hairPath.lineTo(0.05 * size.width, 0);
    hairPath.close();

    canvas.drawPath(
        hairPath.shift(Offset(0.47 * size.width, 0.1 * size.height)),
        Paint()
          ..color = colors[appColors.Element.corpuse]
          ..style = PaintingStyle.fill);

    Path clawPath = Path();
    clawPath.moveTo(0.06 * size.width, 0);
    clawPath.lineTo(0.06 * size.width, 0.1 * size.height);
    clawPath.lineTo(0.03 * size.width, 0.13 * size.height);
    clawPath.lineTo(0.04 * size.width, 0.14 * size.height);
    clawPath.lineTo(0.06 * size.width, 0.13 * size.height);
    clawPath.lineTo(0.065 * size.width, 0.15 * size.height);
    clawPath.lineTo(0.085 * size.width, 0.15 * size.height);
    clawPath.lineTo(0.09 * size.width, 0.13 * size.height);
    clawPath.lineTo(0.11 * size.width, 0.14 * size.height);
    clawPath.lineTo(0.12 * size.width, 0.13 * size.height);
    clawPath.lineTo(0.09 * size.width, 0.1 * size.height);
    clawPath.lineTo(0.09 * size.width, 0);
    clawPath.close();

    canvas.drawPath(
        clawPath.shift(Offset(0.34 * size.width, 0.85 * size.height)),
        Paint()
          ..color = colors[appColors.Element.dashLegNose]
          ..style = PaintingStyle.fill);

    canvas.drawPath(
        clawPath.shift(Offset(0.54 * size.width, 0.85 * size.height)),
        Paint()
          ..color = colors[appColors.Element.dashLegNose]
          ..style = PaintingStyle.fill);

    canvas.drawCircle(
        Offset(0.5 * size.width, 0.55 * size.height),
        0.07 * size.width,
        Paint()
          ..color = colors[appColors.Element.dashLegNose]
          ..style = PaintingStyle.fill);

    Path nosePath = Path();

    this.periods == 'AM'
        ? nosePath.moveTo(0, 0)
        : nosePath.moveTo(0.14 * size.width, 0);
    this.periods == 'AM'
        ? nosePath.lineTo(-0.1 * size.width, 0.15 * size.height)
        : nosePath.lineTo(0.24 * size.width, 0.2 * size.height);

    nosePath.lineTo(0.07 * size.width, 0.07 * size.width);
    nosePath.close();

    canvas.drawPath(
        nosePath.shift(Offset(0.43 * size.width, 0.55 * size.height)),
        Paint()
          ..color = colors[appColors.Element.dashLegNose]
          ..style = PaintingStyle.fill);

    double digitSize = 0.065 * size.height;
    _drawTextAt(
        '12', Offset(0.31 * size.width, 0.25 * size.height), digitSize, canvas);
    _drawTextAt(
        '3', Offset(0.46 * size.width, 0.4 * size.height), digitSize, canvas);
    _drawTextAt(
        '6', Offset(0.31 * size.width, 0.55 * size.height), digitSize, canvas);
    _drawTextAt(
        '9', Offset(0.17 * size.width, 0.4 * size.height), digitSize, canvas);

    _drawTextAt(
        '60', Offset(0.69 * size.width, 0.25 * size.height), digitSize, canvas);
    _drawTextAt(
        '15', Offset(0.83 * size.width, 0.4 * size.height), digitSize, canvas);
    _drawTextAt(
        '30', Offset(0.69 * size.width, 0.55 * size.height), digitSize, canvas);
    _drawTextAt(
        '45', Offset(0.54 * size.width, 0.4 * size.height), digitSize, canvas);

    Offset periodOffset = this.periods == 'AM'
        ? Offset(0.15 * size.width, 0.92 * size.height)
        : Offset(0.85 * size.width, 0.92 * size.height);

    _drawTextAt(this.periods, periodOffset, 1.8 * digitSize, canvas);

    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawTextAt(
      String text, Offset position, double fontSize, Canvas canvas) {
    TextSpan textSpan = TextSpan(
      text: text,
      style: getTextStyle(
          Size(0.0, 0.0), fontSize, position, PaintingStyle.stroke),
    );
    TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    Offset drawPosition = Offset(position.dx - (textPainter.width / 2),
        position.dy - (textPainter.height / 2));
    textPainter.paint(canvas, drawPosition);
    Size size = Size(textPainter.width, textPainter.height);
    textSpan = TextSpan(
      text: text,
      style: getTextStyle(Size(size.width, size.height), fontSize, position,
          PaintingStyle.fill),
    );
    textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    drawPosition = Offset(position.dx - (textPainter.width / 2),
        position.dy - (textPainter.height / 2));
    textPainter.paint(canvas, drawPosition);
  }

  TextStyle getTextStyle(Size size, double fontSize, Offset position,
      PaintingStyle paintingStyle) {
    List<ui.Color> colorsFill = [
      colors[appColors.Element.textPrimary],
      colors[appColors.Element.textSecondary]
    ];

    Shader shader = new LinearGradient(
            colors: colorsFill,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)
        .createShader(new Rect.fromLTWH(
            position.dx, position.dy, size.width, size.height));

    Paint paint = Paint()
      ..style = paintingStyle
      ..strokeWidth = fontSize / 8;

    if (paintingStyle == PaintingStyle.fill) {
      paint.shader = shader;
    } else {
      paint.color = colors[appColors.Element.textStroke];
    }

    return TextStyle(
        fontSize: fontSize, fontWeight: ui.FontWeight.bold, foreground: paint);
  }
}
