// ignore_for_file: constant_identifier_names
import 'package:collection/collection.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono_api/loono_api.dart';

const LAST_ONBOARDING_QUESTIONNAIRE = ExaminationTypeEnum.DENTIST;

enum OnboardingProgressStatus { NOT_STARTED, IN_PROGRESS, DONE }

enum CcaDoctorVisit { inLastXYears, moreThanXYearsOrIdk }

extension OnboardingExaminationQuestionnairesExt on List<ExaminationQuestionnaire> {
  ExaminationQuestionnaire? get lastOnboardingQuestionnaire =>
      firstWhereOrNull((questionnaire) => questionnaire.type == LAST_ONBOARDING_QUESTIONNAIRE);

  ExaminationQuestionnaire? get generalPractitionerQuestionnaire => firstWhereOrNull(
        (questionnaire) => questionnaire.type == ExaminationTypeEnum.GENERAL_PRACTITIONER,
      );

  ExaminationQuestionnaire? get gynecologistQuestionnaire =>
      firstWhereOrNull((questionnaire) => questionnaire.type == ExaminationTypeEnum.GYNECOLOGIST);

  ExaminationQuestionnaire? get dentistQuestionnaire =>
      firstWhereOrNull((questionnaire) => questionnaire.type == ExaminationTypeEnum.DENTIST);

  OnboardingProgressStatus get onboardingStatusState {
    final lastOnboardingQuestionnaire = this.lastOnboardingQuestionnaire;

    if (lastOnboardingQuestionnaire == null) {
      return OnboardingProgressStatus.NOT_STARTED;
    }

    final lastVisitDate = lastOnboardingQuestionnaire.date;
    if (lastVisitDate != null && lastOnboardingQuestionnaire.firstExam != null) {
      return OnboardingProgressStatus.DONE;
    }

    if (lastOnboardingQuestionnaire.status == ExaminationStatus.UNKNOWN) {
      return OnboardingProgressStatus.DONE;
    }

    return OnboardingProgressStatus.IN_PROGRESS;
  }

  bool get isOnboardingDone => onboardingStatusState == OnboardingProgressStatus.DONE;

  bool get isOnboardingInProgress => onboardingStatusState == OnboardingProgressStatus.IN_PROGRESS;
}

extension OnboardingExaminationQuestionnaireExt on ExaminationQuestionnaire {
  CcaDoctorVisit? get ccaDoctorVisit {
    final lastVisitDate = date;

    if (lastVisitDate != null) {
      return CcaDoctorVisit.inLastXYears;
    }

    if (status == ExaminationStatus.UNKNOWN) {
      return CcaDoctorVisit.moreThanXYearsOrIdk;
    }

    return null;
  }

  bool get isDatePickerFormFilled {
    final lastVisitDate = date;

    if (lastVisitDate != null && firstExam != null) {
      return true;
    }

    return false;
  }
}
