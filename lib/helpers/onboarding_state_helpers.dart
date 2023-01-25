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

  ExaminationQuestionnaire? get gynecologistQuestionnaire => firstWhereOrNull(
        (questionnaire) => questionnaire.type == ExaminationType.GYNECOLOGIST,
      );

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

/// According to onboarding flow diagram, on iOS, there should be displayed [AllowNotificationsScreen]
/// if the user has not specified date in any onboarding form.
// Future<void> pushNotificationOrPreAuthMainScreen({bool fromOnboarding = false}) async {
//   final shouldDisplayNotificationScreen = await _shouldAskForNotification();
//   final globalRouter = registry.get<AppRouter>();

//   switch (fromOnboarding) {
//     case true:
//       final preAuthMainRoute = PreAuthMainRoute();
//       if (shouldDisplayNotificationScreen) {
//         await globalRouter.pushAll([
//           preAuthMainRoute,
//           AllowNotificationsRoute(
//             onSkipTap: () => globalRouter.push(preAuthMainRoute),
//             onContinueTap: () async {
//               await registry.get<NotificationService>().promptPermissions();
//               await globalRouter.push(preAuthMainRoute);
//             },
//           ),
//         ]);
//       } else {
//         await globalRouter.push(preAuthMainRoute);
//       }
//       break;
//     case false:
//       if (shouldDisplayNotificationScreen) {
//         await globalRouter.push(
//           AllowNotificationsRoute(
//             onSkipTap: globalRouter.pop,
//             onContinueTap: () async {
//               await registry.get<NotificationService>().promptPermissions();
//               await globalRouter.pop();
//             },
//           ),
//         );
//       }
//       break;
//   }
// }

// Future<bool> _shouldAskForNotification() async {
//   final userRepository = registry.get<UserRepository>();
//   final permissionRequested = await userRepository.requestedNotificationPermission();
//   if (!Platform.isIOS) return false;
//   final permissionStatus = await Permission.notification.status;
//   if (permissionStatus.isGranted) return false;
//   if (!permissionRequested) return true;
//   return false;
// }
