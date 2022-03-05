import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

class IntroVideoPage {
  IntroVideoPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder playAgainBtn = find.widgetWithText(LoonoButton, 'Přehrát znovu');
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');

  /// Page methods
  Future<void> clickPlayAgainBtn() async {
    await tester.tap(playAgainBtn);
    await tester.pump(const Duration(seconds: 1));
  }

  Future<void> clickContinueBtn() async {
    await tester.tap(continueBtn);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
  }
}
