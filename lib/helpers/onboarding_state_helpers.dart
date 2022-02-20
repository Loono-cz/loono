// ignore_for_file: constant_identifier_names
import 'package:collection/collection.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono_api/loono_api.dart';

const LAST_ONBOARDING_QUESTIONNAIRE = ExaminationType.DENTIST;

enum OnboardingProgressStatus { NOT_STARTED, IN_PROGRESS, DONE }

enum CcaDoctorVisit { inLastXYears, moreThanXYearsOrIdk }

extension OnboardingExaminationQuestionnairesExt on List<ExaminationQuestionnaire> {
  ExaminationQuestionnaire? get lastOnboardingQuestionnaire =>
      firstWhereOrNull((questionnaire) => questionnaire.type == LAST_ONBOARDING_QUESTIONNAIRE);

  ExaminationQuestionnaire? get generalPractitionerQuestionnaire => firstWhereOrNull(
        (questionnaire) => questionnaire.type == ExaminationType.GENERAL_PRACTITIONER,
      );

  ExaminationQuestionnaire? get gynecologistQuestionnaire =>
      firstWhereOrNull((questionnaire) => questionnaire.type == ExaminationType.GYNECOLOGIST);

  ExaminationQuestionnaire? get dentistQuestionnaire =>
      firstWhereOrNull((questionnaire) => questionnaire.type == ExaminationType.DENTIST);

  OnboardingProgressStatus get onboardingStatusState {
    final lastOnboardingQuestionnaire = this.lastOnboardingQuestionnaire;

    if (lastOnboardingQuestionnaire == null) {
      return OnboardingProgressStatus.NOT_STARTED;
    }

    if (lastOnboardingQuestionnaire.status == ExaminationStatus.UNKNOWN ||
        lastOnboardingQuestionnaire.isDatePickerFormFilled) {
      return OnboardingProgressStatus.DONE;
    }

    return OnboardingProgressStatus.IN_PROGRESS;
  }

  bool get isOnboardingDone => onboardingStatusState == OnboardingProgressStatus.DONE;

  bool get isOnboardingInProgress => onboardingStatusState == OnboardingProgressStatus.IN_PROGRESS;

  double getOnboardingProgress(User? user) {
    var currentProgress = 0.0;
    if (isEmpty || user == null) return currentProgress;
    const max = 1.0;
    var onboardingFormsCount = 4; // sex, birthdate, general_practitioner, (gynecologist), dentist
    double getStepProgress() => max / onboardingFormsCount;

    if (user.sex != null) {
      if (user.sex == Sex.FEMALE) onboardingFormsCount++;
      currentProgress += getStepProgress();
    }
    if (user.dateOfBirth != null) currentProgress += getStepProgress();
    if (generalPractitionerQuestionnaire?.ccaDoctorVisit != null) {
      currentProgress += getStepProgress();
    }
    if (gynecologistQuestionnaire?.ccaDoctorVisit != null) {
      currentProgress += getStepProgress();
    }
    if (dentistQuestionnaire?.ccaDoctorVisit != null) {
      currentProgress += getStepProgress();
    }
    return currentProgress;
  }
}

extension OnboardingExaminationQuestionnaireExt on ExaminationQuestionnaire {
  CcaDoctorVisit? get ccaDoctorVisit {
    if (status == ExaminationStatus.CONFIRMED) {
      return CcaDoctorVisit.inLastXYears;
    }

    if (status == ExaminationStatus.UNKNOWN) {
      return CcaDoctorVisit.moreThanXYearsOrIdk;
    }

    return null;
  }

  bool get isDatePickerFormFilled {
    final lastVisitDate = date;

    if (lastVisitDate != null) {
      return true;
    }

    return false;
  }
}
