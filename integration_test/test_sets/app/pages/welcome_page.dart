import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

class WelcomePage {
  WelcomePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder startBtn = find.widgetWithText(LoonoButton, 'Začít');
  final Finder loginBtn = find.widgetWithText(TextButton, 'Už mám účet');

  /// Page methods
  Future<void> clickStartButton() async {
    await tester.tap(startBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 8));
  }

  Future<void> clickLoginButton() async {
    await tester.tap(loginBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 4));
  }
}
