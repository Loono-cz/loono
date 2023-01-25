import 'package:flutter/material.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono_api/loono_api.dart';

class OnboardingStateService extends ChangeNotifier {
  OnboardingStateService({
    required this.notificationService,
  });

  final NotificationService notificationService;

  final _obtainedExaminationAchievements = <ExaminationType>{};

  bool containsAchievement(ExaminationType examination) =>
      _obtainedExaminationAchievements.contains(examination);

  void obtainAchievementForExamination(ExaminationType examination) {
    if (!_obtainedExaminationAchievements.contains(examination)) {
      _obtainedExaminationAchievements.add(examination);
      notifyListeners();
    }
  }
}
