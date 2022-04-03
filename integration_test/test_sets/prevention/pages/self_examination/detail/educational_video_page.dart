import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/self_examination/educational_screen.dart';

import '../../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [EducationalVideoScreen]
class EducationalVideoPage {
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
    await tester.pumpUntilVisible(video);
  }

  void verifySelfExaminationPerformedButtonIsShown() {
    logTestEvent();
    expect(selfExamPerformedBtn, findsOneWidget);
  }

  void verifySelfExaminationPerformedButtonIsNotShown() {
    logTestEvent();
    expect(selfExamPerformedBtn, findsNothing);
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilVisible(find.byType(EducationalVideoScreen));
  }
}
