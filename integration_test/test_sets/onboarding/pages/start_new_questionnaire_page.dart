import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class StartNewQuestionnairePage {
  StartNewQuestionnairePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder alreadyHaveAnAccountBtn = find.widgetWithText(TextButton, 'Už mám účet');
  final Finder fillFormBtn = find.widgetWithText(TextButton, 'Vyplnit vstupní dotazník');

  /// Page methods
  Future<void> clickAlreadyHavenAnAccountButton() async {
    await tester.tap(alreadyHaveAnAccountBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }

  Future<void> clickFillFormButton() async {
    await tester.tap(fillFormBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }
}
