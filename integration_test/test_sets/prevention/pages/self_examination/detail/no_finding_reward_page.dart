import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/self_examination/no_finding_screen.dart';

import '../../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [NoFindingScreen]
class NoFindingRewardPage {
  NoFindingRewardPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder continueBtn = find.byKey(const Key('noFindingRewardPage_btn_continue'));

  /// Page methods
  Future<void> clickContinueButton() async {
    logTestEvent();
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(NoFindingScreen));
  }
}
