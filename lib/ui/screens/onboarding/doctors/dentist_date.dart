import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/onboarding_state_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/screens/onboarding/preventive_examination_date_picker.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

import '../../../../helpers/flushbar_message.dart';

class DentistDateScreen extends StatefulWidget {
  const DentistDateScreen({Key? key}) : super(key: key);

  @override
  State<DentistDateScreen> createState() => _DentistDateScreenState();
}

class _DentistDateScreenState extends State<DentistDateScreen> {
  final _examinationsQuestionnairesDao = registry.get<DatabaseService>().examinationQuestionnaires;

  static const _type = ExaminationType.DENTIST;

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return PreventiveExaminationDatePickerScreen(
      image: SvgPicture.asset('assets/icons/dentist.svg', width: 50),
      title: context.l10n.dentist,
      onDateChanged: (value) => selectedDate = value,
      onContinueButtonPress: () async {
        if (selectedDate == null) return;
        if (selectedDate?.isAfter(DateTime.now()) ?? true) {
          showFlushBarError(
            context,
            context.l10n.datepicker_error_user_input,
            sync: false,
          );
        } else {
          await _examinationsQuestionnairesDao.updateLastVisitDate(
            _type,
            dateWithoutDay:
                DateWithoutDay(month: monthFromInt(selectedDate!.month), year: selectedDate!.year),
          );
          await pushNotificationOrPreAuthMainScreen(context);
        }
      },
      onSkipButtonPress: () async {
        await _examinationsQuestionnairesDao.setDontKnowLastVisitDate(_type);
        await pushNotificationOrPreAuthMainScreen(context);
      },
    );
  }
}
