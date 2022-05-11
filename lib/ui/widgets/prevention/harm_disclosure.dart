import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono_api/loono_api.dart';
import 'package:url_launcher/url_launcher.dart';

Widget methodologyDisclosure(Sex sex) {
  final loonoUrl = sex == Sex.MALE
      ? 'https://www.loono.cz/prevence/samovysetreni#vysetri-si-koule'
      : 'https://www.loono.cz/prevence/samovysetreni#vysetri-si-prsa';
  final linkosUrl = sex == Sex.MALE
      ? 'https://www.linkos.cz/pacient-a-rodina/onkologicke-diagnozy/zhoubne-nadory-muzskeho-pohlavniho-ustroji-c60-c62/o-varlatech-a-nadorech-varlat/'
      : 'https://www.linkos.cz/onkologicka-prevence/informace-o-prevenci/nadory-prsu/';
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
              if (await canLaunch(loonoUrl)) {
                await launch(loonoUrl);
              }
            },
        ),
        const TextSpan(text: ' nebo na webu '),
        TextSpan(
          text: 'České onkologické společnosti.',
          style: const TextStyle(decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunch(linkosUrl)) {
                await launch(linkosUrl);
              }
            },
        ),
      ],
    ),
  );
}
