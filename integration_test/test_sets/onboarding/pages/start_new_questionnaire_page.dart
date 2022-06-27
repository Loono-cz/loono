import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/main/pre_auth/start_new_questionnaire.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/e2e_action_logging.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [StartNewQuestionnaireScreen]
class StartNewQuestionnairePage {
  StartNewQuestionnairePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder alreadyHaveAnAccountBtn = find.widgetWithText(TextButton, 'Už mám účet');
  final Finder fillFormBtn = find.widgetWithText(LoonoButton, 'Vyplnit vstupní dotazník');

  /// Page methods
  Future<void> clickAlreadyHaveAnAccountButton() async {
    logTestEvent();
    await tester.tap(alreadyHaveAnAccountBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickFillFormButton() async {
    logTestEvent();
    await tester.tap(fillFormBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(StartNewQuestionnaireScreen));
  }
}
