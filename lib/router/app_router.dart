import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:loono/router/guards/check_is_logged_in.dart';
import 'package:loono/ui/screens/create_account.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/general_practicioner_achievement.dart';
import 'package:loono/ui/screens/gynecology_achievement.dart';
import 'package:loono/ui/screens/login.dart';
import 'package:loono/ui/screens/logout.dart';
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
import 'package:loono/ui/screens/prevention/calendar/calendar_list.dart';
import 'package:loono/ui/screens/prevention/calendar/permission_info.dart';
import 'package:loono/ui/screens/prevention/examination_detail/cancel_checkup_screen.dart';
import 'package:loono/ui/screens/prevention/examination_detail/change_date_screen.dart';
import 'package:loono/ui/screens/prevention/examination_detail/change_time_screen.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';
import 'package:loono/ui/screens/prevention/questionnaire/date_picker_screen.dart';
import 'package:loono/ui/screens/settings/camera_photo_taken.dart';
import 'package:loono/ui/screens/settings/edit_email.dart';
import 'package:loono/ui/screens/settings/edit_nickname.dart';
import 'package:loono/ui/screens/settings/edit_photo.dart';
import 'package:loono/ui/screens/settings/gallery_photo_taken.dart';
import 'package:loono/ui/screens/settings/leaderboard.dart';
import 'package:loono/ui/screens/settings/open_settings.dart';
import 'package:loono/ui/screens/settings/photo_cropped_result.dart';
import 'package:loono/ui/screens/settings/points_help.dart';
import 'package:loono/ui/screens/settings/update_profile.dart';
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
    AutoRoute(
      page: EmptyRouterScreen,
      path: 'main',
      name: 'MainScreenRouter',
      initial: true,
      guards: [CheckIsLoggedIn],
      children: [
        // Main
        AutoRoute(page: MainScreen, path: ''),

        // Prevention
        CustomRoute(
          page: ExaminationDetailScreen,
          path: 'prevention-detail',
          transitionsBuilder: _preventionTransition,
        ),
        CustomRoute(
          page: AchievementScreen,
          path: 'questionnaire/reward',
          transitionsBuilder: _preventionTransition,
        ),
        CustomRoute(
          page: DatePickerScreen,
          path: 'questionnaire/date-picker',
          transitionsBuilder: _preventionTransition,
        ),
        CustomRoute(
          page: CalendarPermissionInfoScreen,
          path: 'calendar/permission',
          transitionsBuilder: _preventionTransition,
        ),
        CustomRoute(
          page: CalendarListScreen,
          path: 'calendar/list',
          transitionsBuilder: _preventionTransition,
        ),
        CustomRoute(
          page: CancelCheckupScreen,
          path: 'checkup/cancel',
          transitionsBuilder: _preventionTransition,
        ),
        CustomRoute(
          page: ChangeDateScreen,
          path: 'checkup/change-date',
          transitionsBuilder: _preventionTransition,
        ),
        CustomRoute(
          page: ChangeTimeScreen,
          path: 'checkup/change-time',
          transitionsBuilder: _preventionTransition,
        ),

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
          page: EditPhotoScreen,
          path: 'settings/update-profile/photo',
          transitionsBuilder: _settingsTransition,
        ),
        CustomRoute(
          page: CameraPhotoTakenScreen,
          path: 'settings/update-profile/photo/camera-taken',
          transitionsBuilder: _settingsTransition,
        ),
        CustomRoute(
          page: GalleryPhotoTakenScreen,
          path: 'settings/update-profile/photo/gallery-taken',
          transitionsBuilder: _settingsTransition,
        ),
        CustomRoute(
          page: PhotoCroppedResultScreen,
          path: 'settings/update-profile/photo/photo-cropped-result',
          transitionsBuilder: _settingsTransition,
        ),
        CustomRoute(
          page: LeaderboardScreen,
          path: 'settings/leaderboard',
          transitionsBuilder: _settingsTransition,
        ),
        CustomRoute(
          page: PointsHelpScreen,
          path: 'settings/points-help',
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
    AutoRoute(page: LogoutScreen, path: 'logout'),
  ],
)
class $AppRouter {}
