import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono_api/loono_api.dart';

TextStyle earlyOrderStyles(CategorizedExamination examination) {
  var color = LoonoColors.black;
  var weight = FontWeight.w400;
  final nextVisit = examination.examination.plannedDate;

  if (nextVisit != null &&
      [
        const ExaminationCategory.scheduled(),
        const ExaminationCategory.scheduledSoonOrOverdue(),
      ].contains(examination.category) &&
      DateTime.now().isBefore(nextVisit)) {
    color = LoonoColors.green;
  } else if ([
    const ExaminationCategory.newToSchedule(),
    const ExaminationCategory.unknownLastVisit(),
  ].contains(examination.category)) {
    color = LoonoColors.red;
    weight = FontWeight.w700;
  }
  return LoonoFonts.cardTitle.copyWith(color: color, fontWeight: weight);
}

TextStyle preventiveInspectionStyles(ExaminationCategory category) {
  var color = LoonoColors.green;
  var weight = FontWeight.w400;

  if (category == const ExaminationCategory.scheduledSoonOrOverdue()) {
    color = LoonoColors.red;
    weight = FontWeight.w700;
  } else if ([
    const ExaminationCategory.scheduled(),
    const ExaminationCategory.unknownLastVisit(),
  ].contains(category)) {
    color = LoonoColors.black;
  }
  return LoonoFonts.cardTitle.copyWith(color: color, fontWeight: weight);
}

String czechPreposition(BuildContext context, {required ExaminationType examinationType}) {
  if ([
    ExaminationType.COLONOSCOPY,
    ExaminationType.MAMMOGRAM,
  ].contains(examinationType)) {
    return 'na';
  } else {
    return 'u';
  }
}

final czechMonthsInflected = [
  'lednu',
  'únoru',
  'březnu',
  'dubnu',
  'květnu',
  'červnu',
  'červenci',
  'srpnu',
  'září',
  'říjnu',
  'listopadu',
  'prosinci',
];

/// Gets localized message of: "In the last [interval] years".
String getQuestionnaireFirstAnswer(
  BuildContext context, {
  required int interval,
}) {
  final l10n = context.l10n;
  return Intl.plural(
    interval,
    one: l10n.questionnaire_first_answer_intl_one,
    few: l10n.questionnaire_first_answer_intl_few_and_other(interval),
    other: l10n.questionnaire_first_answer_intl_few_and_other(interval),
    locale: 'cs-CZ',
  );
}

/// Gets localized message of: "More than [interval] years".
String getQuestionnaireSecondAnswer(
  BuildContext context, {
  required int interval,
}) {
  final l10n = context.l10n;
  return Intl.plural(
    interval,
    one: l10n.questionnaire_second_answer_intl_one,
    few: l10n.questionnaire_second_answer_intl_few(interval),
    other: l10n.questionnaire_second_answer_intl_other(interval),
    locale: 'cs-CZ',
  );
}

String procedureQuestionTitle(
  BuildContext context, {
  required ExaminationType examinationType,
}) {
  var response = '';
  switch (examinationType) {
    case ExaminationType.COLONOSCOPY:
      response = context.l10n.colonoscopy_question_highlight;
      break;
    case ExaminationType.DENTIST:
      response = context.l10n.dentist_question_highlight;
      break;
    case ExaminationType.DERMATOLOGIST:
      response = context.l10n.dermatology_question_highlight;
      break;
    case ExaminationType.GENERAL_PRACTITIONER:
      response = context.l10n.practitioner_question_highlight;
      break;
    case ExaminationType.GYNECOLOGIST:
      response = context.l10n.gynecology_question_highlight;
      break;
    case ExaminationType.MAMMOGRAM:
      response = context.l10n.mammogram_question_highlight;
      break;
    case ExaminationType.OPHTHALMOLOGIST:
      response = context.l10n.oculist_question_highlight;
      break;
    case ExaminationType.TOKS:
      // TODO: Handle this case.
      break;
    case ExaminationType.ULTRASOUND_BREAST:
      // TODO: Handle this case.
      break;
    case ExaminationType.UROLOGIST:
      response = context.l10n.urology_question_highlight;
      break;
    case ExaminationType.VENEREAL_DISEASES:
      // TODO: Handle this case.
      break;
  }
  return response;
}

enum Casus { nomativ, genitiv, dativ }

