import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono_api/loono_api.dart';
import 'package:url_launcher/url_launcher_string.dart';

HarmDisclosureUrls methodologyDisclosureByType(SelfExaminationType type) {
  var loonoUrl = '';
  var linkosUrl = '';
  switch (type) {
    case SelfExaminationType.BREAST:
      loonoUrl = LoonoStrings.breastExamUrl;
      linkosUrl = LoonoStrings.tumorBreastExamUrl;
      break;

    case SelfExaminationType.SKIN:
      loonoUrl = LoonoStrings.skinExamUrl;
      linkosUrl = LoonoStrings.tumorUrl;
      break;

    case SelfExaminationType.TESTICULAR:
      loonoUrl = LoonoStrings.testicularExamUrl;
      linkosUrl = LoonoStrings.tumorTesticularLink;
      break;
  }
  return HarmDisclosureUrls(loonoUrl: loonoUrl, linkosUrl: linkosUrl);
}

Widget harmDisclosureWidget(BuildContext context, SelfExaminationType type) {
  final disclosure = methodologyDisclosureByType(type);
  return RichText(
    text: TextSpan(
      text: AppLocalizationsExt(context).l10n.more_information_about_self_exam,
      style: LoonoFonts.paragraphSmallFontStyle,
      children: <TextSpan>[
        TextSpan(
          text: AppLocalizationsExt(context).l10n.our_web_page,
          style: const TextStyle(decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunchUrlString(disclosure.loonoUrl)) {
                await launchUrlString(disclosure.loonoUrl);
              }
            },
        ),
        TextSpan(
          text:
          AppLocalizationsExt(context).l10n.or_on_linkos_web_page,
        ),
        TextSpan(
          text: AppLocalizationsExt(context).l10n.czech_oncology_corp,
          style: const TextStyle(decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunchUrlString(disclosure.linkosUrl)) {
                await launchUrlString(disclosure.linkosUrl);
              }
            },
        ),
      ],
    ),
  );
}

class HarmDisclosureUrls {
  HarmDisclosureUrls({required this.loonoUrl, required this.linkosUrl});
  String loonoUrl;
  String linkosUrl;
}
