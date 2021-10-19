import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_types.dart';

enum OnboardingProgressStatus { welcome, intro, questionnaire }

enum NotificationPermissionState { notRequested, requested }

class OnboardingStateService extends ChangeNotifier {
  OnboardingProgressStatus _onboardingProgressStatus = OnboardingProgressStatus.welcome;

  final _obtainedExaminationAchievements = <ExaminationType>{};

  final _universalDoctorDateSkips = <ExaminationType>{};

  // on Android notifications are allowed by default
  NotificationPermissionState _notificationPermissionState = Platform.isIOS
      ? NotificationPermissionState.notRequested
      : NotificationPermissionState.requested;

  bool get hasWelcomeStatus => _onboardingProgressStatus == OnboardingProgressStatus.welcome;

  bool get hasIntroStatus => _onboardingProgressStatus == OnboardingProgressStatus.intro;

  bool get hasQuestionnaireStatus =>
      _onboardingProgressStatus == OnboardingProgressStatus.questionnaire;

  void startIntro() {
    if (_onboardingProgressStatus != OnboardingProgressStatus.intro) {
      _onboardingProgressStatus = OnboardingProgressStatus.intro;
      notifyListeners();
    }
  }

  void startQuestionnaire() {
    if (_onboardingProgressStatus != OnboardingProgressStatus.questionnaire) {
      _onboardingProgressStatus = OnboardingProgressStatus.questionnaire;
      notifyListeners();
    }
  }

  bool containsAchievement(ExaminationType examination) =>
      _obtainedExaminationAchievements.contains(examination);

  void obtainAchievementForExamination(ExaminationType examination) {
    if (!_obtainedExaminationAchievements.contains(examination)) {
      _obtainedExaminationAchievements.add(examination);
      notifyListeners();
    }
  }

  bool isUniversalDoctorDateSkipped(ExaminationType examination) =>
      _universalDoctorDateSkips.contains(examination);

  void skipUniversalDoctorDate(ExaminationType examination) {
    if (!_universalDoctorDateSkips.contains(examination)) {
      _universalDoctorDateSkips.add(examination);
      notifyListeners();
    }
  }

  bool get hasNotRequestedNotificationsPermission =>
      _notificationPermissionState == NotificationPermissionState.notRequested;

  void notificationsPermissionRequested() {
    if (_notificationPermissionState != NotificationPermissionState.requested) {
      _notificationPermissionState = NotificationPermissionState.requested;
      notifyListeners();
    }
  }
}
