import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [UpdateProfileScreen]
class UpdateProfilePage with SettingsFinders {
  UpdateProfilePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder nicknameTextField = find.descendant(
    of: find.byKey(const Key('updateProfilePage_updateProfileItem_nickname')),
    matching: find.byType(TextField),
  );
  final Finder emailTextField = find.descendant(
    of: find.byKey(const Key('updateProfilePage_updateProfileItem_email')),
    matching: find.byType(TextField),
  );
  final Finder sexTextField = find.descendant(
    of: find.byKey(const Key('updateProfilePage_updateProfileItem_sex')),
    matching: find.byType(TextField),
  );
  final Finder birthdateTextField = find.descendant(
    of: find.byKey(const Key('updateProfilePage_updateProfileItem_birthdate')),
    matching: find.byType(TextField),
  );
  final Finder logoutBtn = find.widgetWithText(TextButton, 'Odhlásit se');
  final Finder deleteAccountBtn = find.widgetWithText(TextButton, 'Smazat účet');

  Finder get backBtn => commonSettingsSheetBackBtn;
  Finder get confirmationDialog =>
      find.byWidgetPredicate((widget) => widget is AlertDialog || widget is CupertinoAlertDialog);
  Finder get cancelBtnLogoutDialog => find.descendant(
    of: confirmationDialog,
    matching: find.textContaining(RegExp('Zrušit', caseSensitive: false)),
  );
  Finder get confirmBtnLogoutDialog => find.descendant(
    of: confirmationDialog,
    matching: find.textContaining(RegExp('Pokračovat', caseSensitive: false)),
  );

  /// Page methods
  Future<void> clickNicknameField() async {
    logTestEvent();
    await tester.tap(nicknameTextField);
    await tester.pumpAndSettle();
  }

  Future<void> clickEmailField() async {
    logTestEvent();
    await tester.tap(emailTextField);
    await tester.pumpAndSettle();
  }

  Future<void> clickSexField() async {
    logTestEvent();
    await tester.ensureVisible(sexTextField);
    await tester.pumpAndSettle();
    await tester.tap(sexTextField);
    await tester.pumpAndSettle();
  }

  Future<void> clickBirthdateField() async {
    logTestEvent();
    await tester.ensureVisible(birthdateTextField);
    await tester.pumpAndSettle();
    await tester.tap(birthdateTextField);
    await tester.pumpAndSettle();
  }

  Future<void> clickLogoutButton() async {
    logTestEvent();
    await tester.ensureVisible(logoutBtn);
    await tester.pumpAndSettle();
    await tester.tap(logoutBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickDeleteAccountButton() async {
    logTestEvent();
    await tester.ensureVisible(deleteAccountBtn);
    await tester.pumpAndSettle();
    await tester.tap(deleteAccountBtn);
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

  Future<void> closeErrorSheet() async {
    logTestEvent();
    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();
  }

  Future<void> clickBackButton() async {
    logTestEvent();
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
  }

  void verifyNickname(String expectedNickname) {
    logTestEvent('Verify nickname is: "$expectedNickname"');
    final nicknameText = find.descendant(
      of: nicknameTextField,
      matching: find.text(expectedNickname),
    );
    expect(nicknameText, findsOneWidget);
  }

  void verifyEmail(String expectedEmail) {
    logTestEvent('Verify email is: "$expectedEmail"');
    final emailText = find.descendant(
      of: emailTextField,
      matching: find.text(expectedEmail),
    );
    expect(emailText, findsOneWidget);
  }

  Future<void> verifyConfirmationDialogIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(confirmationDialog);
  }

  Future<void> verifyConfirmationDialogIsNotShown() async {
    logTestEvent();
    await tester.pumpUntilNotFound(confirmationDialog);
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(UpdateProfileScreen));
  }
}
