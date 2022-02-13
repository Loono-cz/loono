import 'package:auto_route/auto_route.dart';
import 'package:loono/router/guards/check_is_logged_in.dart';
import 'package:loono/router/sub_routers/app_startup_wrapper_screen.dart';
import 'package:loono/router/sub_routers/onboarding_wrapper_screen.dart';
import 'package:loono/router/sub_routers/pre_auth_prevention_wrapper_screen.dart';
import 'package:loono/ui/screens/about_health/about_health.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/find_doctor/find_doctor.dart';
import 'package:loono/ui/screens/general_practicioner_achievement.dart';
import 'package:loono/ui/screens/gynecology_achievement.dart';
import 'package:loono/ui/screens/logout.dart';
import 'package:loono/ui/screens/main/main_screen.dart';
import 'package:loono/ui/screens/main/pre_auth/continue_onboarding_form.dart';
import 'package:loono/ui/screens/main/pre_auth/login.dart';
import 'package:loono/ui/screens/main/pre_auth/onboarding_form_done.dart';
import 'package:loono/ui/screens/main/pre_auth/pre_auth_main_screen.dart';
import 'package:loono/ui/screens/main/pre_auth/start_new_questionnaire.dart';
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
import 'package:loono/ui/screens/onboarding/fill_form_later.dart';
import 'package:loono/ui/screens/onboarding/gamification_introduction.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/prevention/calendar/calendar_list.dart';
import 'package:loono/ui/screens/prevention/calendar/permission_info.dart';
import 'package:loono/ui/screens/prevention/examination_detail/change_date_screen.dart';
import 'package:loono/ui/screens/prevention/examination_detail/change_last_visit_screen.dart';
import 'package:loono/ui/screens/prevention/examination_detail/change_time_screen.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';
import 'package:loono/ui/screens/prevention/examination_detail/new_date_screen.dart';
import 'package:loono/ui/screens/prevention/examination_detail/new_time_screen.dart';
import 'package:loono/ui/screens/prevention/questionnaire/date_picker_screen.dart';
import 'package:loono/ui/screens/settings/camera_photo_taken.dart';
import 'package:loono/ui/screens/settings/delete_account.dart';
import 'package:loono/ui/screens/settings/edit_email.dart';
import 'package:loono/ui/screens/settings/edit_nickname.dart';
import 'package:loono/ui/screens/settings/edit_photo.dart';
import 'package:loono/ui/screens/settings/gallery_photo_taken.dart';
import 'package:loono/ui/screens/settings/leaderboard.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/photo_cropped_result.dart';
import 'package:loono/ui/screens/settings/points_help.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';
import 'package:loono/ui/screens/splash_screen.dart';
import 'package:loono/ui/screens/welcome.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';

const _onboardingTransition = TransitionsBuilders.slideLeft;
const _preventionTransition = TransitionsBuilders.slideLeft;

const _openSettingsTransition = TransitionsBuilders.slideBottom;
const _settingsTransition = TransitionsBuilders.slideLeft;

// After editing this, run:
// flutter pub run build_runner build --delete-conflicting-outputs
@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    _appStartUpRouter,
    ..._preAuthRoutes,
    _postAuthRouter,
  ],
)
class $AppRouter {}

const _appStartUpRouter = AutoRoute<void>(
  path: 'app-start-up',
  page: AppStartUpWrapperScreen,
  children: [
    AutoRoute<void>(page: SplashScreen, path: 'splash-screen'),
    AutoRoute<void>(page: WelcomeScreen, path: 'welcome'),
    _preAuthMainScreenRouter,
  ],
);

/// Only Onboarding Form, Find a Doctor and About Health screens are accessible.
const _preAuthRoutes = <AutoRoute>[
  _preAuthMainScreenRouter,
  AutoRoute<void>(page: IntroCarouselScreen, path: 'intro-carousel'),
  _onboardingQuestionnaireRouter,
  AutoRoute<void>(page: FillOnboardingFormLaterScreen, path: 'fill-form-later'),
  AutoRoute<void>(page: GamificationIntroductionScreen, path: 'gamification-introduction'),
  AutoRoute<void>(page: NicknameScreen, path: 'fallback-account/name'),
  AutoRoute<void>(page: EmailScreen, path: 'fallback-account/email'),
  _loginRoute,
  AutoRoute<void>(page: LogoutScreen, path: 'logout'),
];

/// Everything from the bottom navigation bar is accessible in post-auth screens.
const _postAuthRouter = AutoRoute<void>(
  page: EmptyRouterScreen,
  path: 'main',
  name: 'MainScreenRouter',
  initial: true,
  guards: [CheckIsLoggedIn],
  children: [
    AutoRoute<void>(page: MainScreen, path: ''),
    ..._settingsRoutes,
    ..._preventionRoutes,
    _findDoctorRoute,
  ],
);

const _preAuthMainScreenRouter = AutoRoute<void>(
  path: 'pre-auth-main',
  page: PreAuthMainScreen,
  children: [
    _preAuthPreventionRouter,
    _findDoctorRoute,
    _aboutHealthRoute,
  ],
);

