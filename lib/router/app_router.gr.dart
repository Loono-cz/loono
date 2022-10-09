// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:built_collection/built_collection.dart' as _i73;
import 'package:flutter/material.dart' as _i63;
import 'package:loono_api/loono_api.dart' as _i67;
import 'package:moor/moor.dart' as _i71;

import '../helpers/examination_category.dart' as _i69;
import '../models/categorized_examination.dart' as _i68;
import '../models/search_result.dart' as _i65;
import '../models/social_login_account.dart' as _i66;
import '../services/db/database.dart' as _i70;
import '../ui/screens/about_health/about_health.dart' as _i20;
import '../ui/screens/custom_exam_form/choose_exam_period_date_screen.dart'
    as _i59;
import '../ui/screens/custom_exam_form/choose_exam_period_time_screen.dart'
    as _i60;
import '../ui/screens/custom_exam_form/choose_examination_screen.dart' as _i57;
import '../ui/screens/custom_exam_form/choose_frequency_of_exam_screen.dart'
    as _i61;
import '../ui/screens/custom_exam_form/choose_specialist_screen.dart' as _i58;
import '../ui/screens/custom_exam_form/custom_exam_form_screen.dart' as _i56;
import '../ui/screens/dentist_achievement.dart' as _i33;
import '../ui/screens/find_doctor/doctor_search_detail.dart' as _i13;
import '../ui/screens/find_doctor/find_doctor.dart' as _i12;
import '../ui/screens/find_doctor/no_permissions_screen.dart' as _i14;
import '../ui/screens/force_update.dart' as _i17;
import '../ui/screens/general_practicioner_achievement.dart' as _i27;
import '../ui/screens/gynecology_achievement.dart' as _i30;
import '../ui/screens/logout.dart' as _i15;
import '../ui/screens/main/main_screen.dart' as _i35;
import '../ui/screens/main/pre_auth/continue_onboarding_form.dart' as _i22;
import '../ui/screens/main/pre_auth/login.dart' as _i11;
import '../ui/screens/main/pre_auth/onboarding_form_done.dart' as _i23;
import '../ui/screens/main/pre_auth/pre_auth_main_screen.dart' as _i2;
import '../ui/screens/main/pre_auth/start_new_questionnaire.dart' as _i21;
import '../ui/screens/onboarding/allow_notifications.dart' as _i5;
import '../ui/screens/onboarding/badge_overview.dart' as _i7;
import '../ui/screens/onboarding/birthdate.dart' as _i25;
import '../ui/screens/onboarding/carousel/carousel.dart' as _i3;
import '../ui/screens/onboarding/doctors/dentist.dart' as _i32;
import '../ui/screens/onboarding/doctors/dentist_date.dart' as _i34;
import '../ui/screens/onboarding/doctors/general_practicioner.dart' as _i26;
import '../ui/screens/onboarding/doctors/general_practitioner_date.dart'
    as _i28;
import '../ui/screens/onboarding/doctors/gynecology.dart' as _i29;
import '../ui/screens/onboarding/doctors/gynecology_date.dart' as _i31;
import '../ui/screens/onboarding/fallback_account/email.dart' as _i9;
import '../ui/screens/onboarding/fallback_account/newsletter_and_gdpr.dart'
    as _i10;
import '../ui/screens/onboarding/fallback_account/nickname.dart' as _i8;
import '../ui/screens/onboarding/fill_form_later.dart' as _i6;
import '../ui/screens/onboarding/gender.dart' as _i24;
import '../ui/screens/prevention/calendar/calendar_list.dart' as _i40;
import '../ui/screens/prevention/calendar/permission_info.dart' as _i39;
import '../ui/screens/prevention/examination_detail/change_last_visit_screen.dart'
    as _i41;
import '../ui/screens/prevention/examination_detail/examination_screen.dart'
    as _i36;
import '../ui/screens/prevention/prevention_screen.dart' as _i62;
import '../ui/screens/prevention/questionnaire/date_picker_screen.dart' as _i38;
import '../ui/screens/prevention/self_examination/detail_screen.dart' as _i50;
import '../ui/screens/prevention/self_examination/educational_screen.dart'
    as _i51;
import '../ui/screens/prevention/self_examination/has_finding_screen.dart'
    as _i52;
import '../ui/screens/prevention/self_examination/no_finding_screen.dart'
    as _i53;
import '../ui/screens/prevention/self_examination/progress_screen.dart' as _i54;
import '../ui/screens/prevention/self_examination/result_from_doctor.dart'
    as _i55;
import '../ui/screens/settings/after_deletion.dart' as _i46;
import '../ui/screens/settings/camera_photo_taken.dart' as _i47;
import '../ui/screens/settings/delete_account.dart' as _i45;
import '../ui/screens/settings/edit_email.dart' as _i43;
import '../ui/screens/settings/edit_nickname.dart' as _i42;
import '../ui/screens/settings/edit_photo.dart' as _i44;
import '../ui/screens/settings/gallery_photo_taken.dart' as _i48;
import '../ui/screens/settings/photo_cropped_result.dart' as _i49;
import '../ui/screens/settings/settings_bottom_sheet.dart' as _i72;
import '../ui/screens/welcome.dart' as _i18;
import '../ui/widgets/achievement_screen.dart' as _i37;
import 'guards/check_is_logged_in.dart' as _i64;
import 'sub_routers/app_startup_wrapper_screen.dart' as _i1;
import 'sub_routers/onboarding_wrapper_screen.dart' as _i4;
import 'sub_routers/pre_auth_prevention_wrapper_screen.dart' as _i19;

class AppRouter extends _i16.RootStackRouter {
  AppRouter(
      {_i63.GlobalKey<_i63.NavigatorState>? navigatorKey,
      required this.checkIsLoggedIn})
      : super(navigatorKey);