String examinationTypeCasus(
  BuildContext context, {
  required ExaminationType examinationType,
  required Casus casus,
}) {
  final l10n = context.l10n;
  switch (examinationType) {
    case ExaminationType.COLONOSCOPY:
      if (casus == Casus.nomativ) return l10n.colonoscopy_nomativ;
      if (casus == Casus.genitiv) return l10n.colonoscopy_genitiv;
      if (casus == Casus.dativ) return l10n.colonoscopy_dativ;
      return '${ExaminationType.COLONOSCOPY} unkown casus';
    case ExaminationType.DENTIST:
      if (casus == Casus.nomativ) return l10n.dentist_nomativ;
      if (casus == Casus.genitiv) return l10n.dentist_genitiv;
      if (casus == Casus.dativ) return l10n.dentist_dativ;
      return '${ExaminationType.DENTIST} unkown casus';
    case ExaminationType.DERMATOLOGIST:
      if (casus == Casus.nomativ) return l10n.dermatologist_nomativ;
      if (casus == Casus.genitiv) return l10n.dermatologist_genitiv;
      if (casus == Casus.dativ) return l10n.dermatologist_dativ;
      return '${ExaminationType.DERMATOLOGIST} unkown casus';
    case ExaminationType.GENERAL_PRACTITIONER:
      if (casus == Casus.nomativ) return l10n.generalPractitioner_nomativ;
      if (casus == Casus.genitiv) return l10n.generalPractitioner_genitiv;
      if (casus == Casus.dativ) return l10n.generalPractitioner_dativ;
      return '${ExaminationType.GENERAL_PRACTITIONER} unkown casus';
    case ExaminationType.GYNECOLOGIST:
      if (casus == Casus.nomativ) return l10n.gynecologist_nomativ;
      if (casus == Casus.genitiv) return l10n.gynecologist_genitiv;
      if (casus == Casus.dativ) return l10n.gynecologist_dativ;
      return '${ExaminationType.GYNECOLOGIST} unkown casus';
    case ExaminationType.MAMMOGRAM:
      if (casus == Casus.nomativ) return l10n.mammogram_nomativ;
      if (casus == Casus.genitiv) return l10n.mammogram_genitiv;
      if (casus == Casus.dativ) return l10n.mammogram_dativ;
      return '${ExaminationType.MAMMOGRAM} unkown casus';
    case ExaminationType.OPHTHALMOLOGIST:
      if (casus == Casus.nomativ) return l10n.ophthalmologist_nomativ;
      if (casus == Casus.genitiv) return l10n.ophthalmologist_genitiv;
      if (casus == Casus.dativ) return l10n.ophthalmologist_dativ;
      return '${ExaminationType.OPHTHALMOLOGIST} unkown casus';
    case ExaminationType.TOKS:
      if (casus == Casus.nomativ) return l10n.toks_nomativ;
      if (casus == Casus.genitiv) return l10n.toks_genitiv;
      if (casus == Casus.dativ) return l10n.toks_dativ;
      return '${ExaminationType.TOKS} unkown casus';
    case ExaminationType.ULTRASOUND_BREAST:
      if (casus == Casus.nomativ) return l10n.ultrasoundBreast_nomativ;
      if (casus == Casus.genitiv) return l10n.ultrasoundBreast_genitiv;
      if (casus == Casus.dativ) return l10n.ultrasoundBreast_dativ;
      return '${ExaminationType.ULTRASOUND_BREAST} unkown casus';
    case ExaminationType.UROLOGIST:
      if (casus == Casus.nomativ) return l10n.urologist_nomativ;
      if (casus == Casus.genitiv) return l10n.urologist_genitiv;
      if (casus == Casus.dativ) return l10n.urologist_dativ;
      return '${ExaminationType.UROLOGIST} unkown casus';
    case ExaminationType.VENEREAL_DISEASES:
      // TODO: Handle this case.
      return '';
  }
  return '${examinationType.name} unkown casus';
}

String selfExaminationTypeCasus(
  BuildContext context, {
  required SelfExaminationType selfExaminationType,
  required Casus casus,
}) {
  final l10n = context.l10n;
  switch (selfExaminationType) {
    case SelfExaminationType.BREAST:
      if (casus == Casus.nomativ) return l10n.breastSelf_nomativ;
      if (casus == Casus.genitiv) return l10n.breastSelf_genitiv;
      if (casus == Casus.dativ) return l10n.breastSelf_dativ;
      return '${SelfExaminationType.BREAST} unkown casus';
    case SelfExaminationType.TESTICULAR:
      if (casus == Casus.nomativ) return l10n.testicularSelf_nomativ;
      if (casus == Casus.genitiv) return l10n.testicularSelf_genitiv;
      if (casus == Casus.dativ) return l10n.testicularSelf_dativ;
      return '${SelfExaminationType.TESTICULAR} unkown casus';
  }
  return '${selfExaminationType.name} unkown casus';
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);

  /// .inDays does not work here (https://stackoverflow.com/questions/52713115/flutter-find-the-number-of-days-between-two-dates/67679455#67679455)
  return (to.difference(from).inHours / 24).round();
}

