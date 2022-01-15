import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_status.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';

TextStyle earlyOrderStyles(CategorizedExamination examination) {
  var color = LoonoColors.black;
  var weight = FontWeight.w400;
  final nextVisit = examination.examination.nextVisitDate;
  if (nextVisit != null && DateTime.now().isBefore(nextVisit)) {
    color = LoonoColors.green;
  } else if (nextVisit == null || examination.status == const ExaminationStatus.newToSchedule()) {
    color = LoonoColors.red;
    weight = FontWeight.w700;
  }
  return LoonoFonts.cardTitle.copyWith(color: color, fontWeight: weight);
}

TextStyle preventiveInspectionStyles(CategorizedExamination examination) {
  var color = LoonoColors.green;
  var weight = FontWeight.w400;
  final now = DateTime.now();
  final nextVisit = examination.examination.nextVisitDate;
  if (nextVisit != null && DateTime.now().isAfter(nextVisit)) {
    color = LoonoColors.red;
    weight = FontWeight.w700;
  } else if ((nextVisit != null && now.isBefore(nextVisit)) || nextVisit == null) {
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

String procedureQuestionTitle(BuildContext context, {required ExaminationType examinationType}) {
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
    case ExaminationType.TESTICULAR_SELF:
      // TODO: Handle this case.
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
    case ExaminationType.BREAST_SELF:
      // TODO: Handle this case.
      break;
  }
  return response;
}
