import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/custom_time_picker.dart';
import 'package:loono/ui/widgets/prevention/datepicker_sheet.dart';

import '../../../../test_helpers/e2e_action_logging.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// Corresponding sheets: [showDatePickerSheet],
/// invoked from the: [ExaminationDetailScreen].
class DatePickerSheetPage {
  DatePickerSheetPage(this.tester);

  final WidgetTester tester;

  // Page finders
  final Finder datePickerSheet = find.byKey(const Key('datePickerSheet'));
  final Finder datePickerSheetContinueBtn = find.byKey(const Key('datePickerSheet_btn_continue'));
  final Finder datePickerSheetNoteInputField = find.byKey(const Key('note_input_field'));
  // Page methods
  Future<void> clickDatePickerSheetContinueButton() async {
    logTestEvent();
    await tester.tap(datePickerSheetContinueBtn);
    await tester.pumpAndSettle();
  }

  Future<void> datePickerSheetPickNextMonth() async {
    logTestEvent();
    final monthPicker = find.descendant(
      of: find.byKey(Key('customDatePicker_${ColumnType.month.name}'), skipOffstage: false),
      matching: find.byType(ListWheelScrollView),
    );
    final monthListWheel = tester.widget<ListWheelScrollView>(monthPicker);
    final monthListWheelController = monthListWheel.controller;
    expect(monthListWheelController, isNotNull);
    monthListWheelController!.jumpTo(20);
    await tester.pumpAndSettle();
  }

  void verifyDatePickerIsShown() {
    expect(find.byType(CustomDatePicker), findsOneWidget);
  }

  void verifyTimePickerIsShown() {
    expect(find.byType(CustomTimePicker), findsOneWidget);
  }

  Future<void> verifyDatePickerSheetIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(datePickerSheet);
  }

  Future<void> verifyNoteInputFieldIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(datePickerSheetNoteInputField);
  }
}
