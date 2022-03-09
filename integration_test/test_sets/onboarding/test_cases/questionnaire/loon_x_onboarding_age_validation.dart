import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/main/pre_auth/continue_onboarding_form.dart';
import 'package:loono/ui/screens/main/pre_auth/login.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/fill_form_later.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/welcome.dart';

import '../../../../setup.dart' as app;
import '../../../app/pages/login_page.dart';
import '../../../app/pages/welcome_page.dart';
import '../../../app/test_data/fake_healthcare_provider_response.dart';
import '../../pages/continue_questionnaire_page.dart';
import '../../pages/questionnaire/birthdate_page.dart';
import '../../pages/questionnaire/fill_form_later_page.dart';
import '../../pages/questionnaire/gender_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-X)
Future<void> run({required WidgetTester tester, required Charlatan charlatan}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  charlatan.whenGet('/providers/all', (_) => HEALTHCARE_PROVIDER_ENCODED);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 3));

  final welcomePage = WelcomePage(tester);
  final loginPage = LoginPage(tester);
  final continueQuestionnairePage = ContinueQuestionnairePage(tester);
  final fillFormLaterPage = FillFormLaterPage(tester);
  final questionnaireGenderPage = QuestionnaireGenderPage(tester);
  final questionnaireBirthDatePage = QuestionnaireBirthDatePage(tester);

  expect(find.byType(WelcomeScreen), findsOneWidget);
  await welcomePage.clickLoginButton();
  expect(find.byType(LoginScreen), findsOneWidget);

  // start questionnaire
  await loginPage.clickCreateNewAccountButton();
  expect(find.byType(OnboardingGenderScreen), findsOneWidget);
  await questionnaireGenderPage.chooseMaleGender();
  await questionnaireGenderPage.clickContinueButton();
  expect(find.byType(OnBoardingBirthdateScreen), findsOneWidget);

  // when age < 19
  await questionnaireBirthDatePage.scrollToApproxYear(DateTime.now().year - 5);

  // TODO: check for SnackBar error message
  // should not transition to next screen - due to age
  await questionnaireBirthDatePage.clickContinueButton();
  expect(find.byType(OnBoardingBirthdateScreen), findsOneWidget);
  // wait for message to disappear
  await tester.pump(const Duration(seconds: 12));

  // skip onboarding form, progress bar should have progress
  await questionnaireBirthDatePage.clickSkipQuestionnaireButton();
  expect(find.byType(FillOnboardingFormLaterScreen), findsOneWidget);
  await fillFormLaterPage.clickFillFormLaterButton();
  expect(find.byType(ContinueOnboardingFormScreen), findsOneWidget);
  expect(continueQuestionnairePage.hasProgressBarAnyProgress(), true);
}
