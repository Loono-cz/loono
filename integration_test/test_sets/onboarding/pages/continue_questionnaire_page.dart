import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

class ContinueQuestionnairePage {
  ContinueQuestionnairePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder alreadyHaveAnAccountBtn = find.widgetWithText(TextButton, 'Už mám účet');
  final Finder continueFormButton = find.widgetWithText(LoonoButton, 'Dokonči dotazník');
  final Finder progressBar = find.byType(CircularProgressIndicator);

  /// Page methods
  Future<void> clickAlreadyHavenAnAccountButton() async {
    await tester.tap(alreadyHaveAnAccountBtn);
    await tester.pumpSettleAndWait(seconds: 2);
  }

  Future<void> clickContinueFormButton() async {
    await tester.tap(continueFormButton);
    await tester.pumpSettleAndWait(seconds: 2);
  }

  bool hasProgressBarAnyProgress() => _progressBarValue > 0;

  bool isProgressBarValueEqualTo(double value) => _progressBarValue == value;

  bool isProgressBarValueBiggerThan(double value) => _progressBarValue > value;

  double get _progressBarValue {
    expect(progressBar, findsOneWidget);
    final progressBarWidget = tester.widget<CircularProgressIndicator>(progressBar);
    final value = progressBarWidget.value;
    // should not have endless animation
    expect(value, isNotNull);
    return value!;
  }
}
