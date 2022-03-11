import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

class UpdateProfilePage {
  UpdateProfilePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder logoutBtn = find.widgetWithText(TextButton, 'Odhlásit se');
  final Finder deleteAccountBtn = find.widgetWithText(TextButton, 'Smazat účet');
  final Finder cancelBtnLogoutDialog = find.widgetWithText(TextButton, 'Zrušit');
  final Finder confirmBtnLogoutDialog = find.widgetWithText(TextButton, 'Pokračovat');

  /// Page methods
  Future<void> clickLogoutButton() async {
    await tester.ensureVisible(logoutBtn);
    await tester.pumpAndSettle();
    await tester.tap(logoutBtn);
    await tester.pumpSettleAndWait(seconds: 1);
  }

  Future<void> clickDeleteAccountButton() async {
    await tester.ensureVisible(deleteAccountBtn);
    await tester.pumpAndSettle();
    await tester.tap(deleteAccountBtn);
    await tester.pumpSettleAndWait(seconds: 1);
  }

  Future<void> cancelLogoutDialog() async {
    await tester.tap(cancelBtnLogoutDialog);
    await tester.pumpSettleAndWait(seconds: 2);
  }

  Future<void> confirmLogoutDialog() async {
    await tester.tap(confirmBtnLogoutDialog);
    await tester.pumpSettleAndWait(seconds: 5);
  }
}
