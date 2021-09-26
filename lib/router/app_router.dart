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
import 'package:loono/ui/screens/welcome.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: WelcomeScreen, path: 'welcome'),
    AutoRoute(page: OnboardingCarouselScreen, path: 'onboarding/carousel'),
    CustomRoute(
      page: OnboardingWrapperScreen,
      path: 'onboarding',
      transitionsBuilder: TransitionsBuilders.slideLeft,
      children: [
        CustomRoute(
          page: OnboardingGenderScreen,
          path: 'onboarding/gender',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: OnBoardingBirthdateScreen,
          path: 'onboarding/birthdate',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: OnboardingGeneralPracticionerScreen,
          path: 'onboarding/doctor/general-practicioner',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: GeneralPracticionerAchievementScreen,
          path: 'general-practicioner-achievement',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: GeneralPractitionerDateScreen,
          path: 'onboarding/doctor/general-practitioner-date',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: AllowNotificationsScreen,
          path: 'onboarding/allow_notifications',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: OnboardingGynecologyScreen,
          path: 'onboarding/doctor/gynecology',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: GynecologyAchievementScreen,
          path: 'gynecology_achievement',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: GynecologyDateScreen,
          path: 'onboarding/doctor/gynecology-date',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: OnboardingDentistScreen,
          path: 'onboarding/doctor/dentist',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: DentistAchievementScreen,
          path: 'dentist_achievement',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          page: DentistDateScreen,
          path: 'onboarding/doctor/dentist-date',
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
      ],
    ),
    AutoRoute(page: CreateAccountScreen, path: 'create-account'),
    AutoRoute(page: NicknameScreen, path: 'fallback_account/name'),
    AutoRoute(page: EmailScreen, path: 'fallback_account/email'),
    AutoRoute(page: LoginScreen, path: 'login'),
    AutoRoute(page: MainScreen, path: 'main', initial: true, guards: [CheckIsLoggedIn]),
  ],
)
class $AppRouter {}
