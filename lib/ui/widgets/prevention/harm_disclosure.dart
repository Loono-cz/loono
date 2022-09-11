import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono_api/loono_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget methodologyDisclosureByType(SelfExaminationType type) {
  var loonoUrl = '';
  var linkosUrl = '';
  switch (type) {
    case SelfExaminationType.BREAST:
      loonoUrl = 'https://www.loono.cz/prevence/samovysetreni#vysetri-si-koule';
      linkosUrl =
      'https://www.linkos.cz/onkologicka-prevence/informace-o-prevenci/nadory-prsu/';
      break;

    case SelfExaminationType.SKIN:
      loonoUrl = 'https://www.loono.cz/prevence/kuze#kuze';
      linkosUrl =
      'https://www.linkos.cz/pacient-a-rodina/onkologicke-diagnozy/maligni-melanom-spinaliom-bazaliom-c43-44-d03/maligni-melanom-a-ostatni-nadory-kuze/';
      break;

    case SelfExaminationType.TESTICULAR:
      loonoUrl = 'https://www.loono.cz/prevence/samovysetreni#vysetri-si-koule';
      linkosUrl =
      'https://www.linkos.cz/pacient-a-rodina/onkologicke-diagnozy/zhoubne-nadory-muzskeho-pohlavniho-ustroji-c60-c62/o-varlatech-a-nadorech-varlat/';
      break;
  }
  return _ui(loonoUrl, linkosUrl);
}

Widget methodologyDisclosure(Sex sex) {
  final loonoUrl = sex == Sex.MALE
      ? 'https://www.loono.cz/prevence/samovysetreni#vysetri-si-koule'
      : 'https://www.loono.cz/prevence/samovysetreni#vysetri-si-prsa';
  final linkosUrl = sex == Sex.MALE
      ? 'https://www.linkos.cz/pacient-a-rodina/onkologicke-diagnozy/zhoubne-nadory-muzskeho-pohlavniho-ustroji-c60-c62/o-varlatech-a-nadorech-varlat/'
      : 'https://www.linkos.cz/onkologicka-prevence/informace-o-prevenci/nadory-prsu/';

  return _ui(loonoUrl, linkosUrl);
}

Widget _ui(String loonoUrl, String linkosUrl) {
  return RichText(
    text: TextSpan(
      text: 'Více informací o správném postupu samovyšetření nalezneš také na ',
      style: LoonoFonts.paragraphSmallFontStyle,
      children: <TextSpan>[
        TextSpan(
          text: 'našem webu',
          style: const TextStyle(decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunchUrlString(loonoUrl)) {
                await launchUrlString(loonoUrl);
              }
            },
        ),
        const TextSpan(text: ' nebo na webu '),
        TextSpan(
          text: 'České onkologické společnosti.',
          style: const TextStyle(decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunchUrlString(linkosUrl)) {
                await launchUrlString(linkosUrl);
              }
            },
        ),
      ],
    ),
  );
}