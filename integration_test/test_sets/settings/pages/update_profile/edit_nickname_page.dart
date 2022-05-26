import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/settings/edit_nickname.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [EditNicknameScreen]
class EditNicknamePage with SettingsFinders {
  EditNicknamePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder backBtn = find.byKey(const Key('settingsAppBar_backButton'));
  final Finder closeBtn = find.byKey(const Key('settingsAppBar_closeButton'));
  final Finder textField = find.byType(TextField);
  final Finder saveBtn = find.widgetWithText(AsyncLoonoButton, 'Uložit');

  /// Page methods
  Future<void> insertNickname(String nickname) async {
    logTestEvent('Insert nickname: "$nickname"');
    await tester.enterText(textField, nickname);
    if (nickname.length <= MAX_ALLOWED_INPUT_FORM_LENGTH) {
      await tester.pumpUntilFound(find.text(nickname));
    } else {
      await tester.pumpUntilFound(find.textContaining(nickname.substring(0, 50)));
    }
  }

  void checkInputTextIsValid() {
    logTestEvent();
    final textFieldWidget = tester.widget<TextField>(textField);
    expect(textFieldWidget.controller!.text.length <= MAX_ALLOWED_INPUT_FORM_LENGTH, true);
  }

  Future<void> clickSaveButton() async {
    logTestEvent();
    await tester.tap(saveBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickBackButton() async {
    logTestEvent();
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickCloseButton() async {
    logTestEvent();
    await tester.tap(closeBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(EditNicknameScreen));
  }
}
