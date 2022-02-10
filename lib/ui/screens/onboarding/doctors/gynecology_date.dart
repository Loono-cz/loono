import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/screens/onboarding/preventive_examination_date_picker.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class GynecologyDateScreen extends StatefulWidget {
  const GynecologyDateScreen({Key? key}) : super(key: key);

  @override
  State<GynecologyDateScreen> createState() => _GynecologyDateScreenState();
}

class _GynecologyDateScreenState extends State<GynecologyDateScreen> {
  final _examinationsQuestionnairesDao = registry.get<DatabaseService>().examinationQuestionnaires;

  static const _type = ExaminationTypeEnum.GYNECOLOGIST;

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return PreventiveExaminationDatePickerScreen(
      image: SvgPicture.asset('assets/icons/gynecology.svg', width: 50),
      title: context.l10n.gynecology,
      onDateChanged: (value) => selectedDate = value,
      onContinueButtonPress: () async {
        if (selectedDate == null) return;
        await _examinationsQuestionnairesDao.updateLastVisitDate(
          _type,
          dateWithoutDay:
              DateWithoutDay(month: monthFromInt(selectedDate!.month), year: selectedDate!.year),
        );
      },
      onSkipButtonPress: () async => _examinationsQuestionnairesDao.setDontKnowLastVisitDate(_type),
    );
  }
}
