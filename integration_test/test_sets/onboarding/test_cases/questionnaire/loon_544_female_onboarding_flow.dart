import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/gynecology_achievement.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology_date.dart';

import '../../../../setup.dart' as app;
import '../../../app/pages/achievement_page.dart';
import '../../../app/pages/login_page.dart';
import '../../../app/pages/welcome_page.dart';
import '../../../app/test_data/fake_healthcare_provider_response.dart';
import '../../pages/onboarding_form_done_page.dart';
import '../../pages/questionnaire/birthdate_page.dart';
import '../../pages/questionnaire/doctor_cca_last_visit_page.dart';
import '../../pages/questionnaire/doctor_date_picker_page.dart';
import '../../pages/questionnaire/gender_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-544)
Future<void> run({required WidgetTester tester, required Charlatan charlatan}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  charlatan.whenGet('/providers/all', (_) => HEALTHCARE_PROVIDER_ENCODED);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 3));

  final welcomePage = WelcomePage(tester);
  final loginPage = LoginPage(tester);
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

  // choose and pick FEMALE, should transition to Birthdate screen
  questionnaireGenderPage.verifyContinueButtonState(isEnabled: false);
  await questionnaireGenderPage.chooseFemaleGender();
  questionnaireGenderPage.verifyContinueButtonState(isEnabled: true);

  await questionnaireGenderPage.clickContinueButton();
  await questionnaireBirthDatePage.verifyScreenIsShown();
  expect(find.text('Kdy ses narodila?'), findsOneWidget);

  await questionnaireBirthDatePage.clickContinueButton();
  await questionnaireDoctorCcaLastVisitPage.verifyScreenIsShown(
    expectedScreen: OnboardingGeneralPracticionerScreen,
  );

  // "more than X years" button should transition to next doctor
  await questionnaireDoctorCcaLastVisitPage.clickMoreThanXYearsOrIdkButton(
    expectedNextScreen: OnboardingGynecologyScreen,
  );

  // "in last X years" should transition to achievement screen, date picker screen
  await questionnaireDoctorCcaLastVisitPage.clickInLastXYearsButton(
    expectedNextScreen: GynecologyAchievementScreen,
  );

  await questionnaireAchievementPage.clickContinueButton();
  await questionnaireDoctorDatePickerPage.verifyScreenIsShown(expectedScreen: GynecologyDateScreen);

  // clicking 'Dont know' button should transition to next doctor
  await questionnaireDoctorDatePickerPage.clickIdkButton();
  await questionnaireDoctorCcaLastVisitPage.verifyScreenIsShown(
    expectedScreen: OnboardingDentistScreen,
  );

  // "in last X years" should transition to achievement screen, date picker screen
  await questionnaireDoctorCcaLastVisitPage.clickInLastXYearsButton(
    expectedNextScreen: DentistAchievementScreen,
  );

  await questionnaireAchievementPage.clickContinueButton();
  await questionnaireDoctorDatePickerPage.verifyScreenIsShown(
    expectedScreen: DentistDateScreen,
  );

  // last doctor: clicking 'Dont know' button should transition to OnboardingFormDoneScreen
  await questionnaireDoctorDatePickerPage.clickIdkButton();
  await onboardingFormDonePage.verifyScreenIsShown();
}
