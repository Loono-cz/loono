import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/find_doctor/find_doctor.dart';
import 'package:loono/ui/screens/prevention/prevention.dart';
import 'package:loono_api/loono_api.dart';

import '../../../../../setup.dart' as app;
import '../../../../../test_helpers/widget_tester_extensions.dart';
import '../../../../app/flows/login_flow.dart';
import '../../../../app/pages/post_auth_main_screen_page.dart';
import '../../../../app/test_data/default_test_data.dart';
import '../../../pages/prevention_main_page.dart';
import '../../../pages/self_examination/detail/self_examination_detail_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-568)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
  required FirebaseAuth firebaseAuth,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final preventionMainPage = PreventionPage(tester);
  final selfExaminationDetailPage = SelfExaminationDetailPage(tester);
  final mainScreenPage = PostAuthMainScreenPage(tester);

  await app.runMockApp(firebaseAuthOverride: firebaseAuth, charlatan: charlatan);
  await loginFlow(
    tester: tester,
    charlatan: charlatan,
    accountData: defaultFemaleAccount,
    examinationsData: defaultFemaleExaminations,
  );

  await preventionMainPage.clickSelfExaminationCard(SelfExaminationType.BREAST);
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
  await tester.pumpUntilFound(find.byType(FindDoctorScreen));
  mainScreenPage.verifyBottomBarIsShown();

  await mainScreenPage.clickPreventionTab();
  await tester.pumpUntilFound(find.byType(PreventionScreen));
}
