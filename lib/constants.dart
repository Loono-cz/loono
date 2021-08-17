import 'package:flutter/material.dart';

class LoonoColors {
  static const inactiveButtonFace = Color.fromARGB(255, 255, 250, 247);
  static const primary = Color.fromARGB(255, 239, 173, 137);
  static const primaryLight = Color.fromARGB(255, 254, 241, 233);
  static const primaryEnabled = Color.fromARGB(255, 190, 87, 19);
  static const primaryDisabled = Color.fromRGBO(190, 87, 19, 0.2);
  static const black = Color.fromARGB(255, 26, 25, 25);
  static const green = Color.fromARGB(255, 167, 206, 130);
  static const gray = Color.fromARGB(255, 186, 186, 186);
  static const lightGray = Color.fromARGB(255, 248, 244, 242);
  static const secondaryFont = Color.fromARGB(255, 98, 181, 182);
  static const storyIndicatorActiveDark = Color.fromARGB(255, 26, 25, 25);
  static const storyIndicatorUnderlyingDark = Color.fromRGBO(26, 25, 25, 0.5);
  static const storyIndicatorActiveLight = Color.fromARGB(255, 255, 255, 255);
  static const storyIndicatorUnderlyingLight = Color.fromRGBO(248, 244, 242, 0.5);
  static const googleLogInBlue = Color.fromRGBO(66, 133, 244, 1);
}

class LoonoFonts {
  static const bigFontStyle = TextStyle(
    fontSize: 25,
    color: LoonoColors.secondaryFont,
    fontWeight: FontWeight.bold,
  );

  static const fontStyle = TextStyle(
    color: LoonoColors.black,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const headerFontStyle = TextStyle(
    fontSize: 24,
    color: LoonoColors.black,
    fontWeight: FontWeight.normal,
  );

  static const paragraphFontStyle = TextStyle(
    fontSize: 14,
    height: 1.5,
    color: LoonoColors.black,
    fontWeight: FontWeight.normal,
  );

  static const paragraphSmallFontStyle = TextStyle(
    fontSize: 12,
    height: 1.5,
    color: LoonoColors.black,
    fontWeight: FontWeight.normal,
  );
}
