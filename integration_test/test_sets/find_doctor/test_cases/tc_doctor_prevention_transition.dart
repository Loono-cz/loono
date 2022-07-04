import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono_api/loono_api.dart';

import '../../../setup.dart' as app;
import '../../app/flows/login_flow.dart';
import '../../prevention/pages/examination/examination_detail_page.dart';
import '../../prevention/pages/examination/order_sheet_page.dart';
import '../../prevention/pages/prevention_main_page.dart';
import '../pages/find_doctor_page.dart';

/// [Test case link description](https://cesko-digital.atlassian.net/browse/LOON-485)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  await loginFlow(tester: tester, charlatan: charlatan);

  final findDoctorPage = FindDoctorPage(tester);
  final preventionPage = PreventionPage(tester);
  final examinationDetailPage = ExaminationDetailPage(tester);
  final orderSheetPage = OrderSheetPage(tester);

  await preventionPage.clickExaminationCard(ExaminationType.GENERAL_PRACTITIONER);
  await examinationDetailPage.verifyScreenIsShown();

  await examinationDetailPage.clickOrderButton();
  await orderSheetPage.verifyHaveDoctorSheet1IsShown();

  await orderSheetPage.clickDontHaveDoctorSheet1Button();
  await findDoctorPage.verifyScreenIsShown();

  await findDoctorPage.clickCloseButton();
  await examinationDetailPage.verifyScreenIsShown();

  await examinationDetailPage.clickOrderButton();
  await orderSheetPage.verifyHaveDoctorSheet1IsShown();

  await orderSheetPage.clickDontHaveDoctorSheet1Button();
  await findDoctorPage.verifyScreenIsShown();

  await findDoctorPage.clickBackButton();
  await orderSheetPage.verifyHaveDoctorSheet1IsShown();
}
