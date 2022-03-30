import 'package:charlatan/charlatan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono_api/loono_api.dart';

import '../../../../../setup.dart' as app;
import '../../../../app/flows/login_flow.dart';
import '../../../../app/test_data/default_test_data.dart';
import '../../../pages/prevention_main_page.dart';
import '../../../pages/self_examination/detail/educational_video_page.dart';
import '../../../pages/self_examination/detail/how_it_went_modal_page.dart';
import '../../../pages/self_examination/detail/self_examination_detail_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-561)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
  required FirebaseAuth firebaseAuth,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final preventionMainPage = PreventionPage(tester);
  final selfExaminationDetailPage = SelfExaminationDetailPage(tester);
  final educationalVideoPage = EducationalVideoPage(tester);
  final howItWentModalPage = HowItWentModalPage(tester);

  await app.runMockApp(firebaseAuthOverride: firebaseAuth, charlatan: charlatan);
  await loginFlow(
    tester: tester,
    charlatan: charlatan,
    accountData: defaultFemaleAccount,
    examinationsData: defaultFemaleExaminations,
  );

  const selfExamType = SelfExaminationType.BREAST;
  await preventionMainPage.verifySelfExaminationCardIsInCategory(
    selfExamType,
    expectedCategoryName: 'Vyšetři se',
  );

  await preventionMainPage.clickSelfExaminationCard(selfExamType);
  await selfExaminationDetailPage.verifyScreenIsShown();

  await selfExaminationDetailPage.clickHowToSelfExamButton();
  await educationalVideoPage.verifyScreenIsShown();
  await educationalVideoPage.verifyVideoIsShown();
  educationalVideoPage.verifySelfExaminationPerformedButtonIsShown();

  await educationalVideoPage.clickSelfExamPerformedButton();
  await selfExaminationDetailPage.verifyScreenIsShown();
  howItWentModalPage.verifyModalIsShown();

  await howItWentModalPage.closeModal();
  await selfExaminationDetailPage.verifyScreenIsShown();
  howItWentModalPage.verifyModalIsNotShown();
}
