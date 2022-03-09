import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../../test_helpers/widget_tester_extensions.dart';

class FillFormLaterPage {
  FillFormLaterPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder continueFormButton = find.widgetWithText(LoonoButton, 'Pokračovat v dotazníku');
  final Finder fillLaterBtn = find.widgetWithText(LoonoButton, 'Dokončit později');

  /// Page methods
  Future<void> clickContinueFormButton() async {
    await tester.tap(continueFormButton);
    await tester.pumpSettleAndWait(seconds: 2);
  }

  Future<void> clickFillFormLaterButton() async {
    await tester.tap(fillLaterBtn);
    await tester.pumpSettleAndWait(seconds: 2);
  }
}
