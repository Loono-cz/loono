import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/settings/delete_account.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/checkbox.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [DeleteAccountScreen]
class DeleteAccountPage with SettingsFinders {
  DeleteAccountPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder checkBoxDeleteCheckups =
      find.byKey(const Key('deleteAccountPage_checkBox_deleteCheckups'));
  final Finder checkBoxDeleteBadges =
      find.byKey(const Key('deleteAccountPage_checkBox_deleteBadges'));
  final Finder checkBoxStopNotifications =
      find.byKey(const Key('deleteAccountPage_checkBox_stopNotifications'));
  final Finder deleteAccountBtn = find.widgetWithText(LoonoButton, 'Smazat účet');
  final Finder closeScreenBtn = find.byIcon(Icons.close);

  Finder get deleteAccountDialog =>
      find.byWidgetPredicate((widget) => widget is AlertDialog || widget is CupertinoAlertDialog);

  Finder get deleteAccountDialogCancelBtn => find.descendant(
        of: deleteAccountDialog,
        matching: find.textContaining(RegExp('Zrušit', caseSensitive: false)),
      );

  Finder get deleteAccountDialogConfirmBtn => find.descendant(
        of: deleteAccountDialog,
        matching: find.textContaining(RegExp('Smazat', caseSensitive: false)),
      );

  /// Page methods
  Future<void> clickDeleteCheckupsCheckBox() async {
    logTestEvent();
    await tester.tap(checkBoxDeleteCheckups);
    await tester.pumpAndSettle();
  }

  Future<void> clickDeleteBadgesCheckBox() async {
    logTestEvent();
    await tester.tap(checkBoxDeleteBadges);
    await tester.pumpAndSettle();
  }

  Future<void> clickStopNotificationsCheckBox() async {
    logTestEvent();
    await tester.tap(checkBoxStopNotifications);
    await tester.pumpAndSettle();
  }

  void verifyCheckBoxStates({
    required bool isDeleteCheckupsCheckBoxChecked,
    required bool isDeleteBadgesCheckBoxChecked,
    required bool isStopNotificationsCheckBoxChecked,
  }) {
    final checkboxTexts = <String>['deleteCheckups', 'deleteBadges', 'stopNotifications'];
    final checked = <String>[
      if (isDeleteCheckupsCheckBoxChecked) checkboxTexts[0],
      if (isDeleteBadgesCheckBoxChecked) checkboxTexts[1],
      if (isStopNotificationsCheckBoxChecked) checkboxTexts[2],
    ];
    logTestEvent(
      'Verify checked checkboxes are: "${checked.toString()}"',
    );
    logTestEvent(
      'Verify unchecked checkboxes are: "${checkboxTexts.where((e) => !checked.contains(e))}"',
    );
    final deleteCheckupsCheckBoxState = _isCheckBoxChecked(checkBoxDeleteCheckups);
    final deleteBadgesCheckBoxState = _isCheckBoxChecked(checkBoxDeleteBadges);
    final stopNotificationsCheckBoxState = _isCheckBoxChecked(checkBoxStopNotifications);
    expect(deleteCheckupsCheckBoxState, isDeleteCheckupsCheckBoxChecked);
    expect(deleteBadgesCheckBoxState, isDeleteBadgesCheckBoxChecked);
    expect(stopNotificationsCheckBoxState, isStopNotificationsCheckBoxChecked);
  }

  Future<void> clickDeleteAccountButton() async {
    logTestEvent();
    await tester.tap(deleteAccountBtn);
    await tester.pumpAndSettle();
  }

  Future<void> cancelDeleteAccountDialog() async {
    logTestEvent();
    await tester.tap(deleteAccountDialogCancelBtn);
    await tester.pumpAndSettle();
  }

  Future<void> confirmDeleteAccountDialog() async {
    logTestEvent();
    await tester.tap(deleteAccountDialogConfirmBtn);
    await tester.pumpAndSettle();
    await tester.pumpUntilNotFound(deleteAccountDialogConfirmBtn);
  }

  Future<void> clickCloseScreenButton() async {
    logTestEvent();
    await tester.tap(closeScreenBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyConfirmationDialogIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(deleteAccountDialog);
  }

  Future<void> verifyConfirmationDialogIsNotShown() async {
    logTestEvent();
    await tester.pumpUntilNotFound(deleteAccountDialog);
  }

  Future<void> verifyDeleteAccountButtonIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(deleteAccountBtn);
  }

  Future<void> verifyDeleteAccountButtonIsNotShown() async {
    logTestEvent();
    await tester.pumpUntilNotFound(deleteAccountBtn);
  }

  bool _isCheckBoxChecked(Finder finder) {
    final checkBox = tester.widget<CheckboxCustom>(finder);
    return checkBox.isChecked;
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(DeleteAccountScreen));
  }
}
