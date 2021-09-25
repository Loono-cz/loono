import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/screens/onboarding/preventive_examination_date_picker.dart';
import 'package:loono/utils/registry.dart';

class DentistDateScreen extends StatefulWidget {
  const DentistDateScreen({Key? key}) : super(key: key);

  @override
  State<DentistDateScreen> createState() => _DentistDateScreenState();
}

class _DentistDateScreenState extends State<DentistDateScreen> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return PreventiveExaminationDatePickerScreen(
      image: SvgPicture.asset('assets/icons/dentist.svg', width: 50),
      title: context.l10n.detist,
      onDateChanged: (value) => selectedDate = value,
      onContinueButtonPress: () async {
        if (selectedDate == null) return;
        await registry.get<DatabaseService>().users.updateDentistVisitDate(
            DateWithoutDay(month: monthFromInt(selectedDate!.month), year: selectedDate!.year));
        AutoRouter.of(context).pushNamed('create-account');
      },
      onSkipButtonPress: () => AutoRouter.of(context).pushNamed('create-account'),
    );
  }
}
