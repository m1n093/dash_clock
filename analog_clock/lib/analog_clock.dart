// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'dash_clock_painter.dart';
import 'dash_foreground_painter.dart';

import 'app_colors.dart' as appColors;

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
/// You can do better than this!
class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  var _temperature = '';
  var _location = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? appColors.lightTheme
        : appColors.darkTheme;

    // There are many ways to apply themes to your clock. Some are:
    //  - Inherit the parent Theme (see ClockCustomizer in the
    //    flutter_clock_helper package).
    //  - Override the Theme.of(context).colorScheme.
    //  - Create your own [ThemeData], demonstrated in [AnalogClock].
    //  - Create a map of [Color]s to custom keys, demonstrated in
    //    [DigitalClock].
    final time = DateFormat.Hms().format(DateTime.now());

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = colors[appColors.Element.textStroke];
    Paint paintFill = Paint()
      ..style = PaintingStyle.fill
      ..color = colors[appColors.Element.textPrimary];
    TextStyle textStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, foreground: paint);
    TextStyle textStyleFill = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, foreground: paintFill);

    final weatherInfo = DefaultTextStyle(
      style: textStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_temperature),
          Text(_location),
        ],
      ),
    );

    final weatherInfoFill = DefaultTextStyle(
      style: textStyleFill,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_temperature),
          Text(_location),
        ],
      ),
    );

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                  0.3,
                  0.7,
                ],
                    colors: [
                  colors[appColors.Element.backgroundPrimary],
                  colors[appColors.Element.backgroundSecondary],
                ])),
            child: Flex(direction: Axis.horizontal, children: [
              Expanded(
                flex: 100,
                child: Container(),
              ),
              Expanded(
                flex: 168,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      child: SizedBox.expand(
                        child: CustomPaint(
                          painter: DashClockPainter(
                              periods: _now.hour <= 12 ? 'AM' : 'PM',
                              colors: colors),
                          foregroundPainter: DashForegroundPainter(
                              secondAngleRadians: _now.second * radiansPerTick,
                              minuteAngleRadians: _now.minute * radiansPerTick,
                              hourAngleRadians: _now.hour * radiansPerHour +
                                  (_now.minute / 60) * radiansPerHour,
                              colors: colors),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: weatherInfo,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: weatherInfoFill,
            ),
          )
        ],
      ),
    );
  }
}
