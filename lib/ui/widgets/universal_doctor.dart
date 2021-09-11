import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/button.dart';

enum DoctorVisit {
  lastTwoYears,
  moreThanTwoYears,
}

class UniversalDoctor extends StatelessWidget {
  final String question;
  final String questionHeader;
  final String imagePath;
  final void Function() nextCallback1;
  final void Function() nextCallback2;
  const UniversalDoctor({
    this.question = 'Kdy jsi byla naposledy na preventivní prohlídce u',
    required this.questionHeader,
    required this.imagePath,
    required this.nextCallback1,
    required this.nextCallback2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/icons/$imagePath.svg',
        ),
        const SizedBox(height: 16),
        Text(
          question,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          questionHeader,
          style: LoonoFonts.bigFontStyle,
        ),
        const SizedBox(height: 16),
        LoonoButton.light(onTap: nextCallback1, text: "V posledních dvou letech"),
        const SizedBox(height: 8),
        LoonoButton.light(onTap: nextCallback2, text: "Více, než 2 roky nebo nevím"),
      ],
    );
  }
}
