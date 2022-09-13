import 'package:flutter/material.dart';

class LoonoColors {
  static const primary = Color.fromARGB(255, 239, 173, 137);
  static const primaryLight = Color.fromARGB(255, 254, 241, 233);
  static const primaryEnabled = Color.fromARGB(255, 190, 87, 19);
  static const primaryDisabled = Color.fromRGBO(190, 87, 19, 0.2);
  static const buttonLight = Color.fromRGBO(253, 228, 211, 1);
  static const black = Color.fromARGB(255, 26, 25, 25);
  static const blueContrast = Color.fromRGBO(8, 32, 230, 1);
  static const beigeLight = Color.fromRGBO(253, 228, 211, 1);
  static const beigeLighter = Color.fromRGBO(254, 242, 233, 1);
  static const green = Color.fromRGBO(59, 126, 129, 1);
  static const greenLight = Color.fromRGBO(241, 249, 249, 1);
  static const greenSuccess = Color.fromRGBO(59, 129, 79, 1);
  static const grey = Color.fromRGBO(99, 93, 88, 1);
  static const leaderboardPrimary = Color.fromRGBO(248, 185, 144, 1);
  static const pink = Color.fromRGBO(252, 237, 237, 1);
  static const red = Color.fromRGBO(216, 66, 72, 1);
  static const secondaryFont = Color.fromRGBO(59, 126, 129, 1);
  static const redButton = Color.fromARGB(255, 230, 87, 86);
  static const settingsBackground = Color.fromRGBO(254, 242, 233, 1);
  static const storyIndicatorActiveDark = Color.fromARGB(255, 26, 25, 25);
  static const storyIndicatorUnderlyingDark = Color.fromRGBO(26, 25, 25, 0.5);
  static const storyIndicatorActiveLight = Color.fromARGB(255, 255, 255, 255);
  static const storyIndicatorUnderlyingLight = Color.fromRGBO(248, 244, 242, 0.5);
  static const googleLogInBlue = Color.fromRGBO(66, 133, 244, 1);
  static const bottomSheetLight = Color.fromARGB(255, 254, 242, 233);
  static const bottomSheetPrevention = Color.fromRGBO(250, 200, 167, 1);
  static const faqBackgroundBlue = Color.fromRGBO(237, 248, 252, 1);
  static const checkBoxMark = Color.fromRGBO(190, 87, 19, 1);
  static const primaryWashed = Color.fromRGBO(203, 167, 142, 1);
  static const errorColor = Color.fromRGBO(194, 63, 56, 1);

  static const rainbow = <Color>[
    Color.fromARGB(255, 230, 87, 86),
    Color.fromARGB(255, 225, 127, 63),
    Color.fromARGB(255, 240, 243, 61),
    Color.fromARGB(255, 94, 221, 226),
    Color.fromARGB(255, 156, 215, 242),
    Color.fromARGB(255, 197, 85, 236),
    Color.fromARGB(255, 237, 141, 140),
  ];

  static const donateColor = Color(0xFFBE5713);
  static const expandTileColor = Color(0xFFFDE4D3);
}

class LoonoStrings {
  static const contactEmail = 'poradna@loono.cz';
  static const shieldPath = 'assets/badges/shield';
  static const pauldronsPath = 'assets/badges/pauldrons';
  static const awardShadowStirng = 'assets/icons/prevention/award_shadow.png';
  static const termsUrl = 'https://www.loono.cz/podminky-uzivani-mobilni-aplikace';
  static const privacyUrl = 'https://www.loono.cz/zasady-ochrany-osobnich-udaju-mobilni-aplikace';
  static const donateUrl = 'https://www.darujme.cz/projekt/1206713';

  static const donateDelayInterval = 14;
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

  static const subtitleFontStyle = TextStyle(
    fontSize: 14,
    color: LoonoColors.black,
    fontWeight: FontWeight.w700,
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

  static const primaryColorStyle = TextStyle(
    fontSize: 24,
    color: LoonoColors.primary,
    fontWeight: FontWeight.w700,
  );

  static const cardTitle = TextStyle(
    fontSize: 16,
    color: LoonoColors.green,
    fontWeight: FontWeight.w700,
  );

  static const cardSubtitle = TextStyle(
    fontSize: 11,
    height: 1.5,
    color: LoonoColors.primaryEnabled,
    fontWeight: FontWeight.w700,
  );

  static const cardAddress = TextStyle(
    fontSize: 12,
    height: 1.5,
    color: LoonoColors.grey,
    fontWeight: FontWeight.w400,
  );
}
