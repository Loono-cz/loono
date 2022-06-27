import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/welcome.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/e2e_action_logging.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [WelcomeScreen]
class WelcomePage {
  WelcomePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder startBtn = find.widgetWithText(LoonoButton, 'Začít');
  final Finder loginBtn = find.widgetWithText(TextButton, 'Už mám účet');

  /// Page methods
  Future<void> clickStartButton() async {
    logTestEvent();
    await tester.tap(startBtn);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpUntilNotFound(find.byType(WelcomeScreen));
  }

  Future<void> clickLoginButton() async {
    logTestEvent();
    await tester.tap(loginBtn);
    await tester.pumpAndSettle();
    await tester.pumpUntilNotFound(find.byType(WelcomeScreen));
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(WelcomeScreen));
  }
}
