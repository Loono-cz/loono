import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/self_examination/has_finding_screen.dart';

import '../../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [HasFindingScreen]
class HasFindingPage {
  HasFindingPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder closeBtn = find.byKey(const Key('hasFindingPage_btn_close'));
  final Finder findDoctorBtn = find.byKey(const Key('hasFindingPage_btn_findDoctor'));

  /// Page methods
  Future<void> clickCloseScreenButton() async {
    logTestEvent();
    await tester.tap(closeBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickFindDoctorButton() async {
    logTestEvent();
    await tester.ensureVisible(findDoctorBtn);
    await tester.pumpAndSettle();
    await tester.tap(findDoctorBtn);
    await tester.pumpAndSettle();
  }

  void verifyContentIsShown({required String textPattern}) {
    logTestEvent('Verify page contains text: "$textPattern"');
    expect(find.textContaining(textPattern), findsWidgets);
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(HasFindingScreen));
  }
}
