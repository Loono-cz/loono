import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../setup.dart' as app;
import '../../../app/pages/login_page.dart';
import '../../../app/pages/welcome_page.dart';
import '../../../app/test_data/fake_healthcare_provider_response.dart';
import '../../pages/continue_questionnaire_page.dart';
import '../../pages/questionnaire/birthdate_page.dart';
import '../../pages/questionnaire/fill_form_later_page.dart';
import '../../pages/questionnaire/gender_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-558)
Future<void> run({required WidgetTester tester, required Charlatan charlatan}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  charlatan.whenGet('/providers/all', (_) => HEALTHCARE_PROVIDER_ENCODED);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1));

  final welcomePage = WelcomePage(tester);
  final loginPage = LoginPage(tester);
  final continueQuestionnairePage = ContinueQuestionnairePage(tester);
  final fillFormLaterPage = FillFormLaterPage(tester);
  final questionnaireGenderPage = QuestionnaireGenderPage(tester);
  final questionnaireBirthDatePage = QuestionnaireBirthDatePage(tester);

  await welcomePage.verifyScreenIsShown();
  await welcomePage.clickLoginButton();
  await loginPage.verifyScreenIsShown();

  // start questionnaire
  await loginPage.clickCreateNewAccountButton();
  await questionnaireGenderPage.verifyScreenIsShown();

  await questionnaireGenderPage.chooseMaleGender();
  await questionnaireGenderPage.clickContinueButton();
  await questionnaireBirthDatePage.verifyScreenIsShown();

  // when age < 19
  await questionnaireBirthDatePage.scrollToApproxYear(DateTime.now().year - 5);

  // TODO: check for SnackBar error message
  // should not transition to next screen - due to age
  await questionnaireBirthDatePage.clickContinueButton();
  await questionnaireBirthDatePage.verifyScreenIsShown();
  // wait for error message to disappear
  await tester.pump(const Duration(seconds: 8));
  await tester.pump(const Duration(seconds: 4));

  // skip onboarding form, progress bar should have progress
  await questionnaireBirthDatePage.clickSkipQuestionnaireButton();
  await fillFormLaterPage.verifyScreenIsShown();

  await fillFormLaterPage.clickFillFormLaterButton();
  await continueQuestionnairePage.verifyScreenIsShown();
  continueQuestionnairePage.verifyProgressBarHasAnyProgress();
}
