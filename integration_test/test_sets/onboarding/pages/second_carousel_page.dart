import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../test_helpers/widget_tester_extensions.dart';

class SecondCarouselPage {
  SecondCarouselPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');

  /// Page methods
  Future<void> clickContinueBtn() async {
    await tester.tap(continueBtn);
    await tester.pumpSettleAndWait(seconds: 2);
  }
}
