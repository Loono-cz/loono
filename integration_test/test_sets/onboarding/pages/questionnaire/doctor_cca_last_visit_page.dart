import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

class QuestionnaireDoctorCcaLastVisitPage with OnboardingFinders {
  QuestionnaireDoctorCcaLastVisitPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  Finder get skipQuestionnaireBtn => commonOnboardingSkipQuestionnaireBtn;
  final Finder inLastXYearsBtn = find.textContaining('V poslední');
  final Finder moreThanXYearsOrIdkButton = find.textContaining('to více než');

  /// Page methods
  Future<void> clickInLastXYearsButton({required Type nextScreen}) async {
    logTestEvent();
    await tester.tap(inLastXYearsBtn);
    await tester.pumpAndSettle();
    await tester.pumpUntilVisible(find.byType(nextScreen));
  }

  Future<void> clickMoreThanXYearsOrIdkButton({required Type nextScreen}) async {
    logTestEvent();
    await tester.tap(moreThanXYearsOrIdkButton);
    await tester.pumpAndSettle();
    await tester.pumpUntilVisible(find.byType(nextScreen));
  }
}
