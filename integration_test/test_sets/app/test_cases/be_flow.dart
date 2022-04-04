import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/main/pre_auth/login.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/settings/edit_email.dart';
import 'package:loono/ui/screens/settings/leaderboard.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/points_help.dart';
import 'package:loono/ui/screens/welcome.dart';
import 'package:loono/ui/widgets/prevention/self_examination/self_examination_card.dart';
import 'package:loono_api/loono_api.dart';

import '../../../setup.dart' as app;
import '../../../test_helpers/widget_tester_extensions.dart';
import '../../onboarding/pages/gamification_introduction_page.dart';
import '../../onboarding/pages/onboarding_form_done_page.dart';
import '../../onboarding/pages/questionnaire/achievement_page.dart';
import '../../onboarding/pages/questionnaire/birthdate_page.dart';
import '../../onboarding/pages/questionnaire/doctor_cca_last_visit_page.dart';
import '../../onboarding/pages/questionnaire/doctor_date_picker_page.dart';
import '../../onboarding/pages/questionnaire/gender_page.dart';
import '../../onboarding/pages/sign_up_email_page.dart';
import '../../onboarding/pages/sign_up_nickname_page.dart';
import '../../prevention/pages/prevention_main_page.dart';
import '../../prevention/pages/self_examination/detail/how_it_went_modal_page.dart';
import '../../prevention/pages/self_examination/detail/no_finding_reward_page.dart';
import '../../prevention/pages/self_examination/detail/self_examination_detail_page.dart';
import '../../settings/pages/open_settings_page.dart';
import '../../settings/pages/points/points_help_page.dart';
import '../../settings/pages/update_profile/edit_email_page.dart';
import '../../settings/pages/update_profile/update_profile_page.dart';
import '../pages/login_page.dart';
import '../pages/welcome_page.dart';

/*
This simple flow tests:
1. Proceed through the onboarding form
2. Perform sign up with Firebase and send onboarding data via Onboarding API
3. Verify account is created and receives badge(s) and gets valid list of check-ups
4. Verify the user can successfully perform a self-examination and gets rewards from it
5. Verify account details can be changed in the Settings
 */
