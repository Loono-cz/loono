import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

class QuestionnaireDoctorDatePickerPage {
  QuestionnaireDoctorDatePickerPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder idkBtn = find.widgetWithText(TextButton, 'Přeskočit dotazník');
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');

  /// Page methods
  Future<void> clickContinueButton() async {
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
  }
}
