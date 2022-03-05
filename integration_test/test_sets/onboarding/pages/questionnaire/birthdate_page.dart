import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../../test_helpers/common_shared_finders.dart';

class QuestionnaireBirthDatePage {
  QuestionnaireBirthDatePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder skipQuestionnaireBtn = CommonSharedFinders.onboardingSkipQuestionnaireBtn;
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');

  /// Page methods
  Future<void> clickContinueButton() async {
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }
}