const _preAuthPreventionRouter = AutoRoute<void>(
  path: 'pre-auth-prevention',
  page: PreAuthPreventionWrapperScreen,
  children: [
    _loginRoute,
    AutoRoute<void>(page: StartNewQuestionnaireScreen, path: 'start-new-questionnaire'),
    AutoRoute<void>(page: ContinueOnboardingFormScreen, path: 'continue-onboarding-form'),
    AutoRoute<void>(page: OnboardingFormDoneScreen, path: 'onboarding-form-done'),
  ],
);

const _loginRoute = AutoRoute<void>(page: LoginScreen, path: 'login');
const _findDoctorRoute = AutoRoute<void>(page: FindDoctorScreen, path: 'find-doctor');
const _aboutHealthRoute = AutoRoute<void>(page: AboutHealthScreen, path: 'about-health');

const _onboardingQuestionnaireRouter = AutoRoute<void>(
  page: OnboardingWrapperScreen,
  path: 'onboarding',
  children: [
    CustomRoute<void>(
      page: OnboardingGenderScreen,
      path: 'gender',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: OnBoardingBirthdateScreen,
      path: 'birthdate',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: OnboardingGeneralPracticionerScreen,
      path: 'doctor/general-practicioner',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: GeneralPracticionerAchievementScreen,
      path: 'general-practicioner-achievement',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: GeneralPractitionerDateScreen,
      path: 'doctor/general-practitioner-date',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: AllowNotificationsScreen,
      path: 'allow-notifications',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: OnboardingGynecologyScreen,
      path: 'doctor/gynecology',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: GynecologyAchievementScreen,
      path: 'gynecology-achievement',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: GynecologyDateScreen,
      path: 'doctor/gynecology-date',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: OnboardingDentistScreen,
      path: 'doctor/dentist',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: DentistAchievementScreen,
      path: 'dentist-achievement',
      transitionsBuilder: _onboardingTransition,
    ),
    CustomRoute<void>(
      page: DentistDateScreen,
      path: 'doctor/dentist-date',
      transitionsBuilder: _onboardingTransition,
    ),
  ],
);

const _settingsRoutes = <AutoRoute>[
  CustomRoute<void>(
    page: OpenSettingsScreen,
    path: 'settings',
    transitionsBuilder: _openSettingsTransition,
  ),
  CustomRoute<void>(
    page: UpdateProfileScreen,
    path: 'settings/update-profile',
    transitionsBuilder: _settingsTransition,
  ),
  CustomRoute<void>(
    page: EditNicknameScreen,
    path: 'settings/update-profile/nickname',
    transitionsBuilder: _settingsTransition,
  ),
  CustomRoute<void>(
    page: EditEmailScreen,
    path: 'settings/update-profile/email',
    transitionsBuilder: _settingsTransition,
  ),
  CustomRoute<void>(
    page: EditPhotoScreen,
    path: 'settings/update-profile/photo',
    transitionsBuilder: _settingsTransition,
  ),
  CustomRoute<void>(
    page: DeleteAccountScreen,
    path: 'settings/update-profile/delete',
    transitionsBuilder: _settingsTransition,
  ),
  CustomRoute<void>(
    page: CameraPhotoTakenScreen,
    path: 'settings/update-profile/photo/camera-taken',
    transitionsBuilder: _settingsTransition,
  ),
  CustomRoute<void>(
    page: GalleryPhotoTakenScreen,
    path: 'settings/update-profile/photo/gallery-taken',
    transitionsBuilder: _settingsTransition,
  ),
  CustomRoute<void>(
    page: PhotoCroppedResultScreen,
    path: 'settings/update-profile/photo/photo-cropped-result',
    transitionsBuilder: _settingsTransition,
  ),
  CustomRoute<void>(
    page: LeaderboardScreen,
    path: 'settings/leaderboard',
    transitionsBuilder: _settingsTransition,
  ),
  CustomRoute<void>(
    page: PointsHelpScreen,
    path: 'settings/points-help',
    transitionsBuilder: _settingsTransition,
  ),
];

const _preventionRoutes = <AutoRoute>[
  CustomRoute<void>(
    page: ExaminationDetailScreen,
    path: 'prevention-detail',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: AchievementScreen,
    path: 'questionnaire/reward',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: DatePickerScreen,
    path: 'questionnaire/date-picker',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<bool>(
    page: CalendarPermissionInfoScreen,
    path: 'calendar/permission',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: CalendarListScreen,
    path: 'calendar/list',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: ChangeLastVisitScreen,
    path: 'checkup/last-visit-update',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: NewDateScreen,
    path: 'checkup/set-date',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: NewTimeScreen,
    path: 'checkup/set-time',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: ChangeDateScreen,
    path: 'checkup/change-date',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: ChangeTimeScreen,
    path: 'checkup/change-time',
    transitionsBuilder: _preventionTransition,
  ),
];
