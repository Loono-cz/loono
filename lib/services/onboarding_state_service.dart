import 'package:flutter/material.dart';

enum OnboardingProgressStatus { welcome, intro, questionnaire }

class OnboardingStateService extends ChangeNotifier {
  OnboardingProgressStatus onboardingProgressStatus = OnboardingProgressStatus.welcome;

  final _obtainedAchievementsIDs = <String>{};

  bool get hasWelcomeStatus =>
      onboardingProgressStatus == OnboardingProgressStatus.welcome;

  bool get hasIntroStatus =>
      onboardingProgressStatus == OnboardingProgressStatus.intro;

  bool get hasQuestionnaireStatus =>
      onboardingProgressStatus == OnboardingProgressStatus.questionnaire;

  void startIntro() {
    if (onboardingProgressStatus != OnboardingProgressStatus.intro) {
      onboardingProgressStatus = OnboardingProgressStatus.intro;
      notifyListeners();
    }
  }

  void startQuestionnaire() {
    if (onboardingProgressStatus != OnboardingProgressStatus.questionnaire) {
      onboardingProgressStatus = OnboardingProgressStatus.questionnaire;
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
}
