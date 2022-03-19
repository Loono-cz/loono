import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/widget_tester_extensions.dart';

class UpdateProfilePage {
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
  final Finder cancelBtnLogoutDialog = find.widgetWithText(TextButton, 'Zrušit');
  final Finder confirmBtnLogoutDialog = find.widgetWithText(TextButton, 'Pokračovat');

  /// Page methods
  Future<void> clickNicknameField() async {
    await tester.tap(nicknameTextField);
    await tester.pumpAndSettle();
  }

  Future<void> clickEmailField() async {
    await tester.tap(emailTextField);
    await tester.pumpAndSettle();
  }

  Future<void> clickSexField() async {
    await tester.ensureVisible(sexTextField);
    await tester.pumpAndSettle();
    await tester.tap(sexTextField);
    await tester.pumpAndSettle();
  }

  Future<void> clickBirthdateField() async {
    await tester.ensureVisible(birthdateTextField);
    await tester.pumpAndSettle();
    await tester.tap(birthdateTextField);
    await tester.pumpAndSettle();
  }

  Future<void> clickLogoutButton() async {
    await tester.ensureVisible(logoutBtn);
    await tester.pumpAndSettle();
    await tester.tap(logoutBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickDeleteAccountButton() async {
    await tester.ensureVisible(deleteAccountBtn);
    await tester.pumpAndSettle();
    await tester.tap(deleteAccountBtn);
    await tester.pumpAndSettle();
  }

  Future<void> cancelLogoutDialog() async {
    await tester.tap(cancelBtnLogoutDialog);
    await tester.pumpAndSettle();
  }

  Future<void> confirmLogoutDialog() async {
    await tester.tap(confirmBtnLogoutDialog);
    await tester.pumpAndSettle();
    await tester.pumpUntilNotVisible(confirmBtnLogoutDialog);
  }

  Future<void> closeErrorSheet() async {
    await tester.tapAt(Offset.zero);
  }

  void verifyNickname(String expectedNickname) {
    final nicknameText = find.descendant(
      of: nicknameTextField,
      matching: find.text(expectedNickname),
    );
    expect(nicknameText, findsOneWidget);
  }

  void verifyEmail(String expectedEmail) {
    final emailText = find.descendant(
      of: emailTextField,
      matching: find.text(expectedEmail),
    );
    expect(emailText, findsOneWidget);
  }
}
