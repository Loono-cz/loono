import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class UpdateProfilePage {
  UpdateProfilePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder logoutBtn = find.widgetWithText(TextButton, 'Odhlásit se');
  final Finder deleteBtn = find.widgetWithText(TextButton, 'Smazat účet');
  final Finder cancelButtonLogoutDialog = find.widgetWithText(TextButton, 'Zrušit');

  /// Page methods
  Future<void> clickLogoutButton() async {
    await tester.ensureVisible(logoutBtn);
    await tester.pumpAndSettle();
    await tester.tap(logoutBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
  }

  Future<void> cancelLogoutDialog() async {
    await tester.tap(cancelButtonLogoutDialog);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
  }
}
