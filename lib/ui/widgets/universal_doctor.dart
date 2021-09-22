import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/onboarding/carousel/carousel_content.dart';

class UniversalDoctor extends StatelessWidget {
  final String question;
  final String questionHeader;
  final String imagePath;
  final String button1Text;
  final String button2Text;
  final void Function() nextCallback1;
  final void Function() nextCallback2;

  const UniversalDoctor({
    this.question = 'Kdy jsi byl/a naposledy na preventivní prohlídce u',
    required this.questionHeader,
    required this.imagePath,
    required this.button1Text,
    required this.button2Text,
    required this.nextCallback1,
    required this.nextCallback2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        SvgPicture.asset(
          'assets/icons/$imagePath.svg',
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: TextHighlighter.parse(question, highlightPattern: '(preventivní prohlídce)')
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
        const Spacer(),
      ],
    );
  }
}
