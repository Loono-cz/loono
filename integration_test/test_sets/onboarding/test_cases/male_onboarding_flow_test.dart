import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/main/pre_auth/continue_onboarding_form.dart';
import 'package:loono/ui/screens/main/pre_auth/login.dart';
import 'package:loono/ui/screens/main/pre_auth/onboarding_form_done.dart';
import 'package:loono/ui/screens/main/pre_auth/start_new_questionnaire.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_second.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/fill_form_later.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/widgets/intro_video.dart';

import '../../../setup.dart' as app;
import '../../app/pages/login_page.dart';
import '../../app/pages/welcome_page.dart';
import '../pages/continue_questionnaire_page.dart';
import '../pages/intro_video_page.dart';
import '../pages/questionnaire/achievement_page.dart';
import '../pages/questionnaire/birthdate_page.dart';
import '../pages/questionnaire/doctor_cca_last_visit_page.dart';
import '../pages/questionnaire/doctor_date_picker_page.dart';
import '../pages/questionnaire/fill_form_later_page.dart';
import '../pages/questionnaire/gender_page.dart';
import '../pages/second_carousel_page.dart';
import '../pages/start_new_questionnaire_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Onboarding',
    () {
      testWidgets('TC: Onboarding male flow with progress bar checks', (WidgetTester tester) async {
        await app.runMockApp();
        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 3));

        final welcomePage = WelcomePage(tester);
        final introVideoPage = IntroVideoPage(tester);
        final secondCarouselPage = SecondCarouselPage(tester);
        final startNewQuestionnaire = StartNewQuestionnairePage(tester);
        final continueQuestionnairePage = ContinueQuestionnairePage(tester);
        final loginPage = LoginPage(tester);
        final fillFormLaterPage = FillFormLaterPage(tester);
        final questionnaireGenderPage = QuestionnaireGenderPage(tester);
        final questionnaireBirthDatePage = QuestionnaireBirthDatePage(tester);
        final questionnaireDoctorCcaLastVisitPage = QuestionnaireDoctorCcaLastVisitPage(tester);
        final questionnaireAchievementPage = QuestionnaireAchievementPage(tester);
        final questionnaireDoctorDatePickerPage = QuestionnaireDoctorDatePickerPage(tester);

        // navigate to StartNewQuestionnaireScreen through Carousel screens
        await welcomePage.clickStartButton();
        expect(find.byType(IntroVideo), findsOneWidget);

        await introVideoPage.clickContinueBtn();
        expect(find.byType(OnboardingSecondCarouselScreen), findsOneWidget);

        await secondCarouselPage.clickContinueBtn();
        expect(find.byType(StartNewQuestionnaireScreen), findsOneWidget);

        // check route 'Už mám účet' is working
        await startNewQuestionnaire.clickAlreadyHavenAnAccountButton();
        expect(find.byType(LoginScreen), findsOneWidget);

        // start questionnaire
        await loginPage.clickCreateNewAccountButton();
        expect(find.byType(OnboardingGenderScreen), findsOneWidget);

        // skip onboarding form
        await questionnaireGenderPage.clickSkipQuestionnaireButton();
        expect(find.byType(FillOnboardingFormLaterScreen), findsOneWidget);
        await fillFormLaterPage.clickFillLaterFormButton();
        expect(find.byType(ContinueOnboardingFormScreen), findsOneWidget);

        // check questionnaire progress on the PreAuthMainScreen, should not have any / should be 0
        expect(continueQuestionnairePage.hasProgressBarAnyProgress(), false);
        expect(continueQuestionnairePage.isProgressBarValueEqualTo(0), true);

        // continue onboarding form, should return to Gender Screen
        await continueQuestionnairePage.clickContinueFormButton();
        expect(find.byType(OnboardingGenderScreen), findsOneWidget);

        // choose MALE
        expect(questionnaireGenderPage.isContinueButtonDisabled(), true);
        await questionnaireGenderPage.chooseMaleGender();
        expect(questionnaireGenderPage.isContinueButtonDisabled(), false);
        await questionnaireGenderPage.clickContinueButton();

        // skip onboarding form, progress bar should have now progress
        await questionnaireGenderPage.clickSkipQuestionnaireButton();
        expect(find.byType(FillOnboardingFormLaterScreen), findsOneWidget);
        await fillFormLaterPage.clickFillLaterFormButton();
        expect(find.byType(ContinueOnboardingFormScreen), findsOneWidget);
        expect(continueQuestionnairePage.hasProgressBarAnyProgress(), true);

        // continue onboarding form, should return to BirthDate screen
        await continueQuestionnairePage.clickContinueFormButton();
        expect(find.byType(OnBoardingBirthdateScreen), findsOneWidget);

        await questionnaireBirthDatePage.clickContinueButton();
        expect(find.byType(OnboardingGeneralPracticionerScreen), findsOneWidget);

        // "more than X years" button should transition to next doctor
        await questionnaireDoctorCcaLastVisitPage.clickMoreThanXYearsOrIdkButton();
        expect(find.byType(OnboardingDentistScreen), findsOneWidget);

        // "in last X years" should transition to achievement screen, date picker screen
        await questionnaireDoctorCcaLastVisitPage.clickInLastXYearsButton();
        expect(find.byType(DentistAchievementScreen), findsOneWidget);
        await questionnaireAchievementPage.clickContinueButton();
        expect(find.byType(DentistDateScreen), findsOneWidget);
        await questionnaireDoctorDatePickerPage.clickContinueButton();

        // final route, onboarding is completed 🎉
        expect(find.byType(OnboardingFormDoneScreen), findsOneWidget);
      });
    },
    // TODO: on iOS there is slightly different routing in the onboarding form
    skip: Platform.isIOS,
  );
}
