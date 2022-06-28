import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';

import '../../../test_helpers/e2e_action_logging.dart';
import '../../../test_helpers/widget_tester_extensions.dart';
import '../pages/examination/date_picker_sheet_page.dart';
import '../pages/examination/examination_detail_page.dart';
import '../pages/examination/order_sheet_page.dart';

/// Flows starts on [ExaminationDetailScreen] and ends on [ExaminationDetailScreen].
Future<void> newAppointmentFlow({
  required WidgetTester tester,
}) async {
  final examinationDetailPage = ExaminationDetailPage(tester);
  final orderSheetPage = OrderSheetPage(tester);
  final datePickerSheetPage = DatePickerSheetPage(tester);

  logCustomTestEvent('Running "New appointment flow" ...');
  await examinationDetailPage.clickOrderButton();
  await orderSheetPage.verifyHaveDoctorSheet1IsShown();

  await orderSheetPage.clickAlreadyHaveDoctorSheet1Button();
  await orderSheetPage.verifyInstructionSheet2IsShown();

  await orderSheetPage.clickIHaveAppointmentSheet2Button();
  await datePickerSheetPage.verifyDatePickerSheetIsShown();

  datePickerSheetPage.verifyDatePickerIsShown();
  await datePickerSheetPage.datePickerSheetPickNextMonth();
  await datePickerSheetPage.clickDatePickerSheetContinueButton();

  await datePickerSheetPage.verifyDatePickerSheetIsShown();
  datePickerSheetPage.verifyTimePickerIsShown();

  await datePickerSheetPage.clickDatePickerSheetContinueButton();
  await tester.waitForToastToDisappear(msgPattern: 'připomeneme');

  await examinationDetailPage.verifyScreenIsShown();
  examinationDetailPage.verifyCalendarButtonIsShown();
  logCustomTestEvent('Ending "New appointment flow".');
}
