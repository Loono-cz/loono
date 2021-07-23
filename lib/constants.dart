import 'package:flutter/material.dart';

class LoonoColors {
  static const inactiveButtonFace = Color.fromARGB(255, 255, 250, 247);
  static const primary = Color.fromARGB(255, 239, 173, 137);
  static const primaryLight = Color.fromARGB(255, 254, 241, 233);
  static const green = Color.fromARGB(255, 167, 206, 130);
  static const gray = Color.fromARGB(255, 186, 186, 186);
  static const lightGray = Color.fromARGB(255, 248, 244, 242);
  static const secondaryFont = Color.fromARGB(255, 98, 181, 182);
  static const storyIndicatorActiveDark = Color.fromARGB(255, 26, 25, 25);
  static const storyIndicatorUnderlyingDark = Color.fromRGBO(26, 25, 25, 0.5);
  static const storyIndicatorActiveLight = Color.fromARGB(255, 255, 255, 255);
  static const storyIndicatorUnderlyingLight = Color.fromRGBO(248, 244, 242, 0.5);
}

class LoonoFonts {
  static const bigFontStyle = TextStyle(
    fontSize: 25,
    color: LoonoColors.secondaryFont,
    fontWeight: FontWeight.bold,
  );
}
