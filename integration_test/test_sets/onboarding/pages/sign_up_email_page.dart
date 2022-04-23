import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/email.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

class SignUpEmailPage {
  SignUpEmailPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder createAccountBtn = find.text('Vytvořit účet');
  final Finder textField = find.byType(TextField);

  /// Page methods
  Future<void> insertEmail(String email) async {
    logTestEvent('Insert email: $email');
    await tester.enterText(textField, email);
    await tester.pumpAndSettle();
  }

  Future<void> clickCreateAccountButton() async {
    logTestEvent();
    await tester.tap(createAccountBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(EmailScreen));
  }
}
