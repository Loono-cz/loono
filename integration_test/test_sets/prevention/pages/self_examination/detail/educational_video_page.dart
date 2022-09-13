import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/self_examination/educational_screen.dart';

import '../../../../../test_helpers/e2e_action_logging.dart';
import '../../../../../test_helpers/pom_class_helpers.dart';
import '../../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [EducationalVideoScreen]
class EducationalVideoPage with VerifyVisibilityStateHelper {
  EducationalVideoPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder closeBtn = find.byKey(const Key('educationalVideoPage_closeBtn'));
  final Finder video = find.byKey(const Key('educationalVideoPage_video'));
  final Finder selfExamPerformedBtn =
      find.byKey(const Key('educationalVideoPage_btn_selfExamPerformed'));

  /// Page methods
  Future<void> clickCloseScreenButton() async {
    logTestEvent();
    await tester.tap(closeBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickSelfExamPerformedButton() async {
    logTestEvent();
    await tester.tap(selfExamPerformedBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyVideoIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(video);
  }

  VerifyVisibilityState get verifySelfExaminationPerformedButtonVisibilityState =>
      getVerifyVisibilityStateFunction(
        finder: selfExamPerformedBtn,
        widgetName: 'Self examination performed button',
      );

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(EducationalVideoScreen));
  }
}
