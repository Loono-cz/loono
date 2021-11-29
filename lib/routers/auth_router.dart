import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/ui/screens/create_account.dart';
import 'package:loono/ui/screens/logged_in.dart';
import 'package:loono/ui/screens/login.dart';
import 'package:loono/ui/screens/logout.dart';
import 'package:loono/ui/screens/onboarding/allow_notifications.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_achievement.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner_achievement.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practitioner_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology_achievement.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology_date.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/email.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/nickname.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/onboarding/onboarding_wrapper_screen.dart';
import 'package:loono/ui/screens/welcome.dart';

part 'auth_router.gr.dart';

const _onboardingTransition = TransitionsBuilders.slideLeft;

// After editing this, run:
// flutter pub run build_runner build --delete-conflicting-outputs
//
// Pre-auth screens
@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen|Dialog,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, path: 'login'),
    AutoRoute(page: CreateAccountScreen, path: 'create-account'),
    AutoRoute(page: NicknameScreen, path: 'fallback_account/name'),
    AutoRoute(page: EmailScreen, path: 'fallback_account/email'),
    AutoRoute(page: LogoutScreen, path: 'logout'),
    AutoRoute(page: LoggedInScreen, path: 'logged-in'),
    _onboardingRoutes,
  ],
)
class AuthRouter extends _$AuthRouter {}

const _onboardingRoutes = AutoRoute(
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
);
