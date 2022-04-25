import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/onboarding/gender_button.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [OnboardingGenderScreen]
class QuestionnaireGenderPage with OnboardingFinders {
  QuestionnaireGenderPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  Finder get skipQuestionnaireBtn => commonOnboardingSkipQuestionnaireBtn;
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
    logTestEvent();
    await tester.tap(skipQuestionnaireBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickContinueButton() async {
    logTestEvent();
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
  }

  Future<void> chooseMaleGender() async {
    logTestEvent();
    await tester.tap(maleGenderBtn);
    await tester.pumpAndSettle();
  }

  Future<void> chooseFemaleGender() async {
    logTestEvent();
    await tester.tap(femaleGenderBtn);
    await tester.pumpAndSettle();
  }

  bool verifyContinueButtonState({required bool isEnabled}) {
    logTestEvent('Verify continue button state is: "${isEnabled ? 'enabled' : 'disabled'}"');
    final loonoButton = tester.widget<LoonoButton>(continueBtn);
    final isButtonDisabled = loonoButton.enabled == false;
    return isButtonDisabled;
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(OnboardingGenderScreen));
  }
}
