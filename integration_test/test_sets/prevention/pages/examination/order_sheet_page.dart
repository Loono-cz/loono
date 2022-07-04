import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';
import 'package:loono/ui/widgets/prevention/examination_new_sheet.dart';

import '../../../../test_helpers/e2e_action_logging.dart';
import '../../../../test_helpers/widget_tester_extensions.dart';

/// Corresponding sheets: [showNewCheckupSheetStep1] or [showNewCheckupSheetStep2],
/// invoked from the: [ExaminationDetailScreen].
class OrderSheetPage {
  OrderSheetPage(this.tester);

  final WidgetTester tester;

  // Page finders
  final Finder orderSheet1 = find.byKey(const Key('examinationDetailPage_orderSheet'));
  final Finder alreadyHaveDoctorOrderSheet1Btn =
      find.byKey(const Key('examinationDetailPage_orderSheet_btn_alreadyHaveDoctor'));
  final Finder dontHaveDoctorOrderSheet1Btn =
      find.byKey(const Key('examinationDetailPage_orderSheet_btn_dontHaveDoctor'));

  final Finder orderInstructionsSheet2 = find.byKey(const Key('examinationDetailPage_orderSheet2'));
  final Finder haveAppointmentSheet2Btn =
      find.byKey(const Key('examinationDetailPage_orderSheet2_btn_haveAppointment'));

  // Page methods
  Future<void> clickAlreadyHaveDoctorSheet1Button() async {
    logTestEvent();
    await tester.tap(alreadyHaveDoctorOrderSheet1Btn);
    await tester.pumpAndSettle();
  }

  Future<void> clickDontHaveDoctorSheet1Button() async {
    logTestEvent();
    await tester.tap(dontHaveDoctorOrderSheet1Btn);
    await tester.pumpAndSettle();
  }

  Future<void> clickIHaveAppointmentSheet2Button() async {
    logTestEvent();
    await tester.tap(haveAppointmentSheet2Btn);
    await tester.pumpAndSettle();
  }

  Future<void> verifyHaveDoctorSheet1IsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(orderSheet1);
  }

  Future<void> verifyInstructionSheet2IsShown() async {
    logTestEvent();
    await tester.pumpUntilFound(orderInstructionsSheet2);
  }
}
