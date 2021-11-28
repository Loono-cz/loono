import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/services/notification_service.dart';

enum OnboardingProgressStatus { welcome, intro, questionnaire }

enum NotificationPermissionState { notRequested, requested }

class OnboardingStateService extends ChangeNotifier {
  OnboardingStateService({
    required this.notificationService,
  });

  final NotificationService notificationService;

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

  // TODO: Maybe hide this option for Android users in the UI?
  // TODO: User might decline the permission. Handle this possible state.
  /// Prompt iOS users for notification permissions.
  /// When user declines the permission we cannot request it again. This should
  /// be represented in the UI.
  Future<void> notificationsPermissionRequested() async {
    final permissionGranted = await notificationService.promptPermissions();
    if (permissionGranted) {
      _notificationPermissionState = NotificationPermissionState.requested;
      notifyListeners();
    } else {
      _notificationPermissionState = NotificationPermissionState.notRequested;
      notifyListeners();
    }
  }
}
