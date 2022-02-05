import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/screens/onboarding/preventive_examination_date_picker.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class DentistDateScreen extends StatefulWidget {
  const DentistDateScreen({Key? key}) : super(key: key);

  @override
  State<DentistDateScreen> createState() => _DentistDateScreenState();
}

class _DentistDateScreenState extends State<DentistDateScreen> {
  final _examinationsQuestionnairesDao = registry.get<DatabaseService>().examinationQuestionnaires;

  static const _type = ExaminationTypeEnum.DENTIST;

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return PreventiveExaminationDatePickerScreen(
      image: SvgPicture.asset('assets/icons/dentist.svg', width: 50),
      title: context.l10n.dentist,
      onDateChanged: (value) => selectedDate = value,
      onContinueButtonPress: () async {
        if (selectedDate == null) return;
        await _examinationsQuestionnairesDao.updateLastVisitDate(
          _type,
          dateWithoutDay:
              DateWithoutDay(month: monthFromInt(selectedDate!.month), year: selectedDate!.year),
        );
        await AutoRouter.of(context).push(CreateAccountRoute());
      },
      onSkipButtonPress: () async {
        await _examinationsQuestionnairesDao.setUnknownLastVisitDate(_type);
        await AutoRouter.of(context).push(CreateAccountRoute());
      },
    );
  }
}
