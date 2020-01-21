import 'package:flutter/material.dart';

enum Element {
  backgroundPrimary,
  backgroundSecondary,
  textPrimary,
  textSecondary,
  textStroke,
  corpuse,
  tummy,
  dashLegNose,
  wingsOReyes,
  eyesDot,
  eyesSecond,
  eyesOutline,
  eyesOutlineSecond,
}

final lightTheme = {
  Element.backgroundPrimary: Color(0xffDBB68B),
  Element.backgroundSecondary: Color(0xff72A299),
  Element.textPrimary: Color(0xffFFFFFF),
  Element.textSecondary: Color(0xffA6F9D7),
  Element.textStroke: Color(0xff183A15),
  Element.corpuse: Color(0xff8ADEF8),
  Element.tummy: Colors.white,
  Element.dashLegNose: Colors.orange,
  Element.wingsOReyes: Color(0xff40B8ED),
  Element.eyesDot: Colors.white,
  Element.eyesSecond: Colors.black,
  Element.eyesOutline: Color(0xff3BDDC5),
  Element.eyesOutlineSecond: Color(0xff183A15),
};

final darkTheme = {
  Element.backgroundPrimary: Color(0xff3A3B3C),
  Element.backgroundSecondary: Color(0xff18191A),
  Element.textPrimary: Color(0xffCCCDCE),
  Element.textSecondary: Color(0xffBCBDBE),
  Element.textStroke: Colors.black,
  Element.corpuse: Color(0xff262728),
  Element.tummy: Color(0xff616263),
  Element.dashLegNose: Color(0xff34301E),
  Element.wingsOReyes: Color(0xff0F0F0F),
  Element.eyesDot: Color(0xff9D9D9D),
  Element.eyesSecond: Colors.black,
  Element.eyesOutline: Color(0xff474849),
  Element.eyesOutlineSecond: Color(0xff0D0D0D),
};
