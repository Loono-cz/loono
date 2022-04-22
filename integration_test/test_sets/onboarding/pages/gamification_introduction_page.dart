import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/onboarding/gamification_introduction.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [GamificationIntroductionScreen]
class GamificationIntroductionPage {
  GamificationIntroductionPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder continueBtn = find.byKey(const Key('gamificationIntroductionPage_btn_continue'));

  /// Page methods
  Future<void> clickContinueButton() async {
    logTestEvent();
    await tester.ensureVisible(continueBtn);
    await tester.pumpAndSettle();
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(GamificationIntroductionScreen));
  }
}
