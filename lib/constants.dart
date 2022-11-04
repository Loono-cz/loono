import 'package:flutter/material.dart';

class LoonoAssets {
  static const cdLogo = 'assets/sponsors/cd.svg';
  static const ppfLogo = 'assets/sponsors/ppf.svg';
  static const cgiLogo = 'assets/sponsors/CGI.svg';

  static const genderFemale = 'assets/icons/gender-woman.svg';
  static const genderMale = 'assets/icons/gender-man.svg';
  static const genderOther = 'assets/icons/gender-other.svg';

  static const notificationBells = 'assets/icons/notification_bells.svg';

  static const person = 'assets/icons/a_person.svg';

  static const check = 'assets/icons/check.svg';

  static const doctor = 'assets/icons/a_doctor.svg';

  static const heroBackground = 'assets/icons/hero_background.svg';
  static const itemShadow = 'assets/icons/item-shadow.svg';

  static const people = 'assets/icons/people.svg';
}

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

  static const primaryLight50 = Color(0xFFFDE4D3);
  static const otherExamDetailCardColor = Color.fromRGBO(250, 247, 248, 1);
}

class LoonoStrings {
  static const contactEmail = 'poradna@loono.cz';
  static const shieldPath = 'assets/badges/shield';
  static const pauldronsPath = 'assets/badges/pauldrons';
  static const awardShadowStirng = 'assets/icons/prevention/award_shadow.png';
  static const termsUrl = 'https://www.loono.cz/podminky-uzivani-mobilni-aplikace';
  static const privacyUrl = 'https://www.loono.cz/zasady-ochrany-osobnich-udaju-mobilni-aplikace';
  static const donateUrl = 'https://www.darujme.cz/projekt/1206713';
  static const testicularExamUrl = 'https://www.loono.cz/prevence/samovysetreni#vysetri-si-koule';
  static const tumorTesticularLink =
      'https://www.linkos.cz/pacient-a-rodina/onkologicke-diagnozy/zhoubne-nadory-muzskeho-pohlavniho-ustroji-c60-c62/o-varlatech-a-nadorech-varlat/';
  static const breastExamUrl = 'https://www.loono.cz/prevence/samovysetreni#vysetri-si-prsa';
  static const tumorBreastExamUrl =
      'https://www.linkos.cz/onkologicka-prevence/informace-o-prevenci/nadory-prsu/';
  static const skinExamUrl = 'https://www.loono.cz/prevence/kuze#kuze';
  static const tumorUrl =
      'https://www.linkos.cz/pacient-a-rodina/onkologicke-diagnozy/maligni-melanom-spinaliom-bazaliom-c43-44-d03/maligni-melanom-a-ostatni-nadory-kuze/';
  static const mamoUrl = 'https://www.mamo.cz';
  static const donateDelayInterval = 14;
  static const dateWithHoursFormat = 'dd.MM.yyyy HH:mm';
  static const dateFormat = 'dd.MM.yyyy ';
  static const dateFormatSpacing = 'dd. MMMM yyyy';
  static const dateFormatWithNameMonth = 'd. MMMM yyyy';
  static const hoursFormat = 'HH:mm';
  static const monthInYear = 12;
  static const customDefaultMonth = 6;
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
  static const spinnerTextOnceTo = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const cardSubtitle = TextStyle(
    fontSize: 11,
    height: 1.5,
    color: LoonoColors.primaryEnabled,
    fontWeight: FontWeight.w700,
  );

  static const cardExaminaitonType = TextStyle(
    fontSize: 14,
    color: LoonoColors.green,
    fontWeight: FontWeight.w600,
  );

  static const cardAddress = TextStyle(
    fontSize: 12,
    height: 1.5,
    color: LoonoColors.grey,
    fontWeight: FontWeight.w400,
  );

  static const customExamLabel = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  static const customExamSubLabel = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const editExaminationMenuItem =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: Color(0xFF1A1919));

  static const actionMenuBack = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const actionMenuItem = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}
