import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_detail.dart';
import 'package:loono/ui/screens/prevention/questionnaire/date_picker_screen.dart';
import 'package:loono/ui/screens/prevention/questionnaire/schedule_examination.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';
import 'package:loono/ui/widgets/prevention/self_examination/self_examination_card.dart';
import 'package:loono_api/loono_api.dart';

import '../../../setup.dart' as app;
import '../../../test_helpers/widget_tester_extensions.dart';
import '../../onboarding/pages/badge_overview_page.dart';
import '../../onboarding/pages/onboarding_form_done_page.dart';
import '../../onboarding/pages/questionnaire/birthdate_page.dart';
import '../../onboarding/pages/questionnaire/doctor_cca_last_visit_page.dart';
import '../../onboarding/pages/questionnaire/doctor_date_picker_page.dart';
import '../../onboarding/pages/questionnaire/gender_page.dart';
import '../../onboarding/pages/sign_up_email_page.dart';
import '../../onboarding/pages/sign_up_nickname_page.dart';
import '../../prevention/pages/examination/examination_detail_page.dart';
import '../../prevention/pages/prevention_main_page.dart';
import '../../prevention/pages/self_examination/detail/how_it_went_modal_page.dart';
import '../../prevention/pages/self_examination/detail/no_finding_reward_page.dart';
import '../../prevention/pages/self_examination/detail/self_examination_detail_page.dart';
import '../../settings/pages/open_settings_page.dart';
import '../../settings/pages/points/leaderboard_page.dart';
import '../../settings/pages/points/points_help_page.dart';
import '../../settings/pages/update_profile/edit_email_page.dart';
import '../../settings/pages/update_profile/update_profile_page.dart';
import '../pages/achievement_page.dart';
import '../pages/login_page.dart';
import '../pages/welcome_page.dart';

