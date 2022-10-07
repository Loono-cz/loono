import 'package:auto_route/auto_route.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/router/guards/check_is_logged_in.dart';
import 'package:loono/router/sub_routers/app_startup_wrapper_screen.dart';
import 'package:loono/router/sub_routers/onboarding_wrapper_screen.dart';
import 'package:loono/router/sub_routers/pre_auth_prevention_wrapper_screen.dart';
import 'package:loono/ui/screens/about_health/about_health.dart';
import 'package:loono/ui/screens/custom_exam_form/choose_exam_period_date_screen.dart';
import 'package:loono/ui/screens/custom_exam_form/choose_exam_period_time_screen.dart';
import 'package:loono/ui/screens/custom_exam_form/choose_examination_screen.dart';
import 'package:loono/ui/screens/custom_exam_form/choose_frequency_of_exam_screen.dart';
import 'package:loono/ui/screens/custom_exam_form/choose_specialist_screen.dart';
import 'package:loono/ui/screens/custom_exam_form/custom_exam_form_screen.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/find_doctor/doctor_search_detail.dart';
import 'package:loono/ui/screens/find_doctor/find_doctor.dart';
import 'package:loono/ui/screens/find_doctor/no_permissions_screen.dart';
import 'package:loono/ui/screens/force_update.dart';
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
import 'package:loono/ui/screens/onboarding/badge_overview.dart';
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
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/prevention/calendar/calendar_list.dart';
import 'package:loono/ui/screens/prevention/calendar/permission_info.dart';
import 'package:loono/ui/screens/prevention/examination_detail/change_last_visit_screen.dart';
import 'package:loono/ui/screens/prevention/examination_detail/examination_screen.dart';
import 'package:loono/ui/screens/prevention/prevention_screen.dart';
import 'package:loono/ui/screens/prevention/questionnaire/date_picker_screen.dart';
import 'package:loono/ui/screens/prevention/self_examination/detail_screen.dart';
import 'package:loono/ui/screens/prevention/self_examination/educational_screen.dart';
import 'package:loono/ui/screens/prevention/self_examination/has_finding_screen.dart';
import 'package:loono/ui/screens/prevention/self_examination/no_finding_screen.dart';
import 'package:loono/ui/screens/prevention/self_examination/progress_screen.dart';
import 'package:loono/ui/screens/prevention/self_examination/result_from_doctor.dart';
import 'package:loono/ui/screens/settings/after_deletion.dart';
import 'package:loono/ui/screens/settings/camera_photo_taken.dart';
import 'package:loono/ui/screens/settings/delete_account.dart';
import 'package:loono/ui/screens/settings/edit_email.dart';
import 'package:loono/ui/screens/settings/edit_nickname.dart';
import 'package:loono/ui/screens/settings/edit_photo.dart';
import 'package:loono/ui/screens/settings/gallery_photo_taken.dart';
import 'package:loono/ui/screens/settings/photo_cropped_result.dart';
import 'package:loono/ui/screens/welcome.dart';
import 'package:loono/ui/widgets/achievement_screen.dart';

const _onboardingTransition = TransitionsBuilders.slideLeft;
const _preventionTransition = TransitionsBuilders.slideLeft;
const _findDoctorTransition = TransitionsBuilders.slideLeft;
const _settingsTransition = TransitionsBuilders.slideLeft;
const _customFormTransition = TransitionsBuilders.slideBottom;

// After editing this, run:
// flutter pub run build_runner build --delete-conflicting-outputs
@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    _appStartUpRouter,
    ..._preAuthRoutes,
    _postAuthRouter,
    _forceUpdateRoute,
  ],
)
class $AppRouter {}

const _appStartUpRouter = AutoRoute<void>(
  path: 'app-start-up',
  page: AppStartUpWrapperScreen,
  children: [
    AutoRoute<void>(page: WelcomeScreen, path: 'welcome'),
    _preAuthMainScreenRouter,
  ],
);

