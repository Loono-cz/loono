import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/main/pre_auth/onboarding_form_done.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [OnboardingFormDoneScreen]
class OnboardingFormDonePage {
  OnboardingFormDonePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder googleLoginBtn = find.byKey(const Key('onboardingFormDonePage_btn_googleSignUp'));

  /// Page methods
  Future<void> clickLoginWithGoogleButton() async {
    logTestEvent();
    await tester.tap(googleLoginBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilVisible(find.byType(OnboardingFormDoneScreen));
  }
}