/*
This simple flow tests:
1. Proceed through the onboarding form
2. Perform sign up with Firebase and send onboarding data via Onboarding API
3. Verify account is created and receives badge(s) and gets valid list of check-ups
4. Verify the user can successfully perform a self-examination and gets rewards from it
5. Verify the user can fill missing check-ups
6. Verify the user order and cancel a check-up visit
7. Verify account details can be changed in the Settings
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
  final badgeOverviewPage = BadgeOverviewPage(tester);

  final preventionPage = PreventionPage(tester);
  final selfExaminationDetailPage = SelfExaminationDetailPage(tester);
  final examinationDetailPage = ExaminationDetailPage(tester);
  final howItWentModalPage = HowItWentModalPage(tester);
  final noFindingRewardPage = NoFindingRewardPage(tester);

  final openSettingsPage = OpenSettingsPage(tester);
  final updateProfilePage = UpdateProfilePage(tester);
  final editEmailPage = EditEmailPage(tester);
  final pointsHelpPage = PointsHelpPage(tester);
  final leaderboardPage = LeaderboardPage(tester);

  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 3));

  /// Start questionnaire and create a new account.
  await welcomePage.verifyScreenIsShown();

  await welcomePage.clickLoginButton();
  await loginPage.verifyScreenIsShown();

  await loginPage.clickCreateNewAccountButton();
  await questionnaireGenderPage.verifyScreenIsShown();

  await questionnaireGenderPage.chooseMaleGender();
  await questionnaireGenderPage.clickContinueButton();

  await tester.pumpUntilFound(find.byType(OnBoardingBirthdateScreen));
  expect(find.text('Kdy ses narodil?'), findsOneWidget);

  await questionnaireBirthDatePage.clickContinueButton();
  await questionnaireDoctorCcaLastVisitPage.verifyScreenIsShown(
    expectedScreen: OnboardingGeneralPracticionerScreen,
  );

  await questionnaireDoctorCcaLastVisitPage.clickMoreThanXYearsOrIdkButton(
    expectedNextScreen: OnboardingDentistScreen,
  );

  await questionnaireDoctorCcaLastVisitPage.clickInLastXYearsButton(
    expectedNextScreen: DentistAchievementScreen,
  );

  await questionnaireAchievementPage.clickContinueButton();
  await questionnaireDoctorDatePickerPage.verifyScreenIsShown(expectedScreen: DentistDateScreen);

  await questionnaireDoctorDatePickerPage.clickIdkButton();
  await onboardingFormDonePage.verifyScreenIsShown();

  await onboardingFormDonePage.clickLoginWithGoogleButton();
  await signUpNicknamePage.verifyScreenIsShown();

  await signUpNicknamePage.insertNickname('be_test_${DateTime.now().toIso8601String()}');
  await signUpNicknamePage.clickConfirmButton();
  await signUpEmailPage.verifyScreenIsShown();

  await signUpEmailPage.insertEmail('backend.test@loono.cz');
  await signUpEmailPage.clickCreateAccountButton();

  await badgeOverviewPage.verifyScreenIsShown();
  try {
    expect(
      tester.takeException().toString(),
      contains('A RenderFlex overflowed'), // silence overflow issue
    );
  } catch (e) {
    debugPrint(e.toString());
  }
  await badgeOverviewPage.clickContinueButton();
  await preventionPage.verifyScreenIsShown();
  //////////////////////////////////////////////////////////////////////////////

  /// Verify some data are fetched from api GET /examinations.
  await tester.pumpUntilFound(find.byType(SelfExaminationCard));
  preventionPage
    ..verifyHasBadge(BadgeType.HEADBAND)
    ..verifyDoesNotHaveBadge(BadgeType.SHIELD)
    ..verifyDoesNotHaveBadge(BadgeType.GLOVES)
    ..verifyHasPoints(300); // HEADBAND and points are reward from the Dentist visit
  await preventionPage.verifySelfExaminationCardIsInCategory(
    SelfExaminationType.TESTICULAR,
    expectedCategoryName: 'Vyšetři se',
  );

  //////////////////////////////////////////////////////////////////////////////

  /////// Perform self examination with OK status.
  await preventionPage.clickSelfExaminationCard(SelfExaminationType.TESTICULAR);
  await selfExaminationDetailPage.verifyScreenIsShown();

  await selfExaminationDetailPage.clickSelfExaminationPerformedButton();
  await howItWentModalPage.verifyModalIsShown();

  await howItWentModalPage.clickOkButton();
  await noFindingRewardPage.verifyScreenIsShown();

  await noFindingRewardPage.clickContinueButton();
  await preventionPage.verifyScreenIsShown();

  await preventionPage.verifySelfExaminationCardIsInCategory(
    SelfExaminationType.TESTICULAR,
    expectedCategoryName: 'Připomenu ti vyšetření',
  );
  preventionPage
    ..verifyHasBadge(BadgeType.HEADBAND)
    ..verifyHasBadge(BadgeType.SHIELD)
    ..verifyDoesNotHaveBadge(BadgeType.GLOVES)
    ..verifyHasPoints(300 + 50); // +50 points and shield from the performed self examination

  //////////////////////////////////////////////////////////////////////////////

  /////// LOON-591: Filling missing checkups - Dermatologist, path: should receive points and a badge.
  await preventionPage.verifyExaminationCardIsInCategory(
    ExaminationType.DERMATOLOGIST,
    expectedCategoryName: 'Další prohlídky',
  );
  await preventionPage.clickExaminationCard(ExaminationType.DERMATOLOGIST);
  await questionnaireDoctorCcaLastVisitPage.verifyScreenIsShown(
    expectedScreen: ScheduleExamination,
  );

  await questionnaireDoctorCcaLastVisitPage.clickInLastXYearsButton(
    expectedNextScreen: AchievementScreen,
  );
  await questionnaireAchievementPage.clickContinueButton();
  await questionnaireDoctorDatePickerPage.verifyScreenIsShown(expectedScreen: DatePickerScreen);

  await questionnaireDoctorDatePickerPage.clickContinueButton();
  await examinationDetailPage.verifyScreenIsShown();

  await tester.pumpUntilNotFound(find.byType(Flushbar));
  await examinationDetailPage.clickBackButton();
  await preventionPage.verifyScreenIsShown();

  preventionPage
    ..verifyHasBadge(BadgeType.HEADBAND)
    ..verifyHasBadge(BadgeType.SHIELD)
    ..verifyHasBadge(BadgeType.GLOVES)
    ..verifyHasPoints(350 + 200); // +200 points and gloves from the dermatologist visit

  await preventionPage.verifyExaminationCardIsInCategory(
    ExaminationType.DERMATOLOGIST,
    expectedCategoryName: 'Připomenu ti objednání',
  );
  //////////////////////////////////////////////////////////////////////////////

  /////// LOON-591: Filling missing checkups - Ophthalmologist, path: should not receive poitns and a badge.
  await preventionPage.verifyExaminationCardIsInCategory(
    ExaminationType.OPHTHALMOLOGIST,
    expectedCategoryName: 'Další prohlídky',
  );
  await preventionPage.clickExaminationCard(ExaminationType.OPHTHALMOLOGIST);
  await questionnaireDoctorCcaLastVisitPage.verifyScreenIsShown(
    expectedScreen: ScheduleExamination,
  );

  await questionnaireDoctorCcaLastVisitPage.clickMoreThanXYearsOrIdkButton(
    expectedNextScreen: ExaminationDetail,
  );
  await examinationDetailPage.verifyScreenIsShown();
  examinationDetailPage.verifyIsFirstAwaitingVisit();

  await examinationDetailPage.clickBackButton();
  await preventionPage.verifyScreenIsShown();

  preventionPage
    ..verifyHasBadge(BadgeType.HEADBAND)
    ..verifyHasBadge(BadgeType.SHIELD)
    ..verifyHasBadge(BadgeType.GLOVES)
    ..verifyDoesNotHaveBadge(BadgeType.GLASSES)
    ..verifyHasPoints(550); // no points and no badge should be added

  await preventionPage.verifyExaminationCardIsInCategory(
    ExaminationType.OPHTHALMOLOGIST,
    expectedCategoryName: 'Objednej se',
  );
  //////////////////////////////////////////////////////////////////////////////

  /////// LOON-592: Order for a check-up and delete it afterward.
  await preventionPage.verifyExaminationCardIsInCategory(
    ExaminationType.OPHTHALMOLOGIST,
    expectedCategoryName: 'Objednej se',
  );
  await preventionPage.clickExaminationCard(ExaminationType.OPHTHALMOLOGIST);

  await examinationDetailPage.verifyScreenIsShown();
  examinationDetailPage
    ..verifyOrderButtonIsShown()
    ..verifyIsFirstAwaitingVisit();

  await examinationDetailPage.clickOrderButton();
  await examinationDetailPage.verifyOrderSheetIsShown();

  await examinationDetailPage.clickIHaveDoctorOrderSheetButton();
  await examinationDetailPage.verifyOrderInstructionsSheetIsShown();

  await examinationDetailPage.clickIHaveAppointmentOrderInstructionsSheetButton();
  await examinationDetailPage.verifyOrderDatePickerSheetIsShown();

  examinationDetailPage.verifyDatePickerIsShown();
  await examinationDetailPage.datePickerSheetPickNextMonth();
  await examinationDetailPage.clickDatePickerSheetContinueButton();

  await examinationDetailPage.verifyOrderDatePickerSheetIsShown();
  examinationDetailPage.verifyTimePickerIsShown();
  await examinationDetailPage.clickDatePickerSheetContinueButton();

  await tester.pumpUntilNotFound(find.byType(Flushbar));
  examinationDetailPage.verifyCalendarButtonIsShown();

  await examinationDetailPage.clickBackButton();
  await preventionPage.verifyScreenIsShown();
  await preventionPage.verifyExaminationCardIsInCategory(
    ExaminationType.OPHTHALMOLOGIST,
    expectedCategoryName: 'Běž na prohlídku',
  );

  await preventionPage.clickExaminationCard(ExaminationType.OPHTHALMOLOGIST);
  await examinationDetailPage.verifyScreenIsShown();

  await examinationDetailPage.cancelCheckup();
  await tester.pumpUntilNotFound(find.byType(Flushbar));
  examinationDetailPage
    ..verifyOrderButtonIsShown()
    ..verifyIsFirstAwaitingVisit();

  await examinationDetailPage.clickBackButton();
  await preventionPage.verifyScreenIsShown();
  await preventionPage.verifyExaminationCardIsInCategory(
    ExaminationType.OPHTHALMOLOGIST,
    expectedCategoryName: 'Objednej se',
  );
  //////////////////////////////////////////////////////////////////////////////

  /////// Edit email.
  await preventionPage.clickProfileAvatar();
  await openSettingsPage.verifyScreenIsShown();

  await openSettingsPage.clickEditProfileButton();
  await updateProfilePage.verifyScreenIsShown();
  updateProfilePage.verifyEmail('backend.test@loono.cz');

  await updateProfilePage.clickEmailField();
  await editEmailPage.verifyScreenIsShown();

  await editEmailPage.insertEmail('backend.test.edited@loono.cz');
  await editEmailPage.clickSaveButton();
  await updateProfilePage.verifyScreenIsShown();
  updateProfilePage.verifyEmail('backend.test.edited@loono.cz');

  await updateProfilePage.clickBackButton();
  await openSettingsPage.verifyScreenIsShown();

  // check leaderboard
  await openSettingsPage.clickPointsHelpButton();
  await pointsHelpPage.verifyScreenIsShown();

  await pointsHelpPage.clickBackButton();
  await openSettingsPage.verifyScreenIsShown();

  await openSettingsPage.clickLeaderboardButton();
  await leaderboardPage.verifyScreenIsShown();
  await tester.pump(const Duration(seconds: 4));
  //////////////////////////////////////////////////////////////////////////////
}
