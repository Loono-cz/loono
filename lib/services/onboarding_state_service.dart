import 'package:flutter/material.dart';

class OnboardingStateService extends ChangeNotifier {
  final _obtainedAchievementsIDs = <String>{};

  bool containsAchievement(String id) => _obtainedAchievementsIDs.contains(id);

  void obtainAchievement(String id) {
    if (!_obtainedAchievementsIDs.contains(id)) {
      _obtainedAchievementsIDs.add(id);
      notifyListeners();
    }
  }
}
