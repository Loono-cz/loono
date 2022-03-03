import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

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
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
  }

  Future<void> clickContinueFormButton() async {
    await tester.tap(continueFormButton);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
  }

  bool hasProgressBarAnyProgress() => _getProgressBarValue()! > 0;

  bool isProgressBarValueEqualTo(double value) => _getProgressBarValue()! == value;

  bool isProgressBarValueBiggerThan(double value) => _getProgressBarValue()! > value;

  double? _getProgressBarValue() {
    expect(progressBar, findsOneWidget);
    final progressBarWidget = tester.widget<CircularProgressIndicator>(progressBar);
    final value = progressBarWidget.value;
    // should not have endless animation
    expect(value, isNotNull);
    return value;
  }
}
