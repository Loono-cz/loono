import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_helpers.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono_api/loono_api.dart';

TextStyle earlyOrderStyles(CategorizedExamination examination) {
  var color = LoonoColors.black;
  var weight = FontWeight.w400;
  final nextVisit = examination.examination.plannedDate?.toLocal();

  if (nextVisit != null &&
      [
        const ExaminationCategory.scheduled(),
        const ExaminationCategory.scheduledSoonOrOverdue(),
      ].contains(examination.category) &&
      DateTime.now().isBefore(nextVisit)) {
    color = LoonoColors.greenSuccess;
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
  var color = LoonoColors.greenSuccess;
  var weight = FontWeight.w400;

  if (category == const ExaminationCategory.scheduledSoonOrOverdue()) {
    color = LoonoColors.red;
    weight = FontWeight.w700;
  } else if ([
    const ExaminationCategory.scheduled(),
    const ExaminationCategory.unknownLastVisit(),
    const ExaminationCategory.newToSchedule(),
  ].contains(category)) {
    color = LoonoColors.black;
  }
  return LoonoFonts.cardTitle.copyWith(color: color, fontWeight: weight);
}

String czechPreposition(
  BuildContext context, {
  required ExaminationType examinationType,
}) {
  if ([
    ExaminationType.COLONOSCOPY,
    ExaminationType.MAMMOGRAM,
  ].contains(examinationType)) {
    return 'na';
  } else {
    return 'u';
  }
}

String czechPrepositionDativ(
  BuildContext context, {
  required ExaminationType examinationType,
}) {
  var res = '';
  switch (examinationType) {
    case ExaminationType.COLONOSCOPY:
      res = 'na';
      break;
    case ExaminationType.DENTIST:
      res = 'k';
      break;
    case ExaminationType.DERMATOLOGIST:
      res = 'k';
      break;
    case ExaminationType.GENERAL_PRACTITIONER:
      res = 'k';
      break;
    case ExaminationType.GYNECOLOGIST:
      res = 'ke';
      break;
    case ExaminationType.MAMMOGRAM:
      res = 'na';
      break;
    case ExaminationType.OPHTHALMOLOGIST:
      res = 'k';
      break;
    case ExaminationType.ULTRASOUND_BREAST:
      res = 'na';
      break;
    case ExaminationType.UROLOGIST:
      res = 'k';
      break;
    case ExaminationType.ALLERGOLOGY:
      res = 'k';
      break;
    case ExaminationType.CARDIOLOGY:
      res = 'na';
      break;
    case ExaminationType.ENDOCRINOLOGY_AND_HORMONES:
      res = 'na';
      break;
    case ExaminationType.ERGOTHERAPY:
      res = 'na';
      break;
    case ExaminationType.GASTROENTEROLOGY:
      res = 'k';
      break;
    case ExaminationType.GENETICS:
      res = 'na';
      break;
    case ExaminationType.HEMATOLOGY:
      res = 'k';
      break;
    case ExaminationType.IMMUNOLOGY:
      res = 'na';
      break;
    case ExaminationType.INTERN:
      res = 'na';
      break;
    case ExaminationType.NEPHROLOGY:
      res = 'na';
      break;
    case ExaminationType.NEUROLOGY:
      res = 'k';
      break;
    case ExaminationType.NUTRITION:
      res = 'k';
      break;
    case ExaminationType.ONCOLOGY:
      res = 'na';
      break;
    case ExaminationType.ORL:
      res = 'k';
      break;
    case ExaminationType.ORTHODONTICS:
      res = 'k';
      break;
    case ExaminationType.ORTHOPEDICS:
      res = 'k';
      break;
    case ExaminationType.OTHER:
      res = 'k';
      break;
    case ExaminationType.PALLIATIVE_MEDICINE:
      res = 'na';
      break;
    case ExaminationType.PEDIATRICIAN:
      res = 'k';
      break;
    case ExaminationType.PHONIATRICS:
      res = 'k';
      break;
    case ExaminationType.PHYSIOTHERAPY:
      res = 'na';
      break;
    case ExaminationType.PSYCHIATRY:
      res = 'k';
      break;
    case ExaminationType.PSYCHOLOGY:
      res = 'k';
      break;
    case ExaminationType.PULMONARY:
      res = 'na';
      break;
    case ExaminationType.REHABILITATION:
      res = 'na';
      break;
    case ExaminationType.REPRODUCTIVE_MEDICINE:
      res = 'na';
      break;
    case ExaminationType.RHEUMATOLOGY:
      res = 'na';
      break;
    case ExaminationType.SEXOLOGY:
      res = 'k';
      break;
    case ExaminationType.SPEECH_THERAPIST:
      res = 'k';
      break;
    case ExaminationType.SPORTS_MEDICINE:
      res = 'na';
      break;
    case ExaminationType.SURGERY:
      res = 'na';
      break;
    case ExaminationType.VASCULAR:
      res = 'na';
      break;
    case ExaminationType.DENTAL_HYGIENE:
      res = 'na';
      break;
  }
  return res;
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
    case ExaminationType.ULTRASOUND_BREAST:
      response = context.l10n.ultrasound_breast_question_highlight;
      break;
    case ExaminationType.UROLOGIST:
      response = context.l10n.urology_question_highlight;
      break;
    default:
      return '';
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
    case ExaminationType.PHYSIOTHERAPY:
      if (casus == Casus.nomativ) return l10n.physiotherapy_nomativ;
      if (casus == Casus.genitiv) return l10n.physiotherapy_genitiv;
      if (casus == Casus.dativ) return l10n.physiotherapy_dativ;
      return '${ExaminationType.PHYSIOTHERAPY} unkown casus';
    case ExaminationType.PEDIATRICIAN:
      if (casus == Casus.nomativ) return l10n.pediatrician_nomativ;
      if (casus == Casus.genitiv) return l10n.pediatrician_genitiv;
      if (casus == Casus.dativ) return l10n.pediatrician_dativ;
      return '${ExaminationType.PEDIATRICIAN} unkown casus';
    case ExaminationType.INTERN:
      if (casus == Casus.nomativ) return l10n.intern_nomativ;
      if (casus == Casus.genitiv) return l10n.intern_genitiv;
      if (casus == Casus.dativ) return l10n.intern_dativ;
      return '${ExaminationType.PEDIATRICIAN} unkown casus';
    case ExaminationType.ALLERGOLOGY:
      if (casus == Casus.nomativ) return l10n.allergology_nomativ;
      if (casus == Casus.genitiv) return l10n.allergology_genitiv;
      if (casus == Casus.dativ) return l10n.allergology_dativ;
      return '${ExaminationType.ALLERGOLOGY} unkown casus';
    case ExaminationType.CARDIOLOGY:
      if (casus == Casus.nomativ) return l10n.cardiology_nomativ;
      if (casus == Casus.genitiv) return l10n.cardiology_genitiv;
      if (casus == Casus.dativ) return l10n.cardiology_dativ;
      return '${ExaminationType.CARDIOLOGY} unkown casus';
    case ExaminationType.ENDOCRINOLOGY_AND_HORMONES:
      if (casus == Casus.nomativ) {
        return l10n.endocrinology_and_hormones_nomativ;
      }
      if (casus == Casus.genitiv) {
        return l10n.endocrinology_and_hormones_genitiv;
      }
      if (casus == Casus.dativ) return l10n.endocrinology_and_hormones_dativ;
      return '${ExaminationType.ENDOCRINOLOGY_AND_HORMONES} unkown casus';
    case ExaminationType.ERGOTHERAPY:
      if (casus == Casus.nomativ) return l10n.ergotherapy_nomativ;
      if (casus == Casus.genitiv) return l10n.ergotherapy_genitiv;
      if (casus == Casus.dativ) return l10n.ergotherapy_dativ;
      return '${ExaminationType.ERGOTHERAPY} unkown casus';
    case ExaminationType.GASTROENTEROLOGY:
      if (casus == Casus.nomativ) return l10n.gastroenterology_nomativ;
      if (casus == Casus.genitiv) return l10n.gastroenterology_genitiv;
      if (casus == Casus.dativ) return l10n.gastroenterology_dativ;
      return '${ExaminationType.GASTROENTEROLOGY} unkown casus';
    case ExaminationType.GENETICS:
      if (casus == Casus.nomativ) return l10n.genetics_nomativ;
      if (casus == Casus.genitiv) return l10n.genetics_genitiv;
      if (casus == Casus.dativ) return l10n.genetics_dativ;
      return '${ExaminationType.GENETICS} unkown casus';
    case ExaminationType.HEMATOLOGY:
      if (casus == Casus.nomativ) return l10n.hematology_nomativ;
      if (casus == Casus.genitiv) return l10n.hematology_genitiv;
      if (casus == Casus.dativ) return l10n.hematology_dativ;
      return '${ExaminationType.HEMATOLOGY} unkown casus';
    case ExaminationType.IMMUNOLOGY:
      if (casus == Casus.nomativ) return l10n.immunology_nomativ;
      if (casus == Casus.genitiv) return l10n.immunology_genitiv;
      if (casus == Casus.dativ) return l10n.immunology_dativ;
      return '${ExaminationType.IMMUNOLOGY} unkown casus';
    case ExaminationType.NEPHROLOGY:
      if (casus == Casus.nomativ) return l10n.nephrology_nomativ;
      if (casus == Casus.genitiv) return l10n.nephrology_genitiv;
      if (casus == Casus.dativ) return l10n.nephrology_dativ;
      return '${ExaminationType.NEPHROLOGY} unkown casus';
    case ExaminationType.NEUROLOGY:
      if (casus == Casus.nomativ) return l10n.neurology_nomativ;
      if (casus == Casus.genitiv) return l10n.neurology_genitiv;
      if (casus == Casus.dativ) return l10n.neurology_dativ;
      return '${ExaminationType.NEPHROLOGY} unkown casus';
    case ExaminationType.NUTRITION:
      if (casus == Casus.nomativ) return l10n.nutrition_nomativ;
      if (casus == Casus.genitiv) return l10n.nutrition_genitiv;
      if (casus == Casus.dativ) return l10n.nutrition_dativ;
      return '${ExaminationType.NUTRITION} unkown casus';
    case ExaminationType.ONCOLOGY:
      if (casus == Casus.nomativ) return l10n.oncology_nomativ;
      if (casus == Casus.genitiv) return l10n.oncology_genitiv;
      if (casus == Casus.dativ) return l10n.oncology_dativ;
      return '${ExaminationType.ONCOLOGY} unkown casus';
    case ExaminationType.ORL:
      if (casus == Casus.nomativ) return l10n.orl_nomativ;
      if (casus == Casus.genitiv) return l10n.orl_genitiv;
      if (casus == Casus.dativ) return l10n.orl_dativ;
      return '${ExaminationType.ORL} unkown casus';
    case ExaminationType.ORTHODONTICS:
      if (casus == Casus.nomativ) return l10n.orthodontics_nomativ;
      if (casus == Casus.genitiv) return l10n.orthodontics_genitiv;
      if (casus == Casus.dativ) return l10n.orthodontics_dativ;
      return '${ExaminationType.ORTHODONTICS} unkown casus';
    case ExaminationType.ORTHOPEDICS:
      if (casus == Casus.nomativ) return l10n.orthopaedics_nomativ;
      if (casus == Casus.genitiv) return l10n.orthopaedics_genitiv;
      if (casus == Casus.dativ) return l10n.orthopaedics_dativ;
      return '${ExaminationType.ORTHOPEDICS} unkown casus';
    case ExaminationType.OTHER:
      if (casus == Casus.nomativ) return l10n.other_nomativ;
      if (casus == Casus.genitiv) return l10n.other_genitiv;
      if (casus == Casus.dativ) return l10n.other_dativ;
      return '${ExaminationType.OTHER} unkown casus';
    case ExaminationType.PALLIATIVE_MEDICINE:
      if (casus == Casus.nomativ) return l10n.palliative_medicine_nomativ;
      if (casus == Casus.genitiv) return l10n.palliative_medicine_genitiv;
      if (casus == Casus.dativ) return l10n.palliative_medicine_dativ;
      return '${ExaminationType.PALLIATIVE_MEDICINE} unkown casus';
    case ExaminationType.PHONIATRICS:
      if (casus == Casus.nomativ) return l10n.phoniatrics_nomativ;
      if (casus == Casus.genitiv) return l10n.phoniatrics_genitiv;
      if (casus == Casus.dativ) return l10n.phoniatrics_dativ;
      return '${ExaminationType.PHONIATRICS} unkown casus';
    case ExaminationType.PSYCHIATRY:
      if (casus == Casus.nomativ) return l10n.psychiatry_nomativ;
      if (casus == Casus.genitiv) return l10n.psychiatry_genitiv;
      if (casus == Casus.dativ) return l10n.psychiatry_dativ;
      return '${ExaminationType.PSYCHIATRY} unkown casus';
    case ExaminationType.PSYCHOLOGY:
      if (casus == Casus.nomativ) return l10n.psychology_nomativ;
      if (casus == Casus.genitiv) return l10n.psychology_genitiv;
      if (casus == Casus.dativ) return l10n.psychology_dativ;
      return '${ExaminationType.PSYCHOLOGY} unkown casus';
    case ExaminationType.PULMONARY:
      if (casus == Casus.nomativ) return l10n.pulmonary_nomativ;
      if (casus == Casus.genitiv) return l10n.pulmonary_genitiv;
      if (casus == Casus.dativ) return l10n.pulmonary_dativ;
      return '${ExaminationType.PULMONARY} unkown casus';
    case ExaminationType.REHABILITATION:
      if (casus == Casus.nomativ) return l10n.rehabilitation_nomativ;
      if (casus == Casus.genitiv) return l10n.rehabilitation_genitiv;
      if (casus == Casus.dativ) return l10n.rehabilitation_dativ;
      return '${ExaminationType.REHABILITATION} unkown casus';
    case ExaminationType.REPRODUCTIVE_MEDICINE:
      if (casus == Casus.nomativ) return l10n.reproductive_medicine_nomativ;
      if (casus == Casus.genitiv) return l10n.reproductive_medicine_genitiv;
      if (casus == Casus.dativ) return l10n.reproductive_medicine_dativ;
      return '${ExaminationType.REPRODUCTIVE_MEDICINE} unkown casus';
    case ExaminationType.RHEUMATOLOGY:
      if (casus == Casus.nomativ) return l10n.rheumatology_nomativ;
      if (casus == Casus.genitiv) return l10n.rheumatology_genitiv;
      if (casus == Casus.dativ) return l10n.reproductive_medicine_dativ;
      return '${ExaminationType.RHEUMATOLOGY} unkown casus';
    case ExaminationType.SEXOLOGY:
      if (casus == Casus.nomativ) return l10n.sexology_nomativ;
      if (casus == Casus.genitiv) return l10n.sexology_genitiv;
      if (casus == Casus.dativ) return l10n.sexology_dativ;
      return '${ExaminationType.SEXOLOGY} unkown casus';
    case ExaminationType.SPEECH_THERAPIST:
      if (casus == Casus.nomativ) return l10n.speech_therapist_nomativ;
      if (casus == Casus.genitiv) return l10n.speech_therapist_genitiv;
      if (casus == Casus.dativ) return l10n.speech_therapist_dativ;
      return '${ExaminationType.SPEECH_THERAPIST} unkown casus';
    case ExaminationType.SPORTS_MEDICINE:
      if (casus == Casus.nomativ) return l10n.sports_medicine_nomativ;
      if (casus == Casus.genitiv) return l10n.sports_medicine_genitiv;
      if (casus == Casus.dativ) return l10n.sports_medicine_dativ;
      return '${ExaminationType.SPORTS_MEDICINE} unkown casus';
    case ExaminationType.SURGERY:
      if (casus == Casus.nomativ) return l10n.surgery_nomativ;
      if (casus == Casus.genitiv) return l10n.surgery_genitiv;
      if (casus == Casus.dativ) return l10n.surgery_dativ;
      return '${ExaminationType.SURGERY} unkown casus';
    case ExaminationType.VASCULAR:
      if (casus == Casus.nomativ) return l10n.vascular_nomativ;
      if (casus == Casus.genitiv) return l10n.vascular_genitiv;
      if (casus == Casus.dativ) return l10n.vascular_dativ;
      return '${ExaminationType.VASCULAR} unkown casus';
    case ExaminationType.DENTAL_HYGIENE:
      if (casus == Casus.nomativ) return l10n.dental_hygiene_nomativ;
      if (casus == Casus.genitiv) return l10n.dental_hygiene_genitiv;
      if (casus == Casus.dativ) return l10n.dental_hygiene_dativ;
      return '${ExaminationType.DENTAL_HYGIENE} unkown casus';
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
    case SelfExaminationType.SKIN:
      if (casus == Casus.nomativ) return l10n.skinSelf_nomativ;
      if (casus == Casus.genitiv) return l10n.skinSelf_genitiv;
      if (casus == Casus.dativ) return l10n.skinSelf_dativ;
      return '${SelfExaminationType.SKIN} unkown casus';
  }
  return '${selfExaminationType.name} unkown casus';
}

