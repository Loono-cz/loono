import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/checkbox.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

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
  final Finder cancelBtnDeleteAccountDialog =
      find.byKey(const Key('deleteAccountPage_confirmationDialog_cancelBtn'));
  final Finder yesBtnDeleteAccountDialog =
      find.byKey(const Key('deleteAccountPage_confirmationDialog_yesBtn'));
  final Finder closeScreenBtn = find.byIcon(Icons.close);

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

  bool isCheckBoxChecked(Finder finder) {
    final checkBox = tester.widget<CheckboxCustom>(finder);
    return checkBox.isChecked;
  }

  Future<void> clickDeleteAccountButton() async {
    logTestEvent();
    await tester.tap(deleteAccountBtn);
    await tester.pumpAndSettle();
  }

  Future<void> cancelDeleteAccountDialog() async {
    logTestEvent();
    await tester.tap(cancelBtnDeleteAccountDialog);
    await tester.pumpAndSettle();
  }

  Future<void> confirmDeleteAccountDialog() async {
    logTestEvent();
    await tester.tap(yesBtnDeleteAccountDialog);
    await tester.pumpAndSettle();
    await tester.pumpUntilNotVisible(yesBtnDeleteAccountDialog);
  }

  Future<void> clickCloseScreenButton() async {
    logTestEvent();
    await tester.tap(closeScreenBtn);
    await tester.pumpAndSettle();
  }
}
