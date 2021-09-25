import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/screens/onboarding/preventive_examination_date_picker.dart';
import 'package:loono/utils/registry.dart';

class GeneralPractitionerDateScreen extends StatefulWidget {
  const GeneralPractitionerDateScreen({Key? key}) : super(key: key);

  @override
  State<GeneralPractitionerDateScreen> createState() => _GeneralPractitionerDateScreenState();
}

class _GeneralPractitionerDateScreenState extends State<GeneralPractitionerDateScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return PreventiveExaminationDatePickerScreen(
      image: SvgPicture.asset('assets/icons/practicioner.svg', width: 50),
      title: context.l10n.general_practitioner,
      onDateChanged: (value) => selectedDate = value,
      onContinueButtonPress: () async {
        if (selectedDate == null) return;
        await registry.get<DatabaseService>().users.updateGeneralPracticionerVisitDate(
            DateWithoutDay(month: monthFromInt(selectedDate!.month), year: selectedDate!.year));
      },
      onSkipButtonPress: () => AutoRouter.of(context).pushNamed('onboarding/allow_notifications'),
    );
  }
}
