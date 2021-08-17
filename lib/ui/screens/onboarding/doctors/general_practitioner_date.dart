import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/screens/onboarding/preventive_examination_date_picker.dart';

class GeneralPractitionerDateScreen extends StatelessWidget {
  const GeneralPractitionerDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreventiveExaminationDatePickerScreen(
      image: SvgPicture.asset('assets/icons/practicioner.svg', width: 50),
      title: context.l10n.general_practitioner,
      onDateChanged: (value) => print(value),
      onContinueButtonPress: () => Navigator.pushNamed(context, '/onboarding/allow_notifications'),
      onSkipButtonPress: () => Navigator.pushNamed(context, '/onboarding/allow_notifications'),
    );
  }
}
