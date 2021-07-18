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
  const UniversalDoctor({
    this.question = 'Kdy jsi byla naposledy na preventivní prohlídce u',
    required this.questionHeader,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          imagePath,
        ),
        const SizedBox(height: 32),
        Text(
          question,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Text(
          questionHeader,
          style: LoonoFonts.bigFontStyle,
        ),
        const SizedBox(height: 64),
        LoonoButton(() => {debugPrint("Foo")}, "Some text", true),
        const SizedBox(height: 16),
        LoonoButton(() => {debugPrint("Foo")}, "Some text", false),
      ],
    );
  }
}
