import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/common_shared_finders.dart';

class QuestionnaireDoctorCcaLastVisitPage {
  QuestionnaireDoctorCcaLastVisitPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder skipQuestionnaireBtn = CommonSharedFinders.onboardingSkipQuestionnaireBtn;
  final Finder inLastXYearsBtn = find.textContaining('V poslední');
  final Finder moreThanXYearsOrIdkButton = find.textContaining('to více než');

  /// Page methods
  Future<void> clickInLastXYearsButton() async {
    await tester.tap(inLastXYearsBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickMoreThanXYearsOrIdkButton() async {
    await tester.tap(moreThanXYearsOrIdkButton);
    await tester.pumpAndSettle();
  }
}
