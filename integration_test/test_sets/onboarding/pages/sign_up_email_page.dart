import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/email.dart';

import '../../../test_helpers/e2e_action_logging.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [EmailScreen]
class SignUpEmailPage {
  SignUpEmailPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder confirmBtn = find.text('Potvrdit');
  final Finder textField = find.byType(TextField);

  /// Page methods
  Future<void> insertEmail(String email) async {
    logTestEvent('Insert email: "$email"');
    await tester.enterText(textField, email);
    await tester.pumpAndSettle();
  }

  Future<void> clickConfirmButton() async {
    logTestEvent();
    await tester.tap(confirmBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(EmailScreen));
  }
}