/// Only Onboarding Form, Find a Doctor and About Health screens are accessible.
const _preAuthRoutes = <AutoRoute>[
  _preAuthMainScreenRouter,
  AutoRoute<void>(page: IntroCarouselScreen, path: 'intro-carousel'),
  _onboardingQuestionnaireRouter,
  _allowNotificationRoute,
  AutoRoute<void>(page: FillOnboardingFormLaterScreen, path: 'fill-form-later'),
  _badgeOverviewRoute,
  AutoRoute<void>(page: NicknameScreen, path: 'fallback-account/name'),
  AutoRoute<void>(page: EmailScreen, path: 'fallback-account/email'),
  _loginRoute,
  ..._findDoctorRoutes,
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
    AutoRoute<void>(
      page: MainScreen,
      path: '',
      children: [
        CustomRoute<void>(
          page: PreventionScreen,
          path: 'prevention',
          transitionsBuilder: _preventionTransition,
        ),
        ..._findDoctorRoutes,
        _aboutHealthRoute,
      ],
    ),
    _badgeOverviewRoute,
    ..._preventionRoutes,
    ..._settingsRoutes,
    ..._selfExaminationRoutes,
    ..._customExamForm
  ],
);

const _preAuthMainScreenRouter = AutoRoute<void>(
  path: 'pre-auth-main',
  page: PreAuthMainScreen,
  children: [
    _preAuthPreventionRouter,
    ..._findDoctorRoutes,
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
const _allowNotificationRoute = CustomRoute<void>(
  page: AllowNotificationsScreen,
  path: 'allow-notifications',
  transitionsBuilder: _onboardingTransition,
);
const _aboutHealthRoute = AutoRoute<void>(page: AboutHealthScreen, path: 'about-health');
const _forceUpdateRoute = AutoRoute<void>(page: ForceUpdateScreen, path: 'force-update');
const _badgeOverviewRoute = AutoRoute<void>(page: BadgeOverviewScreen, path: 'badge-overview');

const _findDoctorRoutes = <AutoRoute>[
  AutoRoute<void>(page: FindDoctorScreen, path: 'find-doctor'),
  CustomRoute<SearchResult>(
    page: DoctorSearchDetailScreen,
    path: 'find-doctor/search/detail',
    transitionsBuilder: _findDoctorTransition,
  ),
  CustomRoute<SearchResult>(
    page: NoPermissionsScreen,
    path: 'find-doctor/permissions',
    transitionsBuilder: _findDoctorTransition,
  ),
];

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
    _allowNotificationRoute,
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
    page: AfterDeletionScreen,
    path: 'settings/update-profile/delete/after-deletion',
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
];

const _selfExaminationRoutes = <AutoRoute>[
  CustomRoute<void>(
    page: SelfExaminationDetailScreen,
    path: 'self-examination/detail',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: EducationalVideoScreen,
    path: 'self-examination/detail/educational-video',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: HasFindingScreen,
    path: 'self-examination/detail/has-finding',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: NoFindingScreen,
    path: 'self-examination/detail/no-finding',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: ProgressRewardScreen,
    path: 'self-examination/detail/progress-reward',
    transitionsBuilder: _preventionTransition,
  ),
  CustomRoute<void>(
    page: ResultFromDoctorScreen,
    path: 'self-examination/detail/reusult-from-doctor',
    transitionsBuilder: _preventionTransition,
  ),
];

const _customExamForm = <AutoRoute>[
  CustomRoute<void>(page: CustomExamFormScreen, path: 'custom-exam-form'),
  CustomRoute<void>(
    page: ChooseCustomExaminationTypeScreen,
    path: 'custom-exam-form-choose-examination',
    transitionsBuilder: _customFormTransition,
  ),
  CustomRoute<void>(
    page: ChooseSpecialistScreen,
    path: 'custom-exam-form-choose-provider',
    transitionsBuilder: _customFormTransition,
  ),
  CustomRoute<void>(
    page: ChooseExamPeriodDateScreen,
    path: 'custom-exam-form-choose-period-date',
    transitionsBuilder: _customFormTransition,
  ),
  CustomRoute<void>(
    page: ChooseExamPeriodTimeScreen,
    path: 'custom-exam-form-choose-period-time',
    transitionsBuilder: _customFormTransition,
  ),
  CustomRoute<void>(
    page: ChooseFrequencyOfExamScreen,
    path: 'custom-exam-form-choose-exam-frequency',
    transitionsBuilder: _customFormTransition,
  )
];
