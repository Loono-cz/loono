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
  final void Function() nextCallback;
  const UniversalDoctor({
    this.question = 'Kdy jsi byla naposledy na preventivní prohlídce u',
    required this.questionHeader,
    required this.imagePath,
    required this.nextCallback,
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
        LoonoButton(nextCallback, "V posledních dvou letech", enabled: true),
        const SizedBox(height: 8),
        LoonoButton(nextCallback, "Více, než 2 roky nebo nevím", enabled: true),
      ],
    );
  }
}
