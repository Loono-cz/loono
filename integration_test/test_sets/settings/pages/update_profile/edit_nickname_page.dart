import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/fallback_account_content.dart';

class EditNicknamePage {
  EditNicknamePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder backBtn = find.byKey(const Key('settingsAppBar_backButton'));
  final Finder closeBtn = find.byKey(const Key('settingsAppBar_closeButton'));
  final Finder textField = find.byType(TextField);
  final Finder saveBtn = find.widgetWithText(AsyncLoonoButton, 'Uložit');

  /// Page methods
  Future<void> insertNickname(String nickname) async {
    await tester.enterText(textField, nickname);
    await tester.pumpAndSettle();
  }

  void checkInputTextIsValid() {
    final textFieldWidget = tester.widget<TextField>(textField);
    expect(textFieldWidget.controller!.text.length <= MAX_ALLOWED_INPUT_FORM_LENGTH, true);
  }

  Future<void> clickSaveButton() async {
    await tester.tap(saveBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickBackButton() async {
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickCloseButton() async {
    await tester.tap(closeBtn);
    await tester.pumpAndSettle();
  }
}
