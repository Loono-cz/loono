import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AfterDeletionPage {
  AfterDeletionPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder sendEmailBtn = find.byKey(const Key('afterDeletionPage_button_sendEmail'));

  /// Page methods
  Future<void> clickSendEmailButton() async {
    await tester.tap(sendEmailBtn);
  }
}
