import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/gynecology_achievement.dart';
import 'package:loono/ui/screens/main/pre_auth/login.dart';
import 'package:loono/ui/screens/main/pre_auth/onboarding_form_done.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology_date.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/welcome.dart';

import '../../../../setup.dart' as app;
import '../../../app/pages/login_page.dart';
import '../../../app/pages/welcome_page.dart';
import '../../../app/test_data/fake_healthcare_provider_response.dart';
import '../../pages/questionnaire/achievement_page.dart';
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

  // start questionnaire
  expect(find.byType(WelcomeScreen), findsOneWidget);
  await welcomePage.clickLoginButton();
  expect(find.byType(LoginScreen), findsOneWidget);
  await loginPage.clickCreateNewAccountButton();
  expect(find.byType(OnboardingGenderScreen), findsOneWidget);

  // choose and pick FEMALE, should transition to Birthdate screen
  expect(questionnaireGenderPage.isContinueButtonDisabled(), true);
  await questionnaireGenderPage.chooseFemaleGender();
  expect(questionnaireGenderPage.isContinueButtonDisabled(), false);

  await questionnaireGenderPage.clickContinueButton();
  expect(find.byType(OnBoardingBirthdateScreen), findsOneWidget);
  expect(find.text('Kdy ses narodila?'), findsOneWidget);

  await questionnaireBirthDatePage.clickContinueButton();
  expect(find.byType(OnboardingGeneralPracticionerScreen), findsOneWidget);

  // "more than X years" button should transition to next doctor
  await questionnaireDoctorCcaLastVisitPage.clickMoreThanXYearsOrIdkButton(
    nextScreen: OnboardingGynecologyScreen,
  );

  // "in last X years" should transition to achievement screen, date picker screen
  await questionnaireDoctorCcaLastVisitPage.clickInLastXYearsButton(
    nextScreen: GynecologyAchievementScreen,
  );

  await questionnaireAchievementPage.clickContinueButton();
  expect(find.byType(GynecologyDateScreen), findsOneWidget);

  // clicking 'Dont know' button should transition to next doctor
  await questionnaireDoctorDatePickerPage.clickIdkButton();
  expect(find.byType(OnboardingDentistScreen), findsOneWidget);

  // "in last X years" should transition to achievement screen, date picker screen
  await questionnaireDoctorCcaLastVisitPage.clickInLastXYearsButton(
    nextScreen: DentistAchievementScreen,
  );

  await questionnaireAchievementPage.clickContinueButton();
  expect(find.byType(DentistDateScreen), findsOneWidget);

  // last doctor: clicking 'Dont know' button should transition to OnboardingFormDoneScreen
  await questionnaireDoctorDatePickerPage.clickIdkButton();
  expect(find.byType(OnboardingFormDoneScreen), findsOneWidget);
}
