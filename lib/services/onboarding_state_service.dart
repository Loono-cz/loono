import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono_api/loono_api.dart';

enum NotificationPermissionState { notRequested, requested }

class OnboardingStateService extends ChangeNotifier {
  OnboardingStateService({
    required this.notificationService,
  });

  final NotificationService notificationService;

  final _obtainedExaminationAchievements = <ExaminationTypeEnum>{};

  // on Android notifications are allowed by default
  NotificationPermissionState _notificationPermissionState = Platform.isIOS
      ? NotificationPermissionState.notRequested
      : NotificationPermissionState.requested;

  bool containsAchievement(ExaminationTypeEnum examination) =>
      _obtainedExaminationAchievements.contains(examination);

  void obtainAchievementForExamination(ExaminationTypeEnum examination) {
    if (!_obtainedExaminationAchievements.contains(examination)) {
      _obtainedExaminationAchievements.add(examination);
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
