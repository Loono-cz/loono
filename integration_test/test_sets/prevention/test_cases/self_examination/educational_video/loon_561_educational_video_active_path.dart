import 'package:charlatan/charlatan.dart';
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
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final preventionPage = PreventionPage(tester);
  final selfExaminationDetailPage = SelfExaminationDetailPage(tester);
  final educationalVideoPage = EducationalVideoPage(tester);
  final howItWentModalPage = HowItWentModalPage(tester);

  await app.runMockApp(charlatan: charlatan);
  await loginFlow(
    tester: tester,
    charlatan: charlatan,
    accountData: defaultFemaleAccount,
    examinationsData: defaultFemaleExaminations,
  );

  const selfExamType = SelfExaminationType.BREAST;
  await preventionPage.verifySelfExaminationCardIsInCategory(
    selfExamType,
    expectedCategoryName: 'Vyšetři se',
  );

  await preventionPage.clickSelfExaminationCard(selfExamType);
  await selfExaminationDetailPage.verifyScreenIsShown();

  await selfExaminationDetailPage.clickHowToSelfExamButton();
  await educationalVideoPage.verifyScreenIsShown();
  await educationalVideoPage.verifyVideoIsShown();
  educationalVideoPage.verifySelfExaminationPerformedButtonVisibilityState(isShown: true);

  await educationalVideoPage.clickSelfExamPerformedButton();
  await selfExaminationDetailPage.verifyScreenIsShown();
  await howItWentModalPage.verifyHowItWentModalVisibilityState(isShown: true);

  await howItWentModalPage.closeModal();
  await selfExaminationDetailPage.verifyScreenIsShown();
  await howItWentModalPage.verifyHowItWentModalVisibilityState(isShown: false);
}
