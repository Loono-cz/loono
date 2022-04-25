import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/logout.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [LogoutScreen]
class LogoutPage {
  LogoutPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder loginBtn = find.widgetWithText(LoonoButton, 'Přihlásit se');

  /// Page methods
  Future<void> clickLoginButton() async {
    logTestEvent();
    await tester.tap(loginBtn);
    await tester.pumpAndSettle();
    await tester.pumpUntilNotFound(find.byType(LogoutScreen));
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(LogoutScreen));
  }
}
