import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/onboarding/gender_button.dart';

import '../../../../test_helpers/common_shared_finders.dart';

class QuestionnaireGenderPage {
  QuestionnaireGenderPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder skipQuestionnaireBtn = CommonSharedFinders.onboardingSkipQuestionnaireBtn;
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');
  final Finder femaleGenderBtn = find.descendant(
    of: find.byType(GenderButton),
    matching: find.text('žena'),
  );
  final Finder maleGenderBtn = find.descendant(
    of: find.byType(GenderButton),
    matching: find.text('muž'),
  );

  /// Page methods
  Future<void> clickSkipQuestionnaireButton() async {
    await tester.tap(skipQuestionnaireBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickContinueButton() async {
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
  }

  Future<void> chooseMaleGender() async {
    await tester.tap(maleGenderBtn);
    await tester.pumpAndSettle();
  }

  Future<void> chooseFemaleGender() async {
    await tester.tap(femaleGenderBtn);
    await tester.pumpAndSettle();
  }

  bool isContinueButtonDisabled() {
    final loonoButton = tester.widget<LoonoButton>(continueBtn);
    final isButtonDisabled = loonoButton.enabled == false;
    return isButtonDisabled;
  }
}
