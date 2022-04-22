import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/main/pre_auth/continue_onboarding_form.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [ContinueOnboardingFormScreen]
class ContinueQuestionnairePage {
  ContinueQuestionnairePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder alreadyHaveAnAccountBtn = find.widgetWithText(TextButton, 'Už mám účet');
  final Finder continueFormButton = find.widgetWithText(LoonoButton, 'Dokončit dotazník');
  final Finder progressBar = find.byType(CircularProgressIndicator);

  /// Page methods
  Future<void> clickAlreadyHavenAnAccountButton() async {
    logTestEvent();
    await tester.tap(alreadyHaveAnAccountBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickContinueFormButton() async {
    logTestEvent();
    await tester.tap(continueFormButton);
    await tester.pumpAndSettle();
  }

  void verifyProgressBarHasAnyProgress() => expect(_progressBarValue > 0, true);

  void verifyProgressBarDoesNotHaveAnyProgress() => expect(_progressBarValue > 0, false);

  bool isProgressBarValueEqualTo(double value) => _progressBarValue == value;

  bool isProgressBarValueBiggerThan(double value) => _progressBarValue > value;

  double get _progressBarValue {
    expect(progressBar, findsOneWidget);
    final progressBarWidget = tester.widget<CircularProgressIndicator>(progressBar);
    final value = progressBarWidget.value;
    logTestEvent('Print progress bar value: "$value"');
    // should not have endless animation
    expect(value, isNotNull);
    return value!;
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(ContinueOnboardingFormScreen));
  }
}
