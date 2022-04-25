import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/settings/after_deletion.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [AfterDeletionScreen]
class AfterDeletionPage {
  AfterDeletionPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder sendEmailBtn = find.byKey(const Key('afterDeletionPage_button_sendEmail'));

  /// Page methods
  Future<void> clickSendEmailButton() async {
    logTestEvent();
    await tester.tap(sendEmailBtn);
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(AfterDeletionScreen));
  }
}
