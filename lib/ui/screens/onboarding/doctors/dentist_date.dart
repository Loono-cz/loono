import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/screens/onboarding/preventive_examination_date_picker.dart';

class DentistDateScreen extends StatelessWidget {
  const DentistDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreventiveExaminationDatePickerScreen(
      image: SvgPicture.asset('assets/icons/dentist.svg', width: 50),
      title: context.l10n.detist,
      onDateChanged: (value) => print(value),
      onContinueButtonPress: () => Navigator.pushNamed(context, '/create-account'),
      onSkipButtonPress: () => Navigator.pushNamed(context, '/create-account'),
    );
  }
}
