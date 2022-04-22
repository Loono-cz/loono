import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [AchievementScreen]
class QuestionnaireAchievementPage {
  QuestionnaireAchievementPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');

  /// Page methods
  Future<void> clickContinueButton() async {
    logTestEvent();
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(AchievementScreen));
  }
}
