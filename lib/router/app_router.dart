import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:loono/router/guards/check_is_logged_in.dart';
import 'package:loono/ui/screens/create_account.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/general_practicioner_achievement.dart';
import 'package:loono/ui/screens/gynecology_achievement.dart';
import 'package:loono/ui/screens/login.dart';
import 'package:loono/ui/screens/main/main_screen.dart';
import 'package:loono/ui/screens/onboarding/allow_notifications.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practitioner_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology_date.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/email.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/nickname.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/onboarding/onboarding_wrapper_screen.dart';
import 'package:loono/ui/screens/settings/edit_birthdate.dart';
import 'package:loono/ui/screens/settings/edit_email.dart';
import 'package:loono/ui/screens/settings/edit_nickname.dart';
import 'package:loono/ui/screens/settings/edit_sex.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';
import 'package:loono/ui/screens/welcome.dart';

const _onboardingTransition = TransitionsBuilders.slideLeft;

const _openSettingsTransition = TransitionsBuilders.slideBottom;
const _settingsTransition = TransitionsBuilders.slideLeft;

// After editing this, run:
// flutter pub run build_runner build --delete-conflicting-outputs
@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      // page: MainScreen,
      page: EmptyRouterScreen,
      path: 'main',
      name: 'MainScreenRouter',
      initial: true,
      guards: [CheckIsLoggedIn],
      children: [
        // Main
        AutoRoute(page: MainScreen, path: ''),

        // Settings
        CustomRoute(
          page: OpenSettingsScreen,
          path: 'settings',
          transitionsBuilder: _openSettingsTransition,
        ),
        CustomRoute(
          page: UpdateProfileScreen,
          path: 'settings/update-profile',
          transitionsBuilder: _settingsTransition,
        ),
        CustomRoute(
          page: EditNicknameScreen,
          path: 'settings/update-profile/nickname',
          transitionsBuilder: _settingsTransition,
        ),
        CustomRoute(
          page: EditEmailScreen,
          path: 'settings/update-profile/email',
          transitionsBuilder: _settingsTransition,
        ),
        CustomRoute(
          page: EditSexScreen,
          path: 'settings/update-profile/sex',
          transitionsBuilder: _settingsTransition,
        ),
        CustomRoute(
          page: EditBirthdateScreen,
          path: 'settings/update-profile/birthdate',
          transitionsBuilder: _settingsTransition,
        ),
      ],
    ),
    AutoRoute(
      page: OnboardingWrapperScreen,
      path: 'onboarding',
      children: [
        AutoRoute(page: WelcomeScreen, path: 'welcome'),
        CustomRoute(
          page: OnboardingCarouselScreen,
          path: 'carousel',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: OnboardingGenderScreen,
          path: 'gender',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: OnBoardingBirthdateScreen,
          path: 'birthdate',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: OnboardingGeneralPracticionerScreen,
          path: 'doctor/general-practicioner',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: GeneralPracticionerAchievementScreen,
          path: 'general-practicioner-achievement',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: GeneralPractitionerDateScreen,
          path: 'doctor/general-practitioner-date',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: AllowNotificationsScreen,
          path: 'allow_notifications',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: OnboardingGynecologyScreen,
          path: 'doctor/gynecology',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: GynecologyAchievementScreen,
          path: 'gynecology_achievement',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: GynecologyDateScreen,
          path: 'doctor/gynecology-date',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: OnboardingDentistScreen,
          path: 'doctor/dentist',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: DentistAchievementScreen,
          path: 'dentist_achievement',
          transitionsBuilder: _onboardingTransition,
        ),
        CustomRoute(
          page: DentistDateScreen,
          path: 'doctor/dentist-date',
          transitionsBuilder: _onboardingTransition,
        ),
      ],
    ),
    AutoRoute(page: CreateAccountScreen, path: 'create-account'),
    AutoRoute(page: NicknameScreen, path: 'fallback_account/name'),
    AutoRoute(page: EmailScreen, path: 'fallback_account/email'),
    AutoRoute(page: LoginScreen, path: 'login'),
  ],
)
class $AppRouter {}
