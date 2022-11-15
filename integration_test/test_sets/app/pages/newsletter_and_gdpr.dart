import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/main/pre_auth/login.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/newsletter_and_gdpr.dart';
import 'package:loono/ui/widgets/async_button.dart';

import '../../../test_helpers/e2e_action_logging.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [LoginScreen]
class SignUpNewsletterAndGdpr {
  SignUpNewsletterAndGdpr(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder createAccountBtn = find.widgetWithText(AsyncLoonoButton, 'Vytvořit účet');

  /// Page methods
  Future<void> clickCreateAccountButton() async {
    logTestEvent();
    await tester.tap(createAccountBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(NewsletterAndGDPRScreen));
  }
}
