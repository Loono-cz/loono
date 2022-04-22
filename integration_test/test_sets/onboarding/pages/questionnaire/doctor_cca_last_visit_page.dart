import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen is either:
/// [OnboardingGeneralPracticionerScreen], [OnboardingGynecologyScreen] or [OnboardingDentistScreen].
class QuestionnaireDoctorCcaLastVisitPage with OnboardingFinders {
  QuestionnaireDoctorCcaLastVisitPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  Finder get skipQuestionnaireBtn => commonOnboardingSkipQuestionnaireBtn;
  final Finder inLastXYearsBtn = find.textContaining('V poslední');
  final Finder moreThanXYearsOrIdkButton = find.textContaining('to více než');

  /// Page methods
  /// The 1st button on the screen (user gets a rewards and then picks date).
  Future<void> clickInLastXYearsButton({required Type expectedNextScreen}) async {
    logTestEvent();
    await tester.tap(inLastXYearsBtn);
    await tester.pumpAndSettle();
    await verifyScreenIsShown(expectedScreen: expectedNextScreen);
  }

  /// The 2nd button on the screen (user does not get a reward).
  Future<void> clickMoreThanXYearsOrIdkButton({required Type expectedNextScreen}) async {
    logTestEvent();
    await tester.tap(moreThanXYearsOrIdkButton);
    await tester.pumpAndSettle();
    await verifyScreenIsShown(expectedScreen: expectedNextScreen);
  }

  Future<void> verifyScreenIsShown({required Type expectedScreen}) async {
    logTestEvent('Verify screen is shown: "${expectedScreen.runtimeType}"');
    await tester.pumpUntilFound(find.byType(expectedScreen));
  }
}
