import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loono/helpers/platform_helpers.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono_api/loono_api.dart';

enum NotificationPermissionState { notRequestedYet, requested, skipped, didNotGrant }

class OnboardingStateService extends ChangeNotifier {
  OnboardingStateService({
    required this.notificationService,
  });

  final NotificationService notificationService;

  final _obtainedExaminationAchievements = <ExaminationType>{};

  // on Android notifications are allowed by default
  NotificationPermissionState _notificationPermissionState =
      NotificationPermissionState.notRequestedYet;

  bool containsAchievement(ExaminationType examination) =>
      _obtainedExaminationAchievements.contains(examination);

  void obtainAchievementForExamination(ExaminationType examination) {
    if (!_obtainedExaminationAchievements.contains(examination)) {
      _obtainedExaminationAchievements.add(examination);
      notifyListeners();
    }
  }

  // we did not ask the user yet
  bool get hasNotRequestedNotificationsPermissionYet =>
      _notificationPermissionState == NotificationPermissionState.notRequestedYet;

  // TODO: User might decline the permission. Handle this possible state.
  /// Prompt iOS users for notification permissions.
  /// When user declines the permission we cannot request it again. This should
  /// be represented in the UI.
  Future<void> promptPermission() async {
    final permissionGranted = await notificationService.promptPermissions();
    if (permissionGranted) {
      _notificationPermissionState = NotificationPermissionState.requested;
    } else {
      _notificationPermissionState = NotificationPermissionState.didNotGrant;
    }
    notifyListeners();
  }

  void skipPermissionRequest() {
    _notificationPermissionState = NotificationPermissionState.skipped;
    notifyListeners();
  }

  ///Ignore notification on Android 12 and lower
  void ignoreNotificationPermission() {
    _notificationPermissionState = NotificationPermissionState.requested;
  }
}
