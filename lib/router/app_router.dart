import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:loono/ui/screens/create_account.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/general_practicioner_achievement.dart';
import 'package:loono/ui/screens/gynecology_achievement.dart';
import 'package:loono/ui/screens/login.dart';
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

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: WelcomeScreen, initial: true, path: 'welcome'),
    AutoRoute(page: OnboardingCarouselScreen, path: 'onboarding/carousel'),
    AutoRoute(
      page: OnboardingWrapperScreen,
      path: 'onboarding',
      children: [
        AutoRoute(page: OnboardingGenderScreen, path: 'onboarding/gender'),
        AutoRoute(page: OnBoardingBirthdateScreen, path: 'onboarding/birthdate'),
        AutoRoute(
            page: OnboardingGeneralPracticionerScreen,
            path: 'onboarding/doctor/general-practicioner'),
        AutoRoute(
            page: GeneralPracticionerAchievementScreen, path: 'general-practicioner-achievement'),
        AutoRoute(
            page: GeneralPractitionerDateScreen,
            path: 'onboarding/doctor/general-practitioner-date'),
        AutoRoute(page: AllowNotificationsScreen, path: 'onboarding/allow_notifications'),
        AutoRoute(page: OnboardingGynecologyScreen, path: 'onboarding/doctor/gynecology'),
        AutoRoute(page: GynecologyAchievementScreen, path: 'gynecology_achievement'),
        AutoRoute(page: GynecologyDateScreen, path: 'onboarding/doctor/gynecology-date'),
        AutoRoute(page: OnboardingDentistScreen, path: 'onboarding/doctor/dentist'),
        AutoRoute(page: DentistAchievementScreen, path: 'dentist_achievement'),
        AutoRoute(page: DentistDateScreen, path: 'onboarding/doctor/dentist-date'),
      ],
    ),
    AutoRoute(page: CreateAccountScreen, path: 'create-account'),
    AutoRoute(page: NicknameScreen, path: 'fallback_account/name'),
    AutoRoute(page: EmailScreen, path: 'fallback_account/email'),
    AutoRoute(page: LoginScreen, path: 'login'),
  ],
)
class $AppRouter {}
