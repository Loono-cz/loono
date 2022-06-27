import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';

import '../../../test_helpers/e2e_action_logging.dart';
import '../pages/examination/edit_checkup_sheet_page.dart';
import '../pages/examination/examination_detail_page.dart';

/// Flows starts on [ExaminationDetailScreen] and ends on [ExaminationDetailScreen].
Future<void> cancelCheckUpFlow({
  required WidgetTester tester,
}) async {
  final examinationDetailPage = ExaminationDetailPage(tester);
  final editCheckUpSheetPage = EditCheckUpSheetPage(tester);

  logCustomTestEvent('Running "Cancel check-up flow" ...');
  await examinationDetailPage.clickUpdateDateButton();
  await editCheckUpSheetPage.verifyEditCheckUpSheetIsShown();
  await editCheckUpSheetPage.clickCancelCheckUpButton();
  await editCheckUpSheetPage.verifyCancelCheckUpSheetIsShown();
  await editCheckUpSheetPage.confirmCancelCheckUpButton();
  logCustomTestEvent('Ending "Cancel check-up flow".');
  await tester.pumpAndSettle();
}