double upperArcProgress(CategorizedExamination examination) {
  final nextVisit = examination.examination.plannedDate?.toLocal();
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
  } else if (category == const ExaminationCategory.waiting() ||
      _newToScheduleFullProgressBar(examination)) {
    return 1;
  }
  return 0;
}

double lowerArcProgress(CategorizedExamination examination) {
  final nextVisit = examination.examination.plannedDate?.toLocal();
  final lastVisit = examination.examination.lastConfirmedDate?.toLocal();
  final category = examination.category;
  final intervalMonths =
      examination.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM
          ? examination.examination.customInterval!
          : examination.examination.intervalYears * 12;

  if (category == const ExaminationCategory.scheduledSoonOrOverdue() && nextVisit != null) {
    final intervalDays = daysBetween(
      nextVisit,
      DateTime(nextVisit.year, nextVisit.month + intervalMonths),
    );
    final afterScheduledDays = intervalDays -
        daysBetween(
          DateTime.now(),
          DateTime(nextVisit.year, nextVisit.month + intervalMonths),
        );
    return (afterScheduledDays / intervalDays).clamp(0, 1);
  } else if ((category == const ExaminationCategory.waiting() ||
          _newToScheduleFullProgressBar(examination)) &&
      lastVisit != null) {
    final intervalDays = daysBetween(
      DateTime(lastVisit.year, lastVisit.month),
      DateTime(lastVisit.year, lastVisit.month + intervalMonths),
    );
    final afterLastVisitDays = daysBetween(
      DateTime(lastVisit.year, lastVisit.month),
      DateTime.now(),
    );
    return (afterLastVisitDays / intervalDays).clamp(0, 1);
  }
  return 0;
}

bool _newToScheduleFullProgressBar(CategorizedExamination exam) {
  return exam.examination.lastConfirmedDate != null &&
      exam.category == const ExaminationCategory.newToSchedule();
}

bool isOverdue(CategorizedExamination examination) {
  final nextVisit = examination.examination.plannedDate?.toLocal();
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

double selfExaminationProgress(Date? plannedDate) {
  if (plannedDate?.toDateTime() != null) {
    final date = plannedDate?.toDateTime() as DateTime;
    final planedDate = date.millisecondsSinceEpoch;
    final startDate = DateTime(date.year, date.month - 1, date.day).millisecondsSinceEpoch;
    final todayDate = DateTime.now().millisecondsSinceEpoch;
    final total = planedDate - startDate;
    final current = todayDate - startDate;
    final percentage = current / total;
    return percentage.clamp(0, 1);
  } else {
    return 0;
  }
}
