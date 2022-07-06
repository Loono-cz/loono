import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/about_health/about_health.dart';

import '../../../../setup.dart' as app;
import '../../../app/pages/login_page.dart';
import '../../../app/pages/pre_auth_main_screen_page.dart';
import '../../../app/pages/welcome_page.dart';
import '../../../app/test_data/default_test_data.dart';
import '../../../find_doctor/pages/find_doctor_page.dart';
import '../../pages/intro_video_page.dart';
import '../../pages/questionnaire/gender_page.dart';
import '../../pages/second_carousel_page.dart';
import '../../pages/start_new_questionnaire_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-542)
Future<void> run({required WidgetTester tester, required Charlatan charlatan}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  charlatan.whenGet('/providers/all', (_) => ENCODED_SINGLE_HEALTHCARE_PROVIDER);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 3));

  final welcomePage = WelcomePage(tester);
  final introVideoPage = IntroVideoPage(tester);
  final secondCarouselPage = SecondCarouselPage(tester);
  final startNewQuestionnairePage = StartNewQuestionnairePage(tester);
  final onboardingGenderPage = QuestionnaireGenderPage(tester);
  final preAuthMainScreenPage = PreAuthMainScreenPage(tester);
  final loginPage = LoginPage(tester);
  final findDoctorPage = FindDoctorPage(tester);

  // navigate to StartNewQuestionnaireScreen in Pre-auth Main screen through Carousel screens
  await welcomePage.verifyScreenIsShown();
  await welcomePage.clickStartButton();

  await introVideoPage.waitForVideoLoad();
  await introVideoPage.verifyScreenIsShown();
  introVideoPage.checkVideoIsMuted();
  // TODO: Veryfing behavior of replaying the video is very flaky.
  // await introVideoPage.replayVideo();

  await introVideoPage.clickContinueBtn();
  await secondCarouselPage.verifyScreenIsShown();

  await secondCarouselPage.clickContinueButton();
  await preAuthMainScreenPage.verifyScreenIsShown();
  await startNewQuestionnairePage.verifyScreenIsShown();

  // check route 'Už mám účet' is working in StartNewQuestionnaireScreen (regression test for LOON-522)
  await startNewQuestionnairePage.clickAlreadyHaveAnAccountButton();
  await loginPage.verifyScreenIsShown();

  // check other Bottom Navigation Tabs
  await preAuthMainScreenPage.clickFindDoctorTab();
  await findDoctorPage.verifyScreenIsShown();

  await preAuthMainScreenPage.clickAboutHealthTab();
  // TODO: POM
  expect(find.byType(AboutHealthScreen), findsOneWidget);

  await preAuthMainScreenPage.clickPreventionTab();
  await loginPage.verifyScreenIsShown();

  // start questionnaire
  await loginPage.clickCreateNewAccountButton();
  await onboardingGenderPage.verifyScreenIsShown();
}