double upperArcProgress(CategorizedExamination examination) {
  final nextVisit = examination.examination.plannedDate;
  final category = examination.category;
  final interval = examination.examination.intervalYears;
  if ([
        const ExaminationCategory.scheduled(),
        const ExaminationCategory.scheduledSoonOrOverdue(),
      ].contains(category) &&
      nextVisit != null) {
    final totalDays = daysBetween(
      DateTime(nextVisit.year - interval, nextVisit.month),
      nextVisit,
    );
    final sinceScheduledDays = daysBetween(
      DateTime(nextVisit.year - interval, nextVisit.month),
      DateTime.now(),
    );
    return (sinceScheduledDays / totalDays).clamp(0, 1);
  } else if (category == const ExaminationCategory.waiting()) {
    return 1;
  }
  return 0;
}

double lowerArcProgress(CategorizedExamination examination) {
  final nextVisit = examination.examination.plannedDate;
  final lastVisit = examination.examination.lastConfirmedDate;
  final category = examination.category;
  final interval = examination.examination.intervalYears;

  if (category == const ExaminationCategory.scheduledSoonOrOverdue() && nextVisit != null) {
    final intervalDays = daysBetween(
      nextVisit,
      DateTime(nextVisit.year + interval, nextVisit.month),
    );
    final afterScheduledDays = intervalDays -
        daysBetween(
          DateTime.now(),
          DateTime(nextVisit.year + interval, nextVisit.month),
        );
    return (afterScheduledDays / intervalDays).clamp(0, 1);
  } else if (category == const ExaminationCategory.waiting() && lastVisit != null) {
    final intervalDays = daysBetween(
      DateTime(lastVisit.year, lastVisit.month),
      DateTime(lastVisit.year + interval, lastVisit.month),
    );
    final afterLastVisitDays = daysBetween(
      DateTime(lastVisit.year, lastVisit.month),
      DateTime.now(),
    );
    return (afterLastVisitDays / intervalDays).clamp(0, 1);
  }
  return 0;
}

bool isOverdue(CategorizedExamination examination) {
  final nextVisit = examination.examination.plannedDate;
  if (nextVisit != null) {
    return examination.category == const ExaminationCategory.scheduledSoonOrOverdue() &&
        DateTime.now().isAfter(nextVisit);
  }
  return false;
}

Color progressBarColor(ExaminationCategory category) {
  if ([
    const ExaminationCategory.scheduled(),
    const ExaminationCategory.scheduledSoonOrOverdue(),
  ].contains(category)) {
    return LoonoColors.primaryEnabled;
  }
  return LoonoColors.greenSuccess;
}

Widget progressBarLeftDot(ExaminationCategory category) {
  var color = LoonoColors.red;
  if ([
    const ExaminationCategory.scheduledSoonOrOverdue(),
    const ExaminationCategory.scheduled(),
  ].contains(category)) {
    color = LoonoColors.greenSuccess;
  } else if (category == const ExaminationCategory.waiting()) {
    color = LoonoColors.primary;
  }
  return Align(
    alignment: Alignment.centerLeft,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: color,
        width: 16,
        height: 16,
        child: Visibility(
          visible: [
            const ExaminationCategory.scheduledSoonOrOverdue(),
            const ExaminationCategory.scheduled(),
          ].contains(category),
          child: const Icon(
            Icons.done,
            size: 14,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget progressBarRightDot(ExaminationCategory category) {
  var color = LoonoColors.primary;
  IconData? icon;
  if (category == const ExaminationCategory.scheduledSoonOrOverdue()) {
    color = LoonoColors.red;
    icon = Icons.priority_high;
  } else if (category == const ExaminationCategory.waiting()) {
    color = LoonoColors.greenSuccess;
    icon = Icons.done;
  }
  return Align(
    alignment: Alignment.centerRight,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: color,
        width: 16,
        height: 16,
        child: icon != null
            ? Icon(
                icon,
                size: 14,
                color: Colors.white,
              )
            : const SizedBox(),
      ),
    ),
  );
}
