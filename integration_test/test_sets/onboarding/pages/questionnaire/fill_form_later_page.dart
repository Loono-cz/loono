import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';

import '../../../../test_helpers/common_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

class FillFormLaterPage with OnboardingFinders {
  FillFormLaterPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder continueFormButton = find.widgetWithText(LoonoButton, 'Pokračovat v dotazníku');
  final Finder fillLaterBtn = find.widgetWithText(LoonoButton, 'Dokončit později');

  /// Page methods
  Future<void> clickContinueFormButton() async {
    logTestEvent();
    await tester.tap(continueFormButton);
    await tester.pumpAndSettle();
  }

  Future<void> clickFillFormLaterButton() async {
    logTestEvent();
    await tester.tap(fillLaterBtn);
    await tester.pumpAndSettle();
  }
}
