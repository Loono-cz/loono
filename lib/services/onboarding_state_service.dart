import 'dart:io';

import 'package:flutter/material.dart';

enum OnboardingProgressStatus { welcome, intro, questionnaire }

enum NotificationPermissionState { notRequested, requested }

class OnboardingStateService extends ChangeNotifier {
  OnboardingProgressStatus _onboardingProgressStatus = OnboardingProgressStatus.welcome;

  final _obtainedAchievementsIDs = <String>{};

  final _universalDoctorDateSkips = <String>{};

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

  bool containsAchievement(String id) => _obtainedAchievementsIDs.contains(id);

  void obtainAchievement(String id) {
    if (!_obtainedAchievementsIDs.contains(id)) {
      _obtainedAchievementsIDs.add(id);
      notifyListeners();
    }
  }

  bool isUniversalDoctorDateSkipped(String id) => _universalDoctorDateSkips.contains(id);

  void skipUniversalDoctorDate(String id) {
    if (!_universalDoctorDateSkips.contains(id)) {
      _universalDoctorDateSkips.add(id);
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
