import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';

import '../../../../setup.dart' as app;
import '../../../app/pages/achievement_page.dart';
import '../../../app/pages/login_page.dart';
import '../../../app/pages/welcome_page.dart';
import '../../../app/test_data/default_test_data.dart';
import '../../pages/continue_questionnaire_page.dart';
import '../../pages/onboarding_form_done_page.dart';
import '../../pages/questionnaire/birthdate_page.dart';
import '../../pages/questionnaire/doctor_cca_last_visit_page.dart';
import '../../pages/questionnaire/doctor_date_picker_page.dart';
import '../../pages/questionnaire/fill_form_later_page.dart';
import '../../pages/questionnaire/gender_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-543)
Future<void> run({required WidgetTester tester, required Charlatan charlatan}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  charlatan.whenGet('/providers/all', (_) => ENCODED_SINGLE_HEALTHCARE_PROVIDER);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 3));

  final welcomePage = WelcomePage(tester);
  final continueQuestionnairePage = ContinueQuestionnairePage(tester);
  final loginPage = LoginPage(tester);
  final fillFormLaterPage = FillFormLaterPage(tester);
  final questionnaireGenderPage = QuestionnaireGenderPage(tester);
  final questionnaireBirthDatePage = QuestionnaireBirthDatePage(tester);
  final questionnaireDoctorCcaLastVisitPage = QuestionnaireDoctorCcaLastVisitPage(tester);
  final questionnaireAchievementPage = QuestionnaireAchievementPage(tester);
  final questionnaireDoctorDatePickerPage = QuestionnaireDoctorDatePickerPage(tester);
  final onboardingFormDonePage = OnboardingFormDonePage(tester);

  // start questionnaire
  await welcomePage.verifyScreenIsShown();
  await welcomePage.clickLoginButton();
  await loginPage.verifyScreenIsShown();

  await loginPage.clickCreateNewAccountButton();
  await questionnaireGenderPage.verifyScreenIsShown();

  // skip onboarding form
  await questionnaireGenderPage.clickSkipQuestionnaireButton();
  await fillFormLaterPage.verifyScreenIsShown();

  await fillFormLaterPage.clickFillFormLaterButton();
  await continueQuestionnairePage.verifyScreenIsShown();

  // check questionnaire progress on the PreAuthMainScreen, should not have any / should be 0
  continueQuestionnairePage.verifyProgressBarDoesNotHaveAnyProgress();
  expect(continueQuestionnairePage.isProgressBarValueEqualTo(0), true);

  // continue onboarding form, should return to Gender Screen
  await continueQuestionnairePage.clickContinueFormButton();
  await questionnaireGenderPage.verifyScreenIsShown();

  // choose and pick MALE, should transition to Birthdate screen
  questionnaireGenderPage.verifyContinueButtonState(isEnabled: false);
  await questionnaireGenderPage.chooseMaleGender();
  questionnaireGenderPage.verifyContinueButtonState(isEnabled: true);

  await questionnaireGenderPage.clickContinueButton();
  await questionnaireBirthDatePage.verifyScreenIsShown();
  expect(find.text('Kdy ses narodil?'), findsOneWidget);

  // skip onboarding form, progress bar should have now progress
  await questionnaireBirthDatePage.clickSkipQuestionnaireButton();
  await fillFormLaterPage.verifyScreenIsShown();

  await fillFormLaterPage.clickFillFormLaterButton();
  await continueQuestionnairePage.verifyScreenIsShown();
  continueQuestionnairePage.verifyProgressBarHasAnyProgress();

  // continue onboarding form, should return to BirthDate screen
  await continueQuestionnairePage.clickContinueFormButton();
  await questionnaireBirthDatePage.verifyScreenIsShown();

  await questionnaireBirthDatePage.clickContinueButton();
  await questionnaireDoctorCcaLastVisitPage.verifyScreenIsShown(
    expectedScreen: OnboardingGeneralPracticionerScreen,
  );

  // "more than X years" button should transition to next doctor
  await questionnaireDoctorCcaLastVisitPage.clickMoreThanXYearsOrIdkButton(
    expectedNextScreen: OnboardingDentistScreen,
  );

  // "in last X years" should transition to achievement screen, date picker screen
  await questionnaireDoctorCcaLastVisitPage.clickInLastXYearsButton(
    expectedNextScreen: DentistAchievementScreen,
  );

  await questionnaireAchievementPage.clickContinueButton();
  await questionnaireDoctorDatePickerPage.verifyScreenIsShown(expectedScreen: DentistDateScreen);
  await questionnaireDoctorDatePickerPage.clickContinueButton();

  // final route, onboarding is completed 🎉
  // TODO: check saved values in DB
  await onboardingFormDonePage.verifyScreenIsShown();
}
