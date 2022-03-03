import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

class FillFormLaterPage {
  FillFormLaterPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder continueFormButton = find.widgetWithText(LoonoButton, 'Pokračovat v dotazníku');
  final Finder fillLaterBtn = find.widgetWithText(LoonoButton, 'Dokončit později');

  /// Page methods
  Future<void> clickContinueFormButton() async {
    await tester.tap(continueFormButton);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
  }

  Future<void> clickFillLaterFormButton() async {
    await tester.tap(fillLaterBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
  }
}
