import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/common_finders.dart';
import '../../../test_helpers/e2e_action_logging.dart';
import '../../../test_helpers/verify_visibility_state_helper.dart';
import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [OpenSettingsScreen]
class OpenSettingsPage with SettingsFinders, VerifyVisibilityStateHelper {
  OpenSettingsPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder editProfileBtn = find.widgetWithText(LoonoButton, 'Nastavení účtu');
  final Finder leaderboardBtn = find.widgetWithText(LoonoButton, 'Žebříček');
  final Finder logoutBtn = find.widgetWithText(TextButton, 'Odhlásit se');

  Finder get confirmationDialog =>
      find.byWidgetPredicate((widget) => widget is AlertDialog || widget is CupertinoAlertDialog);

  Finder get cancelBtnLogoutDialog => find.descendant(
        of: confirmationDialog,
        matching: find.textContaining(RegExp(r'^zrušit$', caseSensitive: false)),
      );

  Finder get confirmBtnLogoutDialog => find.descendant(
        of: confirmationDialog,
        matching: find.textContaining(RegExp(r'^pokračovat$', caseSensitive: false)),
      );

  /// Page methods
  Future<void> clickEditProfileButton() async {
    logTestEvent();
    await tester.tap(editProfileBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickLeaderboardButton() async {
    logTestEvent();
    await tester.tap(leaderboardBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(OpenSettingsScreen));
  }

  Future<void> clickLogoutButton() async {
    logTestEvent();
    await tester.ensureVisible(logoutBtn);
    await tester.pumpAndSettle();
    await tester.tap(logoutBtn);
    await tester.pumpAndSettle();
  }

  Future<void> cancelLogoutDialog() async {
    logTestEvent();
    await tester.tap(cancelBtnLogoutDialog);
    await tester.pumpAndSettle();
  }

  Future<void> confirmLogoutDialog() async {
    logTestEvent();
    await tester.tap(confirmBtnLogoutDialog);
    await tester.pumpAndSettle();
    await tester.pumpUntilNotFound(confirmBtnLogoutDialog);
  }

  VerifyVisibilityState get verifyConfirmationDialogVisibilityState =>
      getVerifyVisibilityStateFunction(
        finder: confirmationDialog,
        widgetName: 'Confirmation dialog',
        widgetTester: tester,
      );
}
