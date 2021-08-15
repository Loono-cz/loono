import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/loono_button.dart';
import 'package:loono/l10n/ext.dart';

enum DoctorVisit {
  lastTwoYears,
  moreThanTwoYears,
}

enum DoctorType { practitioner, gynecologist, dentist }

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
        _question = context.l10n.universal_dr_practitioner_question;
        _questionHeader = context.l10n.universal_dr_practitioner_question_header;
        _imagePath = 'practicioner';
        break;
      case DoctorType.gynecologist:
        _question = context.l10n.universal_dr_gynecology_question;
        _questionHeader = context.l10n.universal_dr_gynecology_question_header;
        _imagePath = 'gynecology';
        break;
      case DoctorType.dentist:
        _question = context.l10n.universal_dr_dentist_question;
        _questionHeader = context.l10n.universal_dr_dentist_question_header;
        _imagePath = 'dentist';
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
        const SizedBox(height: 8),
        Text(
          _questionHeader,
          style: LoonoFonts.bigFontStyle,
        ),
        SizedBox(height: _bodyFooterDistance),
        LoonoButton(nextCallback, context.l10n.universal_dr_button_last_two_years, enabled: true),
        const SizedBox(height: 16),
        LoonoButton(nextCallback, context.l10n.universal_dr_button_more_than_two_years,
            enabled: true),
      ],
    );
  }
}
