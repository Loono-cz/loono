import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../../test_helpers/common_finders.dart';

class QuestionnaireAchievementPage with OnboardingFinders {
  QuestionnaireAchievementPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  Finder get skipQuestionnaireBtn => commonOnboardingSkipQuestionnaireBtn;
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');

  /// Page methods
  Future<void> clickContinueButton() async {
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
  }
}
