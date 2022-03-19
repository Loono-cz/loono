import 'package:charlatan/charlatan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/about_health/about_health.dart';
import 'package:loono/ui/screens/find_doctor/find_doctor.dart';
import 'package:loono/ui/screens/main/pre_auth/login.dart';
import 'package:loono/ui/screens/main/pre_auth/pre_auth_main_screen.dart';
import 'package:loono/ui/screens/main/pre_auth/start_new_questionnaire.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_second.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/welcome.dart';
import 'package:loono/ui/widgets/intro_video.dart';

import '../../../../setup.dart' as app;
import '../../../app/pages/login_page.dart';
import '../../../app/pages/pre_auth_main_screen_page.dart';
import '../../../app/pages/welcome_page.dart';
import '../../../app/test_data/fake_healthcare_provider_response.dart';
import '../../pages/intro_video_page.dart';
import '../../pages/second_carousel_page.dart';
import '../../pages/start_new_questionnaire_page.dart';

/// [Test case link](https://cesko-digital.atlassian.net/browse/LOON-542)
Future<void> run({required WidgetTester tester, required Charlatan charlatan}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.runMockApp(charlatan: charlatan);
  charlatan.whenGet('/providers/all', (_) => HEALTHCARE_PROVIDER_ENCODED);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 3));

  final welcomePage = WelcomePage(tester);
  final introVideoPage = IntroVideoPage(tester);
  final secondCarouselPage = SecondCarouselPage(tester);
  final startNewQuestionnairePage = StartNewQuestionnairePage(tester);
  final preAuthMainScreenPage = PreAuthMainScreenPage(tester);
  final loginPage = LoginPage(tester);

  // navigate to StartNewQuestionnaireScreen in Pre-auth Main screen through Carousel screens
  expect(find.byType(WelcomeScreen), findsOneWidget);
  await welcomePage.clickStartButton();
  await introVideoPage.waitForVideoLoad();
  expect(find.byType(IntroVideo), findsOneWidget);
  introVideoPage.checkVideoIsMuted();
  await introVideoPage.replayVideo();

  await introVideoPage.clickContinueBtn();
  expect(find.byType(OnboardingSecondCarouselScreen), findsOneWidget);

  await secondCarouselPage.clickContinueBtn();
  expect(find.byType(PreAuthMainScreen), findsOneWidget);
  expect(find.byType(StartNewQuestionnaireScreen), findsOneWidget);

  // check route 'Už mám účet' is working in StartNewQuestionnaireScreen (regression test for LOON-522)
  await startNewQuestionnairePage.clickAlreadyHaveAnAccountButton();
  expect(find.byType(LoginScreen), findsOneWidget);

  // check other Bottom Navigation Tabs
  await preAuthMainScreenPage.clickFindDoctorTab();
  expect(find.byType(FindDoctorScreen), findsOneWidget);

  await preAuthMainScreenPage.clickAboutHealthTab();
  expect(find.byType(AboutHealthScreen), findsOneWidget);

  await preAuthMainScreenPage.clickPreventionTab();
  expect(find.byType(LoginScreen), findsOneWidget);

  // start questionnaire
  await loginPage.clickCreateNewAccountButton();
  expect(find.byType(OnboardingGenderScreen), findsOneWidget);
}
