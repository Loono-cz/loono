import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/social_login_button.dart';

class LoginPage {
  LoginPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder appleLoginBtn = find.widgetWithText(SocialLoginButton, 'Přihlásit pomocí Apple');
  final Finder googleLoginBtn =
      find.widgetWithText(SocialLoginButton, 'Přihlásit pomocí Google účtu');
  final Finder createNewAccountBtn = find.widgetWithText(TextButton, 'Vytvořit nový účet');

  /// Page methods
  Future<void> loginWithApple() async {
    // TODO
    await tester.tap(appleLoginBtn);
    await tester.pumpAndSettle();
  }

  Future<void> loginWithGoogle() async {
    await tester.tap(googleLoginBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickCreateNewAccountButton() async {
    await tester.tap(createNewAccountBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }
}
