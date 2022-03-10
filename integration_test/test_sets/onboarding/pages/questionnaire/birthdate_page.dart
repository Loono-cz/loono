import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';

import '../../../../test_helpers/common_shared_finders.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

class QuestionnaireBirthDatePage {
  QuestionnaireBirthDatePage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder skipQuestionnaireBtn = CommonSharedFinders.onboardingSkipQuestionnaireBtn;
  final Finder continueBtn = find.widgetWithText(LoonoButton, 'Pokračovat');
  final Finder yearPickerBox =
      find.byKey(Key('customDatePicker_${ColumnType.year.name}'), skipOffstage: false);

  /// Page methods
  Future<void> clickSkipQuestionnaireButton() async {
    await tester.tap(skipQuestionnaireBtn);
    await tester.pumpSettleAndWait(seconds: 1);
  }

  Future<void> clickContinueButton() async {
    await tester.tap(continueBtn);
    await tester.pumpSettleAndWait(seconds: 2);
  }

  Future<void> scrollToApproxYear(int year) async {
    final yearPicker = find.descendant(
      of: yearPickerBox,
      matching: find.byType(ListWheelScrollView),
    );
    final yearListWheel = tester.widget<ListWheelScrollView>(yearPicker);

    final yearListWheelController = yearListWheel.controller;
    expect(yearListWheelController, isNotNull);
    var scrollOffset = -200.0;
    while (true) {
      yearListWheelController!.jumpTo(scrollOffset);
      scrollOffset -= 100;
      final yearFinder = find.text(year.toString());
      if (tester.widgetList(yearFinder).isNotEmpty) break;
      await tester.pump(const Duration(milliseconds: 200));
    }
    await tester.pumpSettleAndWait(seconds: 2);
  }
}