  final _i64.CheckIsLoggedIn checkIsLoggedIn;

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    AppStartUpWrapperRoute.name: (routeData) {
      return _i16.MaterialPageX<void>(
          routeData: routeData, child: const _i1.AppStartUpWrapperScreen());
    },
    PreAuthMainRoute.name: (routeData) {
      final args = routeData.argsAs<PreAuthMainRouteArgs>(
          orElse: () => const PreAuthMainRouteArgs());
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: _i2.PreAuthMainScreen(
              key: args.key,
              overridenPreventionRoute: args.overridenPreventionRoute));
    },
    IntroCarouselRoute.name: (routeData) {
      return _i16.MaterialPageX<void>(
          routeData: routeData, child: const _i3.IntroCarouselScreen());
    },
    OnboardingWrapperRoute.name: (routeData) {
      return _i16.MaterialPageX<void>(
          routeData: routeData, child: const _i4.OnboardingWrapperScreen());
    },
    AllowNotificationsRoute.name: (routeData) {
      final args = routeData.argsAs<AllowNotificationsRouteArgs>(
          orElse: () => const AllowNotificationsRouteArgs());
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i5.AllowNotificationsScreen(
              key: args.key,
              onSkipTap: args.onSkipTap,
              onContinueTap: args.onContinueTap),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    FillOnboardingFormLaterRoute.name: (routeData) {
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: const _i6.FillOnboardingFormLaterScreen());
    },
    BadgeOverviewRoute.name: (routeData) {
      final args = routeData.argsAs<BadgeOverviewRouteArgs>(
          orElse: () => const BadgeOverviewRouteArgs());
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: _i7.BadgeOverviewScreen(
              key: args.key, onButtonTap: args.onButtonTap));
    },
    NicknameRoute.name: (routeData) {
      final args = routeData.argsAs<NicknameRouteArgs>();
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: _i8.NicknameScreen(
              key: args.key, socialLoginAccount: args.socialLoginAccount));
    },
    EmailRoute.name: (routeData) {
      final args = routeData.argsAs<EmailRouteArgs>();
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: _i9.EmailScreen(
              key: args.key, socialLoginAccount: args.socialLoginAccount));
    },
    NewsletterAndGDPRRoute.name: (routeData) {
      final args = routeData.argsAs<NewsletterAndGDPRRouteArgs>();
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: _i10.NewsletterAndGDPRScreen(
              socialLoginAccount: args.socialLoginAccount, key: args.key));
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i16.MaterialPageX<void>(
          routeData: routeData, child: _i11.LoginScreen(key: args.key));
    },
    FindDoctorRoute.name: (routeData) {
      final args = routeData.argsAs<FindDoctorRouteArgs>(
          orElse: () => const FindDoctorRouteArgs());
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: _i12.FindDoctorScreen(
              key: args.key, onCancelTap: args.onCancelTap));
    },
    DoctorSearchDetailRoute.name: (routeData) {
      return _i16.CustomPage<_i65.SearchResult>(
          routeData: routeData,
          child: const _i13.DoctorSearchDetailScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    NoPermissionsRoute.name: (routeData) {
      return _i16.CustomPage<_i65.SearchResult>(
          routeData: routeData,
          child: const _i14.NoPermissionsScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    LogoutRoute.name: (routeData) {
      return _i16.MaterialPageX<void>(
          routeData: routeData, child: const _i15.LogoutScreen());
    },
    MainScreenRouter.name: (routeData) {
      return _i16.MaterialPageX<void>(
          routeData: routeData, child: const _i16.EmptyRouterScreen());
    },
    ForceUpdateRoute.name: (routeData) {
      return _i16.MaterialPageX<void>(
          routeData: routeData, child: const _i17.ForceUpdateScreen());
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i16.MaterialPageX<void>(
          routeData: routeData, child: _i18.WelcomeScreen(key: args.key));
    },
    PreAuthPreventionWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<PreAuthPreventionWrapperRouteArgs>(
          orElse: () => const PreAuthPreventionWrapperRouteArgs());
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: _i19.PreAuthPreventionWrapperScreen(
              key: args.key, forceRoute: args.forceRoute));
    },
    AboutHealthRoute.name: (routeData) {
      final args = routeData.argsAs<AboutHealthRouteArgs>(
          orElse: () => const AboutHealthRouteArgs());
      return _i16.MaterialPageX<void>(
          routeData: routeData, child: _i20.AboutHealthScreen(key: args.key));
    },
    StartNewQuestionnaireRoute.name: (routeData) {
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: const _i21.StartNewQuestionnaireScreen());
    },
    ContinueOnboardingFormRoute.name: (routeData) {
      final args = routeData.argsAs<ContinueOnboardingFormRouteArgs>(
          orElse: () => const ContinueOnboardingFormRouteArgs());
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: _i22.ContinueOnboardingFormScreen(key: args.key));
    },
    OnboardingFormDoneRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingFormDoneRouteArgs>(
          orElse: () => const OnboardingFormDoneRouteArgs());
      return _i16.MaterialPageX<void>(
          routeData: routeData,
          child: _i23.OnboardingFormDoneScreen(key: args.key));
    },
    OnboardingGenderRoute.name: (routeData) {
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: const _i24.OnboardingGenderScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnBoardingBirthdateRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingBirthdateRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i25.OnBoardingBirthdateScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGeneralPracticionerRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGeneralPracticionerRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i26.OnboardingGeneralPracticionerScreen(
              key: args.key, sex: args.sex),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPracticionerAchievementRoute.name: (routeData) {
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: const _i27.GeneralPracticionerAchievementScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPractitionerDateRoute.name: (routeData) {
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: const _i28.GeneralPractitionerDateScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGynecologyRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGynecologyRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i29.OnboardingGynecologyScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyAchievementRoute.name: (routeData) {
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: const _i30.GynecologyAchievementScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyDateRoute.name: (routeData) {
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: const _i31.GynecologyDateScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingDentistRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingDentistRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i32.OnboardingDentistScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistAchievementRoute.name: (routeData) {
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: const _i33.DentistAchievementScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistDateRoute.name: (routeData) {
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: const _i34.DentistDateScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    MainRoute.name: (routeData) {
      return _i16.MaterialPageX<void>(
          routeData: routeData, child: const _i35.MainScreen());
    },
    ExaminationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ExaminationDetailRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i36.ExaminationDetailScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination,
              initialMessage: args.initialMessage),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AchievementRoute.name: (routeData) {
      final args = routeData.argsAs<AchievementRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i37.AchievementScreen(
              key: args.key,
              header: args.header,
              textLines: args.textLines,
              numberOfPoints: args.numberOfPoints,
              itemPath: args.itemPath,
              onButtonTap: args.onButtonTap),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DatePickerRoute.name: (routeData) {
      final args = routeData.argsAs<DatePickerRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i38.DatePickerScreen(
              key: args.key,
              assetPath: args.assetPath,
              title: args.title,
              onContinueButtonPress: args.onContinueButtonPress,
              onSkipButtonPress: args.onSkipButtonPress),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CalendarPermissionInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarPermissionInfoRouteArgs>();
      return _i16.CustomPage<bool>(
          routeData: routeData,
          child: _i39.CalendarPermissionInfoScreen(
              key: args.key, examinationRecord: args.examinationRecord),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CalendarListRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarListRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i40.CalendarListScreen(
              key: args.key, examinationRecord: args.examinationRecord),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ChangeLastVisitRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeLastVisitRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i41.ChangeLastVisitScreen(
              key: args.key,
              originalDate: args.originalDate,
              title: args.title,
              examinationType: args.examinationType,
              uuid: args.uuid,
              status: args.status),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditNicknameRoute.name: (routeData) {
      final args = routeData.argsAs<EditNicknameRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i42.EditNicknameScreen(key: args.key, user: args.user),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditEmailRoute.name: (routeData) {
      final args = routeData.argsAs<EditEmailRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i43.EditEmailScreen(key: args.key, user: args.user),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditPhotoRoute.name: (routeData) {
      final args = routeData.argsAs<EditPhotoRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i44.EditPhotoScreen(
              key: args.key,
              imageBytes: args.imageBytes,
              changePage: args.changePage),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DeleteAccountRoute.name: (routeData) {
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: const _i45.DeleteAccountScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AfterDeletionRoute.name: (routeData) {
      final args = routeData.argsAs<AfterDeletionRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i46.AfterDeletionScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CameraPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<CameraPhotoTakenRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i47.CameraPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GalleryPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<GalleryPhotoTakenRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i48.GalleryPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    PhotoCroppedResultRoute.name: (routeData) {
      final args = routeData.argsAs<PhotoCroppedResultRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i49.PhotoCroppedResultScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    SelfExaminationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SelfExaminationDetailRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i50.SelfExaminationDetailScreen(
              key: args.key,
              sex: args.sex,
              selfExamination: args.selfExamination),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EducationalVideoRoute.name: (routeData) {
      final args = routeData.argsAs<EducationalVideoRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i51.EducationalVideoScreen(
              key: args.key,
              sex: args.sex,
              selfExamination: args.selfExamination),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HasFindingRoute.name: (routeData) {
      final args = routeData.argsAs<HasFindingRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i52.HasFindingScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    NoFindingRoute.name: (routeData) {
      final args = routeData.argsAs<NoFindingRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i53.NoFindingScreen(
              key: args.key,
              points: args.points,
              history: args.history,
              badgeType: args.badgeType),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ProgressRewardRoute.name: (routeData) {
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: const _i54.ProgressRewardScreen(),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ResultFromDoctorRoute.name: (routeData) {
      final args = routeData.argsAs<ResultFromDoctorRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i55.ResultFromDoctorScreen(
              key: args.key,
              sex: args.sex,
              selfExamination: args.selfExamination),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CustomExamFormRoute.name: (routeData) {
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: const _i56.CustomExamFormScreen(),
          opaque: true,
          barrierDismissible: false);
    },
    ChooseCustomExaminationTypeRoute.name: (routeData) {
      final args = routeData.argsAs<ChooseCustomExaminationTypeRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i57.ChooseCustomExaminationTypeScreen(
              actionType: args.actionType,
              onActionTypeSet: args.onActionTypeSet,
              key: args.key),
          transitionsBuilder: _i16.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    ChooseSpecialistRoute.name: (routeData) {
      final args = routeData.argsAs<ChooseSpecialistRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i58.ChooseSpecialistScreen(
              specialist: args.specialist,
              onProviderSet: args.onProviderSet,
              key: args.key),
          transitionsBuilder: _i16.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    ChooseExamPeriodDateRoute.name: (routeData) {
      final args = routeData.argsAs<ChooseExamPeriodDateRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i59.ChooseExamPeriodDateScreen(
              dateTime: args.dateTime,
              onValueChange: args.onValueChange,
              label: args.label,
              pickTime: args.pickTime,
              showLastExamDate: args.showLastExamDate,
              isLastExamChoose: args.isLastExamChoose,
              key: args.key),
          transitionsBuilder: _i16.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    ChooseExamPeriodTimeRoute.name: (routeData) {
      final args = routeData.argsAs<ChooseExamPeriodTimeRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i60.ChooseExamPeriodTimeScreen(
              key: args.key,
              dateTime: args.dateTime,
              onTimeSet: args.onTimeSet),
          transitionsBuilder: _i16.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    ChooseFrequencyOfExamRoute.name: (routeData) {
      final args = routeData.argsAs<ChooseFrequencyOfExamRouteArgs>();
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i61.ChooseFrequencyOfExamScreen(
              key: args.key,
              value: args.value,
              valueChanged: args.valueChanged,
              isDefaultExam: args.isDefaultExam,
              examType: args.examType),
          transitionsBuilder: _i16.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    PreventionRoute.name: (routeData) {
      final args = routeData.argsAs<PreventionRouteArgs>(
          orElse: () => const PreventionRouteArgs());
      return _i16.CustomPage<void>(
          routeData: routeData,
          child: _i62.PreventionScreen(key: args.key),
          transitionsBuilder: _i16.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i16.RouteConfig> get routes => [
        _i16.RouteConfig('/#redirect',
            path: '/', redirectTo: 'main', fullMatch: true),
        _i16.RouteConfig(AppStartUpWrapperRoute.name,
            path: 'app-start-up',
            children: [
              _i16.RouteConfig(WelcomeRoute.name,
                  path: 'welcome', parent: AppStartUpWrapperRoute.name),
              _i16.RouteConfig(PreAuthMainRoute.name,
                  path: 'pre-auth-main',
                  parent: AppStartUpWrapperRoute.name,
                  children: [
                    _i16.RouteConfig(PreAuthPreventionWrapperRoute.name,
                        path: 'pre-auth-prevention',
                        parent: PreAuthMainRoute.name,
                        children: [
                          _i16.RouteConfig(LoginRoute.name,
                              path: 'login',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i16.RouteConfig(StartNewQuestionnaireRoute.name,
                              path: 'start-new-questionnaire',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i16.RouteConfig(ContinueOnboardingFormRoute.name,
                              path: 'continue-onboarding-form',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i16.RouteConfig(OnboardingFormDoneRoute.name,
                              path: 'onboarding-form-done',
                              parent: PreAuthPreventionWrapperRoute.name)
                        ]),
                    _i16.RouteConfig(FindDoctorRoute.name,
                        path: 'find-doctor', parent: PreAuthMainRoute.name),
                    _i16.RouteConfig(DoctorSearchDetailRoute.name,
                        path: 'find-doctor/search/detail',
                        parent: PreAuthMainRoute.name),
                    _i16.RouteConfig(NoPermissionsRoute.name,
                        path: 'find-doctor/permissions',
                        parent: PreAuthMainRoute.name),
                    _i16.RouteConfig(AboutHealthRoute.name,
                        path: 'about-health', parent: PreAuthMainRoute.name)
                  ])
            ]),
        _i16.RouteConfig(PreAuthMainRoute.name,
            path: 'pre-auth-main',
            children: [
              _i16.RouteConfig(PreAuthPreventionWrapperRoute.name,
                  path: 'pre-auth-prevention',
                  parent: PreAuthMainRoute.name,
                  children: [
                    _i16.RouteConfig(LoginRoute.name,
                        path: 'login',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i16.RouteConfig(StartNewQuestionnaireRoute.name,
                        path: 'start-new-questionnaire',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i16.RouteConfig(ContinueOnboardingFormRoute.name,
                        path: 'continue-onboarding-form',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i16.RouteConfig(OnboardingFormDoneRoute.name,
                        path: 'onboarding-form-done',
                        parent: PreAuthPreventionWrapperRoute.name)
                  ]),
              _i16.RouteConfig(FindDoctorRoute.name,
                  path: 'find-doctor', parent: PreAuthMainRoute.name),
              _i16.RouteConfig(DoctorSearchDetailRoute.name,
                  path: 'find-doctor/search/detail',
                  parent: PreAuthMainRoute.name),
              _i16.RouteConfig(NoPermissionsRoute.name,
                  path: 'find-doctor/permissions',
                  parent: PreAuthMainRoute.name),
              _i16.RouteConfig(AboutHealthRoute.name,
                  path: 'about-health', parent: PreAuthMainRoute.name)
            ]),
        _i16.RouteConfig(IntroCarouselRoute.name, path: 'intro-carousel'),
        _i16.RouteConfig(OnboardingWrapperRoute.name,
            path: 'onboarding',
            children: [
              _i16.RouteConfig(OnboardingGenderRoute.name,
                  path: 'gender', parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(OnBoardingBirthdateRoute.name,
                  path: 'birthdate', parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(OnboardingGeneralPracticionerRoute.name,
                  path: 'doctor/general-practicioner',
                  parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(GeneralPracticionerAchievementRoute.name,
                  path: 'general-practicioner-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(GeneralPractitionerDateRoute.name,
                  path: 'doctor/general-practitioner-date',
                  parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(AllowNotificationsRoute.name,
                  path: 'allow-notifications',
                  parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(OnboardingGynecologyRoute.name,
                  path: 'doctor/gynecology',
                  parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(GynecologyAchievementRoute.name,
                  path: 'gynecology-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(GynecologyDateRoute.name,
                  path: 'doctor/gynecology-date',
                  parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(OnboardingDentistRoute.name,
                  path: 'doctor/dentist', parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(DentistAchievementRoute.name,
                  path: 'dentist-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i16.RouteConfig(DentistDateRoute.name,
                  path: 'doctor/dentist-date',
                  parent: OnboardingWrapperRoute.name)
            ]),
        _i16.RouteConfig(AllowNotificationsRoute.name,
            path: 'allow-notifications'),
        _i16.RouteConfig(FillOnboardingFormLaterRoute.name,
            path: 'fill-form-later'),
        _i16.RouteConfig(BadgeOverviewRoute.name, path: 'badge-overview'),
        _i16.RouteConfig(NicknameRoute.name, path: 'fallback-account/name'),
        _i16.RouteConfig(EmailRoute.name, path: 'fallback-account/email'),
        _i16.RouteConfig(NewsletterAndGDPRRoute.name,
            path: 'fallback-account/newsletter-gdpr'),
        _i16.RouteConfig(LoginRoute.name, path: 'login'),
        _i16.RouteConfig(FindDoctorRoute.name, path: 'find-doctor'),
        _i16.RouteConfig(DoctorSearchDetailRoute.name,
            path: 'find-doctor/search/detail'),
        _i16.RouteConfig(NoPermissionsRoute.name,
            path: 'find-doctor/permissions'),
        _i16.RouteConfig(LogoutRoute.name, path: 'logout'),
        _i16.RouteConfig(MainScreenRouter.name, path: 'main', guards: [
          checkIsLoggedIn
        ], children: [
          _i16.RouteConfig(MainRoute.name,
              path: '',
              parent: MainScreenRouter.name,
              children: [
                _i16.RouteConfig(PreventionRoute.name,
                    path: 'prevention', parent: MainRoute.name),
                _i16.RouteConfig(FindDoctorRoute.name,
                    path: 'find-doctor', parent: MainRoute.name),
                _i16.RouteConfig(DoctorSearchDetailRoute.name,
                    path: 'find-doctor/search/detail', parent: MainRoute.name),
                _i16.RouteConfig(NoPermissionsRoute.name,
                    path: 'find-doctor/permissions', parent: MainRoute.name),
                _i16.RouteConfig(AboutHealthRoute.name,
                    path: 'about-health', parent: MainRoute.name)
              ]),
          _i16.RouteConfig(BadgeOverviewRoute.name,
              path: 'badge-overview', parent: MainScreenRouter.name),
          _i16.RouteConfig(ExaminationDetailRoute.name,
              path: 'prevention-detail', parent: MainScreenRouter.name),
          _i16.RouteConfig(AchievementRoute.name,
              path: 'questionnaire/reward', parent: MainScreenRouter.name),
          _i16.RouteConfig(DatePickerRoute.name,
              path: 'questionnaire/date-picker', parent: MainScreenRouter.name),
          _i16.RouteConfig(CalendarPermissionInfoRoute.name,
              path: 'calendar/permission', parent: MainScreenRouter.name),
          _i16.RouteConfig(CalendarListRoute.name,
              path: 'calendar/list', parent: MainScreenRouter.name),
          _i16.RouteConfig(ChangeLastVisitRoute.name,
              path: 'checkup/last-visit-update', parent: MainScreenRouter.name),
          _i16.RouteConfig(EditNicknameRoute.name,
              path: 'settings/update-profile/nickname',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(EditEmailRoute.name,
              path: 'settings/update-profile/email',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(EditPhotoRoute.name,
              path: 'settings/update-profile/photo',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(DeleteAccountRoute.name,
              path: 'settings/update-profile/delete',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(AfterDeletionRoute.name,
              path: 'settings/update-profile/delete/after-deletion',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(CameraPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/camera-taken',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(GalleryPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/gallery-taken',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(PhotoCroppedResultRoute.name,
              path: 'settings/update-profile/photo/photo-cropped-result',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(SelfExaminationDetailRoute.name,
              path: 'self-examination/detail', parent: MainScreenRouter.name),
          _i16.RouteConfig(EducationalVideoRoute.name,
              path: 'self-examination/detail/educational-video',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(HasFindingRoute.name,
              path: 'self-examination/detail/has-finding',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(NoFindingRoute.name,
              path: 'self-examination/detail/no-finding',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(ProgressRewardRoute.name,
              path: 'self-examination/detail/progress-reward',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(ResultFromDoctorRoute.name,
              path: 'self-examination/detail/reusult-from-doctor',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(CustomExamFormRoute.name,
              path: 'custom-exam-form', parent: MainScreenRouter.name),
          _i16.RouteConfig(ChooseCustomExaminationTypeRoute.name,
              path: 'custom-exam-form-choose-examination',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(ChooseSpecialistRoute.name,
              path: 'custom-exam-form-choose-provider',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(ChooseExamPeriodDateRoute.name,
              path: 'custom-exam-form-choose-period-date',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(ChooseExamPeriodTimeRoute.name,
              path: 'custom-exam-form-choose-period-time',
              parent: MainScreenRouter.name),
          _i16.RouteConfig(ChooseFrequencyOfExamRoute.name,
              path: 'custom-exam-form-choose-exam-frequency',
              parent: MainScreenRouter.name)
        ]),
        _i16.RouteConfig(ForceUpdateRoute.name, path: 'force-update')
      ];
}

/// generated route for
/// [_i1.AppStartUpWrapperScreen]
class AppStartUpWrapperRoute extends _i16.PageRouteInfo<void> {
  const AppStartUpWrapperRoute({List<_i16.PageRouteInfo>? children})
      : super(AppStartUpWrapperRoute.name,
            path: 'app-start-up', initialChildren: children);

  static const String name = 'AppStartUpWrapperRoute';
}

/// generated route for
/// [_i2.PreAuthMainScreen]
class PreAuthMainRoute extends _i16.PageRouteInfo<PreAuthMainRouteArgs> {
  PreAuthMainRoute(
      {_i63.Key? key,
      _i16.PageRouteInfo<dynamic>? overridenPreventionRoute,
      List<_i16.PageRouteInfo>? children})
      : super(PreAuthMainRoute.name,
            path: 'pre-auth-main',
            args: PreAuthMainRouteArgs(
                key: key, overridenPreventionRoute: overridenPreventionRoute),
            initialChildren: children);

  static const String name = 'PreAuthMainRoute';
}

class PreAuthMainRouteArgs {
  const PreAuthMainRouteArgs({this.key, this.overridenPreventionRoute});

  final _i63.Key? key;

  final _i16.PageRouteInfo<dynamic>? overridenPreventionRoute;

  @override
  String toString() {
    return 'PreAuthMainRouteArgs{key: $key, overridenPreventionRoute: $overridenPreventionRoute}';
  }
}

/// generated route for
/// [_i3.IntroCarouselScreen]
class IntroCarouselRoute extends _i16.PageRouteInfo<void> {
  const IntroCarouselRoute()
      : super(IntroCarouselRoute.name, path: 'intro-carousel');

  static const String name = 'IntroCarouselRoute';
}

/// generated route for
/// [_i4.OnboardingWrapperScreen]
class OnboardingWrapperRoute extends _i16.PageRouteInfo<void> {
  const OnboardingWrapperRoute({List<_i16.PageRouteInfo>? children})
      : super(OnboardingWrapperRoute.name,
            path: 'onboarding', initialChildren: children);

  static const String name = 'OnboardingWrapperRoute';
}

/// generated route for
/// [_i5.AllowNotificationsScreen]
class AllowNotificationsRoute
    extends _i16.PageRouteInfo<AllowNotificationsRouteArgs> {
  AllowNotificationsRoute(
      {_i63.Key? key,
      void Function()? onSkipTap,
      void Function()? onContinueTap})
      : super(AllowNotificationsRoute.name,
            path: 'allow-notifications',
            args: AllowNotificationsRouteArgs(
                key: key, onSkipTap: onSkipTap, onContinueTap: onContinueTap));

  static const String name = 'AllowNotificationsRoute';
}

class AllowNotificationsRouteArgs {
  const AllowNotificationsRouteArgs(
      {this.key, this.onSkipTap, this.onContinueTap});

  final _i63.Key? key;

  final void Function()? onSkipTap;

  final void Function()? onContinueTap;

  @override
  String toString() {
    return 'AllowNotificationsRouteArgs{key: $key, onSkipTap: $onSkipTap, onContinueTap: $onContinueTap}';
  }
}

/// generated route for
/// [_i6.FillOnboardingFormLaterScreen]
class FillOnboardingFormLaterRoute extends _i16.PageRouteInfo<void> {
  const FillOnboardingFormLaterRoute()
      : super(FillOnboardingFormLaterRoute.name, path: 'fill-form-later');

  static const String name = 'FillOnboardingFormLaterRoute';
}

/// generated route for
/// [_i7.BadgeOverviewScreen]
class BadgeOverviewRoute extends _i16.PageRouteInfo<BadgeOverviewRouteArgs> {
  BadgeOverviewRoute({_i63.Key? key, void Function()? onButtonTap})
      : super(BadgeOverviewRoute.name,
            path: 'badge-overview',
            args: BadgeOverviewRouteArgs(key: key, onButtonTap: onButtonTap));

  static const String name = 'BadgeOverviewRoute';
}

class BadgeOverviewRouteArgs {
  const BadgeOverviewRouteArgs({this.key, this.onButtonTap});

  final _i63.Key? key;

  final void Function()? onButtonTap;

  @override
  String toString() {
    return 'BadgeOverviewRouteArgs{key: $key, onButtonTap: $onButtonTap}';
  }
}

/// generated route for
/// [_i8.NicknameScreen]
class NicknameRoute extends _i16.PageRouteInfo<NicknameRouteArgs> {
  NicknameRoute(
      {_i63.Key? key, required _i66.SocialLoginAccount? socialLoginAccount})
      : super(NicknameRoute.name,
            path: 'fallback-account/name',
            args: NicknameRouteArgs(
                key: key, socialLoginAccount: socialLoginAccount));

  static const String name = 'NicknameRoute';
}

class NicknameRouteArgs {
  const NicknameRouteArgs({this.key, required this.socialLoginAccount});

  final _i63.Key? key;

  final _i66.SocialLoginAccount? socialLoginAccount;

  @override
  String toString() {
    return 'NicknameRouteArgs{key: $key, socialLoginAccount: $socialLoginAccount}';
  }
}

/// generated route for
/// [_i9.EmailScreen]
class EmailRoute extends _i16.PageRouteInfo<EmailRouteArgs> {
  EmailRoute(
      {_i63.Key? key, required _i66.SocialLoginAccount? socialLoginAccount})
      : super(EmailRoute.name,
            path: 'fallback-account/email',
            args: EmailRouteArgs(
                key: key, socialLoginAccount: socialLoginAccount));

  static const String name = 'EmailRoute';
}

class EmailRouteArgs {
  const EmailRouteArgs({this.key, required this.socialLoginAccount});

  final _i63.Key? key;

  final _i66.SocialLoginAccount? socialLoginAccount;

  @override
  String toString() {
    return 'EmailRouteArgs{key: $key, socialLoginAccount: $socialLoginAccount}';
  }
}

/// generated route for
/// [_i10.NewsletterAndGDPRScreen]
class NewsletterAndGDPRRoute
    extends _i16.PageRouteInfo<NewsletterAndGDPRRouteArgs> {
  NewsletterAndGDPRRoute(
      {required _i66.SocialLoginAccount? socialLoginAccount, _i63.Key? key})
      : super(NewsletterAndGDPRRoute.name,
            path: 'fallback-account/newsletter-gdpr',
            args: NewsletterAndGDPRRouteArgs(
                socialLoginAccount: socialLoginAccount, key: key));

  static const String name = 'NewsletterAndGDPRRoute';
}

class NewsletterAndGDPRRouteArgs {
  const NewsletterAndGDPRRouteArgs(
      {required this.socialLoginAccount, this.key});

  final _i66.SocialLoginAccount? socialLoginAccount;

  final _i63.Key? key;

  @override
  String toString() {
    return 'NewsletterAndGDPRRouteArgs{socialLoginAccount: $socialLoginAccount, key: $key}';
  }
}

/// generated route for
/// [_i11.LoginScreen]
class LoginRoute extends _i16.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i63.Key? key})
      : super(LoginRoute.name, path: 'login', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i63.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.FindDoctorScreen]
class FindDoctorRoute extends _i16.PageRouteInfo<FindDoctorRouteArgs> {
  FindDoctorRoute({_i63.Key? key, void Function()? onCancelTap})
      : super(FindDoctorRoute.name,
            path: 'find-doctor',
            args: FindDoctorRouteArgs(key: key, onCancelTap: onCancelTap));

  static const String name = 'FindDoctorRoute';
}

class FindDoctorRouteArgs {
  const FindDoctorRouteArgs({this.key, this.onCancelTap});

  final _i63.Key? key;

  final void Function()? onCancelTap;

  @override
  String toString() {
    return 'FindDoctorRouteArgs{key: $key, onCancelTap: $onCancelTap}';
  }
}

/// generated route for
/// [_i13.DoctorSearchDetailScreen]
class DoctorSearchDetailRoute extends _i16.PageRouteInfo<void> {
  const DoctorSearchDetailRoute()
      : super(DoctorSearchDetailRoute.name, path: 'find-doctor/search/detail');

  static const String name = 'DoctorSearchDetailRoute';
}

/// generated route for
/// [_i14.NoPermissionsScreen]
class NoPermissionsRoute extends _i16.PageRouteInfo<void> {
  const NoPermissionsRoute()
      : super(NoPermissionsRoute.name, path: 'find-doctor/permissions');

  static const String name = 'NoPermissionsRoute';
}

/// generated route for
/// [_i15.LogoutScreen]
class LogoutRoute extends _i16.PageRouteInfo<void> {
  const LogoutRoute() : super(LogoutRoute.name, path: 'logout');

  static const String name = 'LogoutRoute';
}

/// generated route for
/// [_i16.EmptyRouterScreen]
class MainScreenRouter extends _i16.PageRouteInfo<void> {
  const MainScreenRouter({List<_i16.PageRouteInfo>? children})
      : super(MainScreenRouter.name, path: 'main', initialChildren: children);

  static const String name = 'MainScreenRouter';
}

/// generated route for
/// [_i17.ForceUpdateScreen]
class ForceUpdateRoute extends _i16.PageRouteInfo<void> {
  const ForceUpdateRoute() : super(ForceUpdateRoute.name, path: 'force-update');

  static const String name = 'ForceUpdateRoute';
}

/// generated route for
/// [_i18.WelcomeScreen]
class WelcomeRoute extends _i16.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({_i63.Key? key})
      : super(WelcomeRoute.name,
            path: 'welcome', args: WelcomeRouteArgs(key: key));

  static const String name = 'WelcomeRoute';
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i63.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.PreAuthPreventionWrapperScreen]
class PreAuthPreventionWrapperRoute
    extends _i16.PageRouteInfo<PreAuthPreventionWrapperRouteArgs> {
  PreAuthPreventionWrapperRoute(
      {_i63.Key? key,
      _i16.PageRouteInfo<dynamic>? forceRoute,
      List<_i16.PageRouteInfo>? children})
      : super(PreAuthPreventionWrapperRoute.name,
            path: 'pre-auth-prevention',
            args: PreAuthPreventionWrapperRouteArgs(
                key: key, forceRoute: forceRoute),
            initialChildren: children);

  static const String name = 'PreAuthPreventionWrapperRoute';
}

class PreAuthPreventionWrapperRouteArgs {
  const PreAuthPreventionWrapperRouteArgs({this.key, this.forceRoute});

  final _i63.Key? key;

  final _i16.PageRouteInfo<dynamic>? forceRoute;

  @override
  String toString() {
    return 'PreAuthPreventionWrapperRouteArgs{key: $key, forceRoute: $forceRoute}';
  }
}

/// generated route for
/// [_i20.AboutHealthScreen]
class AboutHealthRoute extends _i16.PageRouteInfo<AboutHealthRouteArgs> {
  AboutHealthRoute({_i63.Key? key})
      : super(AboutHealthRoute.name,
            path: 'about-health', args: AboutHealthRouteArgs(key: key));

  static const String name = 'AboutHealthRoute';
}

class AboutHealthRouteArgs {
  const AboutHealthRouteArgs({this.key});

  final _i63.Key? key;

  @override
  String toString() {
    return 'AboutHealthRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i21.StartNewQuestionnaireScreen]
class StartNewQuestionnaireRoute extends _i16.PageRouteInfo<void> {
  const StartNewQuestionnaireRoute()
      : super(StartNewQuestionnaireRoute.name, path: 'start-new-questionnaire');

  static const String name = 'StartNewQuestionnaireRoute';
}

/// generated route for
/// [_i22.ContinueOnboardingFormScreen]
class ContinueOnboardingFormRoute
    extends _i16.PageRouteInfo<ContinueOnboardingFormRouteArgs> {
  ContinueOnboardingFormRoute({_i63.Key? key})
      : super(ContinueOnboardingFormRoute.name,
            path: 'continue-onboarding-form',
            args: ContinueOnboardingFormRouteArgs(key: key));

  static const String name = 'ContinueOnboardingFormRoute';
}

class ContinueOnboardingFormRouteArgs {
  const ContinueOnboardingFormRouteArgs({this.key});

  final _i63.Key? key;

  @override
  String toString() {
    return 'ContinueOnboardingFormRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i23.OnboardingFormDoneScreen]
class OnboardingFormDoneRoute
    extends _i16.PageRouteInfo<OnboardingFormDoneRouteArgs> {
  OnboardingFormDoneRoute({_i63.Key? key})
      : super(OnboardingFormDoneRoute.name,
            path: 'onboarding-form-done',
            args: OnboardingFormDoneRouteArgs(key: key));

  static const String name = 'OnboardingFormDoneRoute';
}

class OnboardingFormDoneRouteArgs {
  const OnboardingFormDoneRouteArgs({this.key});

  final _i63.Key? key;

  @override
  String toString() {
    return 'OnboardingFormDoneRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i24.OnboardingGenderScreen]
class OnboardingGenderRoute extends _i16.PageRouteInfo<void> {
  const OnboardingGenderRoute()
      : super(OnboardingGenderRoute.name, path: 'gender');

  static const String name = 'OnboardingGenderRoute';
}

/// generated route for
/// [_i25.OnBoardingBirthdateScreen]
class OnBoardingBirthdateRoute
    extends _i16.PageRouteInfo<OnBoardingBirthdateRouteArgs> {
  OnBoardingBirthdateRoute({_i63.Key? key, required _i67.Sex sex})
      : super(OnBoardingBirthdateRoute.name,
            path: 'birthdate',
            args: OnBoardingBirthdateRouteArgs(key: key, sex: sex));

  static const String name = 'OnBoardingBirthdateRoute';
}

class OnBoardingBirthdateRouteArgs {
  const OnBoardingBirthdateRouteArgs({this.key, required this.sex});

  final _i63.Key? key;

  final _i67.Sex sex;

  @override
  String toString() {
    return 'OnBoardingBirthdateRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i26.OnboardingGeneralPracticionerScreen]
class OnboardingGeneralPracticionerRoute
    extends _i16.PageRouteInfo<OnboardingGeneralPracticionerRouteArgs> {
  OnboardingGeneralPracticionerRoute({_i63.Key? key, required _i67.Sex sex})
      : super(OnboardingGeneralPracticionerRoute.name,
            path: 'doctor/general-practicioner',
            args: OnboardingGeneralPracticionerRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGeneralPracticionerRoute';
}

class OnboardingGeneralPracticionerRouteArgs {
  const OnboardingGeneralPracticionerRouteArgs({this.key, required this.sex});

  final _i63.Key? key;

  final _i67.Sex sex;

  @override
  String toString() {
    return 'OnboardingGeneralPracticionerRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i27.GeneralPracticionerAchievementScreen]
class GeneralPracticionerAchievementRoute extends _i16.PageRouteInfo<void> {
  const GeneralPracticionerAchievementRoute()
      : super(GeneralPracticionerAchievementRoute.name,
            path: 'general-practicioner-achievement');

  static const String name = 'GeneralPracticionerAchievementRoute';
}

/// generated route for
/// [_i28.GeneralPractitionerDateScreen]
class GeneralPractitionerDateRoute extends _i16.PageRouteInfo<void> {
  const GeneralPractitionerDateRoute()
      : super(GeneralPractitionerDateRoute.name,
            path: 'doctor/general-practitioner-date');

  static const String name = 'GeneralPractitionerDateRoute';
}

/// generated route for
/// [_i29.OnboardingGynecologyScreen]
class OnboardingGynecologyRoute
    extends _i16.PageRouteInfo<OnboardingGynecologyRouteArgs> {
  OnboardingGynecologyRoute({_i63.Key? key, required _i67.Sex sex})
      : super(OnboardingGynecologyRoute.name,
            path: 'doctor/gynecology',
            args: OnboardingGynecologyRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGynecologyRoute';
}

class OnboardingGynecologyRouteArgs {
  const OnboardingGynecologyRouteArgs({this.key, required this.sex});

  final _i63.Key? key;

  final _i67.Sex sex;

  @override
  String toString() {
    return 'OnboardingGynecologyRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i30.GynecologyAchievementScreen]
class GynecologyAchievementRoute extends _i16.PageRouteInfo<void> {
  const GynecologyAchievementRoute()
      : super(GynecologyAchievementRoute.name, path: 'gynecology-achievement');

  static const String name = 'GynecologyAchievementRoute';
}

/// generated route for
/// [_i31.GynecologyDateScreen]
class GynecologyDateRoute extends _i16.PageRouteInfo<void> {
  const GynecologyDateRoute()
      : super(GynecologyDateRoute.name, path: 'doctor/gynecology-date');

  static const String name = 'GynecologyDateRoute';
}

/// generated route for
/// [_i32.OnboardingDentistScreen]
class OnboardingDentistRoute
    extends _i16.PageRouteInfo<OnboardingDentistRouteArgs> {
  OnboardingDentistRoute({_i63.Key? key, required _i67.Sex sex})
      : super(OnboardingDentistRoute.name,
            path: 'doctor/dentist',
            args: OnboardingDentistRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingDentistRoute';
}

class OnboardingDentistRouteArgs {
  const OnboardingDentistRouteArgs({this.key, required this.sex});

  final _i63.Key? key;

  final _i67.Sex sex;

  @override
  String toString() {
    return 'OnboardingDentistRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i33.DentistAchievementScreen]
class DentistAchievementRoute extends _i16.PageRouteInfo<void> {
  const DentistAchievementRoute()
      : super(DentistAchievementRoute.name, path: 'dentist-achievement');

  static const String name = 'DentistAchievementRoute';
}

/// generated route for
/// [_i34.DentistDateScreen]
class DentistDateRoute extends _i16.PageRouteInfo<void> {
  const DentistDateRoute()
      : super(DentistDateRoute.name, path: 'doctor/dentist-date');

  static const String name = 'DentistDateRoute';
}

/// generated route for
/// [_i35.MainScreen]
class MainRoute extends _i16.PageRouteInfo<void> {
  const MainRoute({List<_i16.PageRouteInfo>? children})
      : super(MainRoute.name, path: '', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i36.ExaminationDetailScreen]
class ExaminationDetailRoute
    extends _i16.PageRouteInfo<ExaminationDetailRouteArgs> {
  ExaminationDetailRoute(
      {_i63.Key? key,
      required _i68.CategorizedExamination categorizedExamination,
      String? initialMessage})
      : super(ExaminationDetailRoute.name,
            path: 'prevention-detail',
            args: ExaminationDetailRouteArgs(
                key: key,
                categorizedExamination: categorizedExamination,
                initialMessage: initialMessage));

  static const String name = 'ExaminationDetailRoute';
}

class ExaminationDetailRouteArgs {
  const ExaminationDetailRouteArgs(
      {this.key, required this.categorizedExamination, this.initialMessage});

  final _i63.Key? key;

  final _i68.CategorizedExamination categorizedExamination;

  final String? initialMessage;

  @override
  String toString() {
    return 'ExaminationDetailRouteArgs{key: $key, categorizedExamination: $categorizedExamination, initialMessage: $initialMessage}';
  }
}

/// generated route for
/// [_i37.AchievementScreen]
class AchievementRoute extends _i16.PageRouteInfo<AchievementRouteArgs> {
  AchievementRoute(
      {_i63.Key? key,
      required String header,
      required List<String> textLines,
      required int numberOfPoints,
      required String itemPath,
      required void Function()? onButtonTap})
      : super(AchievementRoute.name,
            path: 'questionnaire/reward',
            args: AchievementRouteArgs(
                key: key,
                header: header,
                textLines: textLines,
                numberOfPoints: numberOfPoints,
                itemPath: itemPath,
                onButtonTap: onButtonTap));

  static const String name = 'AchievementRoute';
}

class AchievementRouteArgs {
  const AchievementRouteArgs(
      {this.key,
      required this.header,
      required this.textLines,
      required this.numberOfPoints,
      required this.itemPath,
      required this.onButtonTap});

  final _i63.Key? key;

  final String header;

  final List<String> textLines;

  final int numberOfPoints;

  final String itemPath;

  final void Function()? onButtonTap;

  @override
  String toString() {
    return 'AchievementRouteArgs{key: $key, header: $header, textLines: $textLines, numberOfPoints: $numberOfPoints, itemPath: $itemPath, onButtonTap: $onButtonTap}';
  }
}

/// generated route for
/// [_i38.DatePickerScreen]
class DatePickerRoute extends _i16.PageRouteInfo<DatePickerRouteArgs> {
  DatePickerRoute(
      {_i63.Key? key,
      required String assetPath,
      required String title,
      required void Function(DateTime)? onContinueButtonPress,
      void Function(DateTime)? onSkipButtonPress})
      : super(DatePickerRoute.name,
            path: 'questionnaire/date-picker',
            args: DatePickerRouteArgs(
                key: key,
                assetPath: assetPath,
                title: title,
                onContinueButtonPress: onContinueButtonPress,
                onSkipButtonPress: onSkipButtonPress));

  static const String name = 'DatePickerRoute';
}

class DatePickerRouteArgs {
  const DatePickerRouteArgs(
      {this.key,
      required this.assetPath,
      required this.title,
      required this.onContinueButtonPress,
      this.onSkipButtonPress});

  final _i63.Key? key;

  final String assetPath;

  final String title;

  final void Function(DateTime)? onContinueButtonPress;

  final void Function(DateTime)? onSkipButtonPress;

  @override
  String toString() {
    return 'DatePickerRouteArgs{key: $key, assetPath: $assetPath, title: $title, onContinueButtonPress: $onContinueButtonPress, onSkipButtonPress: $onSkipButtonPress}';
  }
}

/// generated route for
/// [_i39.CalendarPermissionInfoScreen]
class CalendarPermissionInfoRoute
    extends _i16.PageRouteInfo<CalendarPermissionInfoRouteArgs> {
  CalendarPermissionInfoRoute(
      {_i63.Key? key,
      required _i67.ExaminationPreventionStatus examinationRecord})
      : super(CalendarPermissionInfoRoute.name,
            path: 'calendar/permission',
            args: CalendarPermissionInfoRouteArgs(
                key: key, examinationRecord: examinationRecord));

  static const String name = 'CalendarPermissionInfoRoute';
}

class CalendarPermissionInfoRouteArgs {
  const CalendarPermissionInfoRouteArgs(
      {this.key, required this.examinationRecord});

  final _i63.Key? key;

  final _i67.ExaminationPreventionStatus examinationRecord;

  @override
  String toString() {
    return 'CalendarPermissionInfoRouteArgs{key: $key, examinationRecord: $examinationRecord}';
  }
}

/// generated route for
/// [_i40.CalendarListScreen]
class CalendarListRoute extends _i16.PageRouteInfo<CalendarListRouteArgs> {
  CalendarListRoute(
      {_i63.Key? key,
      required _i67.ExaminationPreventionStatus examinationRecord})
      : super(CalendarListRoute.name,
            path: 'calendar/list',
            args: CalendarListRouteArgs(
                key: key, examinationRecord: examinationRecord));

  static const String name = 'CalendarListRoute';
}

class CalendarListRouteArgs {
  const CalendarListRouteArgs({this.key, required this.examinationRecord});

  final _i63.Key? key;

  final _i67.ExaminationPreventionStatus examinationRecord;

  @override
  String toString() {
    return 'CalendarListRouteArgs{key: $key, examinationRecord: $examinationRecord}';
  }
}

/// generated route for
/// [_i41.ChangeLastVisitScreen]
class ChangeLastVisitRoute
    extends _i16.PageRouteInfo<ChangeLastVisitRouteArgs> {
  ChangeLastVisitRoute(
      {_i63.Key? key,
      required DateTime originalDate,
      required String title,
      required _i67.ExaminationType examinationType,
      required String? uuid,
      required _i69.ExaminationCategory status})
      : super(ChangeLastVisitRoute.name,
            path: 'checkup/last-visit-update',
            args: ChangeLastVisitRouteArgs(
                key: key,
                originalDate: originalDate,
                title: title,
                examinationType: examinationType,
                uuid: uuid,
                status: status));

  static const String name = 'ChangeLastVisitRoute';
}

class ChangeLastVisitRouteArgs {
  const ChangeLastVisitRouteArgs(
      {this.key,
      required this.originalDate,
      required this.title,
      required this.examinationType,
      required this.uuid,
      required this.status});

  final _i63.Key? key;

  final DateTime originalDate;

  final String title;

  final _i67.ExaminationType examinationType;

  final String? uuid;

  final _i69.ExaminationCategory status;

  @override
  String toString() {
    return 'ChangeLastVisitRouteArgs{key: $key, originalDate: $originalDate, title: $title, examinationType: $examinationType, uuid: $uuid, status: $status}';
  }
}

/// generated route for
/// [_i42.EditNicknameScreen]
class EditNicknameRoute extends _i16.PageRouteInfo<EditNicknameRouteArgs> {
  EditNicknameRoute({_i63.Key? key, required _i70.User? user})
      : super(EditNicknameRoute.name,
            path: 'settings/update-profile/nickname',
            args: EditNicknameRouteArgs(key: key, user: user));

  static const String name = 'EditNicknameRoute';
}

class EditNicknameRouteArgs {
  const EditNicknameRouteArgs({this.key, required this.user});

  final _i63.Key? key;

  final _i70.User? user;

  @override
  String toString() {
    return 'EditNicknameRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i43.EditEmailScreen]
class EditEmailRoute extends _i16.PageRouteInfo<EditEmailRouteArgs> {
  EditEmailRoute({_i63.Key? key, required _i70.User? user})
      : super(EditEmailRoute.name,
            path: 'settings/update-profile/email',
            args: EditEmailRouteArgs(key: key, user: user));

  static const String name = 'EditEmailRoute';
}

class EditEmailRouteArgs {
  const EditEmailRouteArgs({this.key, required this.user});

  final _i63.Key? key;

  final _i70.User? user;

  @override
  String toString() {
    return 'EditEmailRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i44.EditPhotoScreen]
class EditPhotoRoute extends _i16.PageRouteInfo<EditPhotoRouteArgs> {
  EditPhotoRoute(
      {_i63.Key? key,
      _i71.Uint8List? imageBytes,
      required dynamic Function(_i72.SettingsPage) changePage})
      : super(EditPhotoRoute.name,
            path: 'settings/update-profile/photo',
            args: EditPhotoRouteArgs(
                key: key, imageBytes: imageBytes, changePage: changePage));

  static const String name = 'EditPhotoRoute';
}

class EditPhotoRouteArgs {
  const EditPhotoRouteArgs(
      {this.key, this.imageBytes, required this.changePage});

  final _i63.Key? key;

  final _i71.Uint8List? imageBytes;

  final dynamic Function(_i72.SettingsPage) changePage;

  @override
  String toString() {
    return 'EditPhotoRouteArgs{key: $key, imageBytes: $imageBytes, changePage: $changePage}';
  }
}

/// generated route for
/// [_i45.DeleteAccountScreen]
class DeleteAccountRoute extends _i16.PageRouteInfo<void> {
  const DeleteAccountRoute()
      : super(DeleteAccountRoute.name, path: 'settings/update-profile/delete');

  static const String name = 'DeleteAccountRoute';
}

/// generated route for
/// [_i46.AfterDeletionScreen]
class AfterDeletionRoute extends _i16.PageRouteInfo<AfterDeletionRouteArgs> {
  AfterDeletionRoute({_i63.Key? key, required _i67.Sex sex})
      : super(AfterDeletionRoute.name,
            path: 'settings/update-profile/delete/after-deletion',
            args: AfterDeletionRouteArgs(key: key, sex: sex));

  static const String name = 'AfterDeletionRoute';
}

class AfterDeletionRouteArgs {
  const AfterDeletionRouteArgs({this.key, required this.sex});

  final _i63.Key? key;

  final _i67.Sex sex;

  @override
  String toString() {
    return 'AfterDeletionRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i47.CameraPhotoTakenScreen]
class CameraPhotoTakenRoute
    extends _i16.PageRouteInfo<CameraPhotoTakenRouteArgs> {
  CameraPhotoTakenRoute({_i63.Key? key, required _i71.Uint8List imageBytes})
      : super(CameraPhotoTakenRoute.name,
            path: 'settings/update-profile/photo/camera-taken',
            args: CameraPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'CameraPhotoTakenRoute';
}

class CameraPhotoTakenRouteArgs {
  const CameraPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i63.Key? key;

  final _i71.Uint8List imageBytes;

  @override
  String toString() {
    return 'CameraPhotoTakenRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i48.GalleryPhotoTakenScreen]
class GalleryPhotoTakenRoute
    extends _i16.PageRouteInfo<GalleryPhotoTakenRouteArgs> {
  GalleryPhotoTakenRoute({_i63.Key? key, required _i71.Uint8List imageBytes})
      : super(GalleryPhotoTakenRoute.name,
            path: 'settings/update-profile/photo/gallery-taken',
            args: GalleryPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'GalleryPhotoTakenRoute';
}

class GalleryPhotoTakenRouteArgs {
  const GalleryPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i63.Key? key;

  final _i71.Uint8List imageBytes;

  @override
  String toString() {
    return 'GalleryPhotoTakenRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i49.PhotoCroppedResultScreen]
class PhotoCroppedResultRoute
    extends _i16.PageRouteInfo<PhotoCroppedResultRouteArgs> {
  PhotoCroppedResultRoute({_i63.Key? key, required _i71.Uint8List imageBytes})
      : super(PhotoCroppedResultRoute.name,
            path: 'settings/update-profile/photo/photo-cropped-result',
            args:
                PhotoCroppedResultRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'PhotoCroppedResultRoute';
}

class PhotoCroppedResultRouteArgs {
  const PhotoCroppedResultRouteArgs({this.key, required this.imageBytes});

  final _i63.Key? key;

  final _i71.Uint8List imageBytes;

  @override
  String toString() {
    return 'PhotoCroppedResultRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i50.SelfExaminationDetailScreen]
class SelfExaminationDetailRoute
    extends _i16.PageRouteInfo<SelfExaminationDetailRouteArgs> {
  SelfExaminationDetailRoute(
      {_i63.Key? key,
      required _i67.Sex sex,
      required _i67.SelfExaminationPreventionStatus selfExamination})
      : super(SelfExaminationDetailRoute.name,
            path: 'self-examination/detail',
            args: SelfExaminationDetailRouteArgs(
                key: key, sex: sex, selfExamination: selfExamination));

  static const String name = 'SelfExaminationDetailRoute';
}

class SelfExaminationDetailRouteArgs {
  const SelfExaminationDetailRouteArgs(
      {this.key, required this.sex, required this.selfExamination});

  final _i63.Key? key;

  final _i67.Sex sex;

  final _i67.SelfExaminationPreventionStatus selfExamination;

  @override
  String toString() {
    return 'SelfExaminationDetailRouteArgs{key: $key, sex: $sex, selfExamination: $selfExamination}';
  }
}

/// generated route for
/// [_i51.EducationalVideoScreen]
class EducationalVideoRoute
    extends _i16.PageRouteInfo<EducationalVideoRouteArgs> {
  EducationalVideoRoute(
      {_i63.Key? key,
      required _i67.Sex sex,
      required _i67.SelfExaminationPreventionStatus selfExamination})
      : super(EducationalVideoRoute.name,
            path: 'self-examination/detail/educational-video',
            args: EducationalVideoRouteArgs(
                key: key, sex: sex, selfExamination: selfExamination));

  static const String name = 'EducationalVideoRoute';
}

class EducationalVideoRouteArgs {
  const EducationalVideoRouteArgs(
      {this.key, required this.sex, required this.selfExamination});

  final _i63.Key? key;

  final _i67.Sex sex;

  final _i67.SelfExaminationPreventionStatus selfExamination;

  @override
  String toString() {
    return 'EducationalVideoRouteArgs{key: $key, sex: $sex, selfExamination: $selfExamination}';
  }
}

/// generated route for
/// [_i52.HasFindingScreen]
class HasFindingRoute extends _i16.PageRouteInfo<HasFindingRouteArgs> {
  HasFindingRoute({_i63.Key? key, required _i67.Sex sex})
      : super(HasFindingRoute.name,
            path: 'self-examination/detail/has-finding',
            args: HasFindingRouteArgs(key: key, sex: sex));

  static const String name = 'HasFindingRoute';
}

class HasFindingRouteArgs {
  const HasFindingRouteArgs({this.key, required this.sex});

  final _i63.Key? key;

  final _i67.Sex sex;

  @override
  String toString() {
    return 'HasFindingRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i53.NoFindingScreen]
class NoFindingRoute extends _i16.PageRouteInfo<NoFindingRouteArgs> {
  NoFindingRoute(
      {_i63.Key? key,
      required int points,
      required _i73.BuiltList<_i67.SelfExaminationStatus> history,
      _i67.BadgeType? badgeType})
      : super(NoFindingRoute.name,
            path: 'self-examination/detail/no-finding',
            args: NoFindingRouteArgs(
                key: key,
                points: points,
                history: history,
                badgeType: badgeType));

  static const String name = 'NoFindingRoute';
}

class NoFindingRouteArgs {
  const NoFindingRouteArgs(
      {this.key, required this.points, required this.history, this.badgeType});

  final _i63.Key? key;

  final int points;

  final _i73.BuiltList<_i67.SelfExaminationStatus> history;

  final _i67.BadgeType? badgeType;

  @override
  String toString() {
    return 'NoFindingRouteArgs{key: $key, points: $points, history: $history, badgeType: $badgeType}';
  }
}

/// generated route for
/// [_i54.ProgressRewardScreen]
class ProgressRewardRoute extends _i16.PageRouteInfo<void> {
  const ProgressRewardRoute()
      : super(ProgressRewardRoute.name,
            path: 'self-examination/detail/progress-reward');

  static const String name = 'ProgressRewardRoute';
}

/// generated route for
/// [_i55.ResultFromDoctorScreen]
class ResultFromDoctorRoute
    extends _i16.PageRouteInfo<ResultFromDoctorRouteArgs> {
  ResultFromDoctorRoute(
      {_i63.Key? key,
      required _i67.Sex sex,
      required _i67.SelfExaminationPreventionStatus selfExamination})
      : super(ResultFromDoctorRoute.name,
            path: 'self-examination/detail/reusult-from-doctor',
            args: ResultFromDoctorRouteArgs(
                key: key, sex: sex, selfExamination: selfExamination));

  static const String name = 'ResultFromDoctorRoute';
}

class ResultFromDoctorRouteArgs {
  const ResultFromDoctorRouteArgs(
      {this.key, required this.sex, required this.selfExamination});

  final _i63.Key? key;

  final _i67.Sex sex;

  final _i67.SelfExaminationPreventionStatus selfExamination;

  @override
  String toString() {
    return 'ResultFromDoctorRouteArgs{key: $key, sex: $sex, selfExamination: $selfExamination}';
  }
}

/// generated route for
/// [_i56.CustomExamFormScreen]
class CustomExamFormRoute extends _i16.PageRouteInfo<void> {
  const CustomExamFormRoute()
      : super(CustomExamFormRoute.name, path: 'custom-exam-form');

  static const String name = 'CustomExamFormRoute';
}

/// generated route for
/// [_i57.ChooseCustomExaminationTypeScreen]
class ChooseCustomExaminationTypeRoute
    extends _i16.PageRouteInfo<ChooseCustomExaminationTypeRouteArgs> {
  ChooseCustomExaminationTypeRoute(
      {_i67.ExaminationActionType? actionType,
      required dynamic Function(_i67.ExaminationActionType?) onActionTypeSet,
      _i63.Key? key})
      : super(ChooseCustomExaminationTypeRoute.name,
            path: 'custom-exam-form-choose-examination',
            args: ChooseCustomExaminationTypeRouteArgs(
                actionType: actionType,
                onActionTypeSet: onActionTypeSet,
                key: key));

  static const String name = 'ChooseCustomExaminationTypeRoute';
}

class ChooseCustomExaminationTypeRouteArgs {
  const ChooseCustomExaminationTypeRouteArgs(
      {this.actionType, required this.onActionTypeSet, this.key});

  final _i67.ExaminationActionType? actionType;

  final dynamic Function(_i67.ExaminationActionType?) onActionTypeSet;

  final _i63.Key? key;

  @override
  String toString() {
    return 'ChooseCustomExaminationTypeRouteArgs{actionType: $actionType, onActionTypeSet: $onActionTypeSet, key: $key}';
  }
}

/// generated route for
/// [_i58.ChooseSpecialistScreen]
class ChooseSpecialistRoute
    extends _i16.PageRouteInfo<ChooseSpecialistRouteArgs> {
  ChooseSpecialistRoute(
      {_i67.ExaminationType? specialist,
      required dynamic Function(_i67.ExaminationType?) onProviderSet,
      _i63.Key? key})
      : super(ChooseSpecialistRoute.name,
            path: 'custom-exam-form-choose-provider',
            args: ChooseSpecialistRouteArgs(
                specialist: specialist,
                onProviderSet: onProviderSet,
                key: key));

  static const String name = 'ChooseSpecialistRoute';
}

class ChooseSpecialistRouteArgs {
  const ChooseSpecialistRouteArgs(
      {this.specialist, required this.onProviderSet, this.key});

  final _i67.ExaminationType? specialist;

  final dynamic Function(_i67.ExaminationType?) onProviderSet;

  final _i63.Key? key;

  @override
  String toString() {
    return 'ChooseSpecialistRouteArgs{specialist: $specialist, onProviderSet: $onProviderSet, key: $key}';
  }
}

/// generated route for
/// [_i59.ChooseExamPeriodDateScreen]
class ChooseExamPeriodDateRoute
    extends _i16.PageRouteInfo<ChooseExamPeriodDateRouteArgs> {
  ChooseExamPeriodDateRoute(
      {DateTime? dateTime,
      required dynamic Function(DateTime?) onValueChange,
      required String label,
      required bool pickTime,
      bool? showLastExamDate,
      bool? isLastExamChoose = false,
      _i63.Key? key})
      : super(ChooseExamPeriodDateRoute.name,
            path: 'custom-exam-form-choose-period-date',
            args: ChooseExamPeriodDateRouteArgs(
                dateTime: dateTime,
                onValueChange: onValueChange,
                label: label,
                pickTime: pickTime,
                showLastExamDate: showLastExamDate,
                isLastExamChoose: isLastExamChoose,
                key: key));

  static const String name = 'ChooseExamPeriodDateRoute';
}

class ChooseExamPeriodDateRouteArgs {
  const ChooseExamPeriodDateRouteArgs(
      {this.dateTime,
      required this.onValueChange,
      required this.label,
      required this.pickTime,
      this.showLastExamDate,
      this.isLastExamChoose = false,
      this.key});

  final DateTime? dateTime;

  final dynamic Function(DateTime?) onValueChange;

  final String label;

  final bool pickTime;

  final bool? showLastExamDate;

  final bool? isLastExamChoose;

  final _i63.Key? key;

  @override
  String toString() {
    return 'ChooseExamPeriodDateRouteArgs{dateTime: $dateTime, onValueChange: $onValueChange, label: $label, pickTime: $pickTime, showLastExamDate: $showLastExamDate, isLastExamChoose: $isLastExamChoose, key: $key}';
  }
}

/// generated route for
/// [_i60.ChooseExamPeriodTimeScreen]
class ChooseExamPeriodTimeRoute
    extends _i16.PageRouteInfo<ChooseExamPeriodTimeRouteArgs> {
  ChooseExamPeriodTimeRoute(
      {_i63.Key? key,
      DateTime? dateTime,
      required dynamic Function(DateTime?) onTimeSet})
      : super(ChooseExamPeriodTimeRoute.name,
            path: 'custom-exam-form-choose-period-time',
            args: ChooseExamPeriodTimeRouteArgs(
                key: key, dateTime: dateTime, onTimeSet: onTimeSet));

  static const String name = 'ChooseExamPeriodTimeRoute';
}

class ChooseExamPeriodTimeRouteArgs {
  const ChooseExamPeriodTimeRouteArgs(
      {this.key, this.dateTime, required this.onTimeSet});

  final _i63.Key? key;

  final DateTime? dateTime;

  final dynamic Function(DateTime?) onTimeSet;

  @override
  String toString() {
    return 'ChooseExamPeriodTimeRouteArgs{key: $key, dateTime: $dateTime, onTimeSet: $onTimeSet}';
  }
}

/// generated route for
/// [_i61.ChooseFrequencyOfExamScreen]
class ChooseFrequencyOfExamRoute
    extends _i16.PageRouteInfo<ChooseFrequencyOfExamRouteArgs> {
  ChooseFrequencyOfExamRoute(
      {_i63.Key? key,
      String? value,
      required dynamic Function(String) valueChanged,
      bool isDefaultExam = false,
      _i67.ExaminationType? examType})
      : super(ChooseFrequencyOfExamRoute.name,
            path: 'custom-exam-form-choose-exam-frequency',
            args: ChooseFrequencyOfExamRouteArgs(
                key: key,
                value: value,
                valueChanged: valueChanged,
                isDefaultExam: isDefaultExam,
                examType: examType));

  static const String name = 'ChooseFrequencyOfExamRoute';
}

class ChooseFrequencyOfExamRouteArgs {
  const ChooseFrequencyOfExamRouteArgs(
      {this.key,
      this.value,
      required this.valueChanged,
      this.isDefaultExam = false,
      this.examType});

  final _i63.Key? key;

  final String? value;

  final dynamic Function(String) valueChanged;

  final bool isDefaultExam;

  final _i67.ExaminationType? examType;

  @override
  String toString() {
    return 'ChooseFrequencyOfExamRouteArgs{key: $key, value: $value, valueChanged: $valueChanged, isDefaultExam: $isDefaultExam, examType: $examType}';
  }
}

/// generated route for
/// [_i62.PreventionScreen]
class PreventionRoute extends _i16.PageRouteInfo<PreventionRouteArgs> {
  PreventionRoute({_i63.Key? key})
      : super(PreventionRoute.name,
            path: 'prevention', args: PreventionRouteArgs(key: key));

  static const String name = 'PreventionRoute';
}

class PreventionRouteArgs {
  const PreventionRouteArgs({this.key});

  final _i63.Key? key;

  @override
  String toString() {
    return 'PreventionRouteArgs{key: $key}';
  }
}
