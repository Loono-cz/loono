import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_detail.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/custom_time_picker.dart';

import '../../../../test_helpers/widget_tester_extensions.dart';

/// * Corresponding screen: [ExaminationDetailScreen]
class ExaminationDetailPage {
  ExaminationDetailPage(this.tester);

  final WidgetTester tester;

  /// Page finders
  final Finder backBtn = find.byKey(const Key('examinationDetailPage_btn_back'));
  final Finder orderBtn = find.byKey(const Key('examinationDetailPage_btn_order'));
  final Finder orderSheet = find.byKey(const Key('examinationDetailPage_orderSheet'));
  final Finder iHaveDoctorOrderSheetBtn =
      find.byKey(const Key('examinationDetailPage_orderSheet_btn_iHaveDoctor'));
  final Finder orderInstructionsSheet =
      find.byKey(const Key('examinationDetailPage_orderInstructionsSheet'));
  final Finder datePickerSheet = find.byKey(const Key('datePickerSheet'));
  final Finder datePickerSheetContinueBtn = find.byKey(const Key('datePickerSheet_btn_continue'));
  final Finder addToCalendarBtn = find.byKey(const Key('examinationDetailPage_btn_calendar'));
  final Finder updateDateBtn = find.byKey(const Key('examinationDetailPage_btn_updateDate'));

  /// Page methods
  Future<void> clickBackButton() async {
    logTestEvent();
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickOrderButton() async {
    logTestEvent();
    await tester.tap(orderBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickIHaveDoctorOrderSheetButton() async {
    logTestEvent();
    await tester.tap(iHaveDoctorOrderSheetBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickIHaveAppointmentOrderInstructionsSheetButton() async {
    logTestEvent();
    await tester.tap(find.textContaining('objednáno na konkrétní datum'));
    await tester.pumpAndSettle();
  }

  Future<void> clickDatePickerSheetContinueButton() async {
    logTestEvent();
    await tester.tap(datePickerSheetContinueBtn);
    await tester.pumpAndSettle();
  }

  Future<void> clickUpdateDateButton() async {
    logTestEvent();
    await tester.tap(updateDateBtn);
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

  void verifyOrderButtonIsShown() {
    logTestEvent();
    expect(orderBtn, findsOneWidget);
  }

  void verifyIsFirstAwaitingVisit() {
    logTestEvent();
    expect(find.byKey(const Key('examinationProgress_firstVisitAwaiting')), findsOneWidget);
  }

  void verifyCalendarButtonIsShown() {
    logTestEvent();
    expect(addToCalendarBtn, findsOneWidget);
  }

  Future<void> cancelCheckup() async {
    logTestEvent();
    await clickUpdateDateButton();
    logTestEvent('Choose "cancel check-up"');
    await tester.pumpUntilFound(find.byKey(const Key('editCheckUpDateSheet')));
    await tester.tap(find.text('Zrušit prohlídku'));
    await tester.pumpAndSettle();
    logTestEvent('Confirm cancellation of the check-up');
    await tester.pumpUntilFound(find.byKey(const Key('cancelCheckUpSheet')));
    await tester.tap(find.text('Zrušit prohlídku'));
    await tester.pumpAndSettle();
  }

  Future<void> verifyOrderSheetIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(orderSheet);
  }

  Future<void> verifyOrderInstructionsSheetIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(orderInstructionsSheet);
  }

  Future<void> verifyOrderDatePickerSheetIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(datePickerSheet);
  }

  Future<void> verifyScreenIsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(find.byType(ExaminationDetail));
  }
}