Future<void> run({required WidgetTester tester}) async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.main();

  final welcomePage = WelcomePage(tester);
  final loginPage = LoginPage(tester);
  final questionnaireGenderPage = QuestionnaireGenderPage(tester);
  final questionnaireBirthDatePage = QuestionnaireBirthDatePage(tester);
  final questionnaireDoctorCcaLastVisitPage = QuestionnaireDoctorCcaLastVisitPage(tester);
  final questionnaireAchievementPage = QuestionnaireAchievementPage(tester);
  final questionnaireDoctorDatePickerPage = QuestionnaireDoctorDatePickerPage(tester);
  final onboardingFormDonePage = OnboardingFormDonePage(tester);
  final signUpNicknamePage = SignUpNicknamePage(tester);
  final signUpEmailPage = SignUpEmailPage(tester);
  final gamificationIntroductionPage = GamificationIntroductionPage(tester);

  final preventionMainPage = PreventionPage(tester);
  final selfExaminationDetailPage = SelfExaminationDetailPage(tester);
  final howItWentModalPage = HowItWentModalPage(tester);
  final noFindingRewardPage = NoFindingRewardPage(tester);

  final openSettingsPage = OpenSettingsPage(tester);
  final updateProfilePage = UpdateProfilePage(tester);
  final editEmailPage = EditEmailPage(tester);
  final pointsHelpPage = PointsHelpPage(tester);

  // start questionnaire and create a new account
  await tester.pumpUntilVisible(find.byType(WelcomeScreen));

  await welcomePage.clickLoginButton();
  await tester.pumpUntilVisible(find.byType(LoginScreen));

  await loginPage.clickCreateNewAccountButton();
  await tester.pumpUntilVisible(find.byType(OnboardingGenderScreen));

  await questionnaireGenderPage.chooseMaleGender();
  await questionnaireGenderPage.clickContinueButton();

  await tester.pumpUntilVisible(find.byType(OnBoardingBirthdateScreen));
  expect(find.text('Kdy ses narodil?'), findsOneWidget);

  await questionnaireBirthDatePage.clickContinueButton();
  await tester.pumpUntilVisible(find.byType(OnboardingGeneralPracticionerScreen));

  await questionnaireDoctorCcaLastVisitPage.clickMoreThanXYearsOrIdkButton(
    nextScreen: OnboardingDentistScreen,
  );

  await questionnaireDoctorCcaLastVisitPage.clickInLastXYearsButton(
    nextScreen: DentistAchievementScreen,
  );

  await questionnaireAchievementPage.clickContinueButton();
  await tester.pumpUntilVisible(find.byType(DentistDateScreen));

  await questionnaireDoctorDatePickerPage.clickIdkButton();
  await onboardingFormDonePage.verifyScreenIsShown();

  await onboardingFormDonePage.clickLoginWithGoogleButton();
  await signUpNicknamePage.verifyScreenIsShown();

  await signUpNicknamePage.insertNickname('be_test_${DateTime.now().toIso8601String()}');
  await signUpNicknamePage.clickConfirmButton();
  await signUpEmailPage.verifyScreenIsShown();

  await signUpEmailPage.insertEmail('backend.test@loono.cz');
  await signUpEmailPage.clickCreateAccountButton();

  await gamificationIntroductionPage.verifyScreenIsShown();
  expect(
    tester.takeException().toString(),
    contains('A RenderFlex overflowed'), // silence overflow issue
  );
  await gamificationIntroductionPage.clickContinueButton();
  await preventionMainPage.verifyScreenIsShown();

  // verify some data are fetched from api GET /examinations
  await tester.pumpUntilVisible(find.byType(SelfExaminationCard));
  preventionMainPage
    ..verifyHasBadge(BadgeType.HEADBAND)
    ..verifyDoesNotHaveBadge(BadgeType.SHIELD)
    ..verifyHasPoints(300); // HEADBAND and points are reward from the Dentist visit
  await preventionMainPage.verifySelfExaminationCardIsInCategory(
    SelfExaminationType.TESTICULAR,
    expectedCategoryName: 'Vyšetři se',
  );

  // perform self examination with OK status
  await preventionMainPage.clickSelfExaminationCard(SelfExaminationType.TESTICULAR);
  await selfExaminationDetailPage.verifyScreenIsShown();

  await selfExaminationDetailPage.clickSelfExaminationPerformedButton();
  howItWentModalPage.verifyModalIsShown();

  await howItWentModalPage.clickOkButton();
  await noFindingRewardPage.verifyScreenIsShown();
  expect(
    tester.takeException().toString(),
    contains('This library only supports <defs> and'), // just a SVG asset error
  );

  await noFindingRewardPage.clickContinueButton();
  await preventionMainPage.verifyScreenIsShown();

  await preventionMainPage.verifySelfExaminationCardIsInCategory(
    SelfExaminationType.TESTICULAR,
    expectedCategoryName: 'Připomenu ti vyšetření',
  );
  preventionMainPage
    ..verifyHasBadge(BadgeType.HEADBAND)
    ..verifyHasBadge(BadgeType.SHIELD)
    ..verifyHasPoints(350); // +50 points and shield from the performed self examination

  // edit email
  await preventionMainPage.clickProfileAvatar();
  expect(find.byType(OpenSettingsScreen), findsOneWidget);

  await openSettingsPage.clickEditProfileButton();
  await updateProfilePage.verifyScreenIsShown();
  updateProfilePage.verifyEmail('backend.test@loono.cz');

  await updateProfilePage.clickEmailField();
  expect(find.byType(EditEmailScreen), findsOneWidget);

  await editEmailPage.insertEmail('backend.test.edited@loono.cz');
  await editEmailPage.clickSaveButton();
  await updateProfilePage.verifyScreenIsShown();
  updateProfilePage.verifyEmail('backend.test.edited@loono.cz');

  await updateProfilePage.clickBackButton();
  await openSettingsPage.verifyScreenIsShown();

  // check leaderboard
  await openSettingsPage.clickPointsHelpButton();
  expect(find.byType(PointsHelpScreen), findsOneWidget);

  await pointsHelpPage.clickBackButton();
  expect(find.byType(OpenSettingsScreen), findsOneWidget);

  await openSettingsPage.clickLeaderboardButton();
  expect(find.byType(LeaderboardScreen), findsOneWidget);
  await tester.pump(const Duration(seconds: 4));
}
