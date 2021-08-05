import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/loono_button.dart';

enum DoctorVisit {
  lastTwoYears,
  moreThanTwoYears,
}

enum DoctorType { practitioner, gynecologist }

class UniversalDoctor extends StatelessWidget {
  final DoctorType forDoctorType;
  final void Function() nextCallback;
  const UniversalDoctor({
    required this.forDoctorType,
    required this.nextCallback,
  });

  @override
  Widget build(BuildContext context) {
    String _question;
    String _questionHeader;
    String _imagePath;
    final double _bodyFooterDistance = MediaQuery.of(context).size.height / 8;

    switch (forDoctorType) {
      case DoctorType.practitioner:
        _question = 'Kdy jsi byl/a naposledy na preventivní prohlídce u';
        _questionHeader = 'Praktického lékaře?';
        _imagePath = 'practicioner';
        break;
      case DoctorType.gynecologist:
        _question = 'Kdy jsi byla naposledy na preventivní prohlídce na';
        _questionHeader = 'Gynekologii?';
        _imagePath = 'gynecology';
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/icons/$_imagePath.svg',
        ),
        const SizedBox(height: 16),
        Text(
          _question,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          _questionHeader,
          style: LoonoFonts.bigFontStyle,
        ),
        SizedBox(height: _bodyFooterDistance),
        LoonoButton(nextCallback, "V posledních dvou letech", enabled: true),
        const SizedBox(height: 16),
        LoonoButton(nextCallback, "Více, než 2 roky nebo nevím", enabled: true),
      ],
    );
  }
}
