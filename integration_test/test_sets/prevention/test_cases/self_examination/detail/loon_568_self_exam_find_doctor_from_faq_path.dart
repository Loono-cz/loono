import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono_api/loono_api.dart';

import '../../../../../setup.dart' as app;
import '../../../../app/flows/login_flow.dart';
import '../../../../app/pages/post_auth_main_screen_page.dart';
import '../../../../app/test_data/default_test_data.dart';
import '../../../../find_doctor/pages/find_doctor_page.dart';
import '../../../pages/prevention_main_page.dart';
import '../../../pages/self_examination/detail/self_examination_detail_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-568)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final preventionPage = PreventionPage(tester);
  final selfExaminationDetailPage = SelfExaminationDetailPage(tester);
  final findDoctorPage = FindDoctorPage(tester);
  final mainScreenPage = PostAuthMainScreenPage(tester);

  await app.runMockApp(charlatan: charlatan);
  await loginFlow(
    tester: tester,
    charlatan: charlatan,
    accountData: defaultFemaleAccount,
    examinationsData: defaultFemaleExaminations,
  );

  await preventionPage.clickSelfExaminationCard(SelfExaminationType.BREAST);
  await selfExaminationDetailPage.verifyScreenIsShown();

  selfExaminationDetailPage
    ..verifyFaqSectionIsShown()
    ..verifyFaqQuestionsAreShown();

  await selfExaminationDetailPage.verifySelfExamFaqContentIsCollapsed(itemPosition: 1);

  await selfExaminationDetailPage.clickSelfExamFaqItem(itemPosition: 1);
  await selfExaminationDetailPage.verifySelfExamFaqContentIsExpanded(itemPosition: 1);

  await selfExaminationDetailPage.clickAtFaqContentText(
    itemPosition: 1,
    text: 'seznamu lékařů',
  );
  await findDoctorPage.verifyScreenIsShown();
  await mainScreenPage.verifyScreenIsShown();
  mainScreenPage.verifyBottomBarIsShown();

  await mainScreenPage.clickPreventionTab();
  await preventionPage.verifyScreenIsShown();
}
