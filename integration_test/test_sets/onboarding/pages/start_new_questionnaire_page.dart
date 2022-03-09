import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

class StartNewQuestionnairePage {
  StartNewQuestionnairePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder alreadyHaveAnAccountBtn = find.widgetWithText(TextButton, 'Už mám účet');
  final Finder fillFormBtn = find.widgetWithText(LoonoButton, 'Vyplnit vstupní dotazník');

  /// Page methods
  Future<void> clickAlreadyHaveAnAccountButton() async {
    await tester.tap(alreadyHaveAnAccountBtn);
    await tester.pumpSettleAndWait(seconds: 2);
  }

  Future<void> clickFillFormButton() async {
    await tester.tap(fillFormBtn);
    await tester.pumpSettleAndWait(seconds: 2);
  }
}
