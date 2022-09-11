import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/e2e_action_logging.dart';
import '../../../../test_helpers/pom_class_helpers.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [UpdateProfileScreen]
class UpdateProfilePage with SettingsFinders, PomClassHelpers {
  UpdateProfilePage(this.tester);

  final WidgetTester tester;

  final Finder userDataSection = find.ancestor(
    of: find.byType(Container),
    matching: find.byKey(const Key('ExpansionTileUserDataSection')),
  );

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

  final Finder deleteAccountBtn = find.widgetWithText(TextButton, 'Smazat účet');

  Finder get backBtn => commonSettingsSheetBackBtn;

  Future<void> clickUserDataSection() async {
    logTestEvent('Click on user data section');
    await tester.pumpAndSettle();
    await tester.tap(userDataSection);
    await tester.pumpAndSettle();
  }

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

  Future<void> clickDeleteAccountButton() async {
    logTestEvent();
    await tester.ensureVisible(deleteAccountBtn);
    await tester.pumpAndSettle();
    await tester.tap(deleteAccountBtn);
    await tester.pumpAndSettle();
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

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(UpdateProfileScreen));
  }
}
