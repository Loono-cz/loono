import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/text_highlighter.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono_api/loono_api.dart';

class UniversalDoctor extends StatelessWidget {
  const UniversalDoctor({
    Key? key,
    required this.question,
    required this.questionHeader,
    required this.assetPath,
    required this.button1Text,
    required this.button2Text,
    required this.nextCallback1,
    required this.nextCallback2,
    required this.examinationType,
  }) : super(key: key);

  final String question;
  final String questionHeader;
  final String assetPath;
  final String button1Text;
  final String button2Text;
  final VoidCallback nextCallback1;
  final VoidCallback nextCallback2;
  final ExaminationType examinationType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(75),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
            color: LoonoColors.beigeLighter,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: -10,
                  child: SvgPicture.asset(
                    assetPath,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: TextHighlighter.parse(
              '$question ${czechPreposition(context, examinationType: examinationType)}',
              highlightPattern: '(preventivní prohlídce)',
            )
                .map(
                  (item) => TextSpan(
                    text: item.text,
                    style: item.highlight
                        ? LoonoFonts.fontStyle.copyWith(fontWeight: FontWeight.bold)
                        : LoonoFonts.fontStyle,
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${questionHeader.toUpperCase()}?',
          style: LoonoFonts.bigFontStyle,
        ),
        const Spacer(),
        LoonoButton.light(
          onTap: nextCallback1,
          text: button1Text,
        ),
        const SizedBox(height: 20),
        LoonoButton.light(
          onTap: nextCallback2,
          text: button2Text,
        ),
        SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
      ],
    );
  }
}
