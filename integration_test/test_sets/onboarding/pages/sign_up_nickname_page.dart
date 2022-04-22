import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/nickname.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [NicknameScreen]
class SignUpNicknamePage {
  SignUpNicknamePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder confirmBtn = find.text('Potvrdit');
  final Finder textField = find.byType(TextField);

  /// Page methods
  Future<void> insertNickname(String nickname) async {
    logTestEvent('Insert nickname: "$nickname"');
    await tester.enterText(textField, nickname);
    await tester.pumpAndSettle();
  }

  Future<void> clickConfirmButton() async {
    logTestEvent();
    await tester.tap(confirmBtn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(NicknameScreen));
  }
}
