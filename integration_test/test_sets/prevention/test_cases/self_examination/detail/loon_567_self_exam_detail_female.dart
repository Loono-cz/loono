import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono_api/loono_api.dart';

import '../../../../../setup.dart' as app;
import '../../../../app/flows/login_flow.dart';
import '../../../../app/test_data/default_test_data.dart';
import '../../../pages/prevention_main_page.dart';
import '../../../pages/self_examination/detail/self_examination_detail_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-567)
Future<void> run({
  required WidgetTester tester,
  required Charlatan charlatan,
}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final preventionPage = PreventionPage(tester);
  final selfExaminationDetailPage = SelfExaminationDetailPage(tester);

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

  selfExaminationDetailPage
    ..verifyHeaderText('Samovyšetření\nprsu')
    ..verifyImageIsShown()
    ..verifyIntervalText('JEDNOU ZA MĚSÍC')
    ..verifyRewardProgressBarIsShown()
    ..verifySelfExaminationPerformedButtonText('Vyšetřila jsem se')
    ..verifySelfExaminationPerformedButtonState(isEnabled: true)
    ..verifyFaqSectionIsShown()
    ..verifyFaqQuestionsAreShown();

  // TODO click reward progress bar -> modal sheet shows - modal is missing

  await selfExaminationDetailPage.verifySelfExamFaqContentIsCollapsed(itemPosition: 1);
  await selfExaminationDetailPage.verifySelfExamFaqContentIsCollapsed(itemPosition: 2);

  await selfExaminationDetailPage.clickSelfExamFaqItem(itemPosition: 1);
  await selfExaminationDetailPage.verifySelfExamFaqContentIsExpanded(itemPosition: 1);

  await selfExaminationDetailPage.clickSelfExamFaqItem(itemPosition: 2);
  await selfExaminationDetailPage.verifySelfExamFaqContentIsExpanded(itemPosition: 2);

  await selfExaminationDetailPage.clickSelfExamFaqItem(itemPosition: 1);
  await selfExaminationDetailPage.verifySelfExamFaqContentIsCollapsed(itemPosition: 1);

  await selfExaminationDetailPage.clickBackButton();
  await preventionPage.verifyScreenIsShown();
}
