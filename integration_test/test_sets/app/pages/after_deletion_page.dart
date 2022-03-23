import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

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
}
