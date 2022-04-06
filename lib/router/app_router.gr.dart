// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i54;
import 'package:loono_api/loono_api.dart' as _i58;
import 'package:moor/moor.dart' as _i60;

import '../helpers/examination_category.dart' as _i63;
import '../models/categorized_examination.dart' as _i62;
import '../models/search_result.dart' as _i56;
import '../models/social_login_account.dart' as _i57;
import '../services/db/database.dart' as _i59;
import '../ui/screens/about_health/about_health.dart' as _i18;
import '../ui/screens/dentist_achievement.dart' as _i31;
import '../ui/screens/find_doctor/doctor_search_detail.dart' as _i12;
import '../ui/screens/find_doctor/find_doctor.dart' as _i11;
import '../ui/screens/force_update.dart' as _i15;
import '../ui/screens/general_practicioner_achievement.dart' as _i25;
import '../ui/screens/gynecology_achievement.dart' as _i28;
import '../ui/screens/logout.dart' as _i13;
import '../ui/screens/main/main_screen.dart' as _i33;
import '../ui/screens/main/pre_auth/continue_onboarding_form.dart' as _i20;
import '../ui/screens/main/pre_auth/login.dart' as _i10;
import '../ui/screens/main/pre_auth/onboarding_form_done.dart' as _i21;
import '../ui/screens/main/pre_auth/pre_auth_main_screen.dart' as _i2;
import '../ui/screens/main/pre_auth/start_new_questionnaire.dart' as _i19;
import '../ui/screens/onboarding/allow_notifications.dart' as _i5;
import '../ui/screens/onboarding/birthdate.dart' as _i23;
import '../ui/screens/onboarding/carousel/carousel.dart' as _i3;
import '../ui/screens/onboarding/doctors/dentist.dart' as _i30;
import '../ui/screens/onboarding/doctors/dentist_date.dart' as _i32;
import '../ui/screens/onboarding/doctors/general_practicioner.dart' as _i24;
import '../ui/screens/onboarding/doctors/general_practitioner_date.dart'
    as _i26;
import '../ui/screens/onboarding/doctors/gynecology.dart' as _i27;
import '../ui/screens/onboarding/doctors/gynecology_date.dart' as _i29;
import '../ui/screens/onboarding/fallback_account/email.dart' as _i9;
import '../ui/screens/onboarding/fallback_account/nickname.dart' as _i8;
import '../ui/screens/onboarding/fill_form_later.dart' as _i6;
import '../ui/screens/onboarding/gamification_introduction.dart' as _i7;
import '../ui/screens/onboarding/gender.dart' as _i22;
import '../ui/screens/prevention/calendar/calendar_list.dart' as _i46;
import '../ui/screens/prevention/calendar/permission_info.dart' as _i45;
import '../ui/screens/prevention/examination_detail/change_last_visit_screen.dart'
    as _i47;
import '../ui/screens/prevention/examination_detail/examination_screen.dart'
    as _i42;
import '../ui/screens/prevention/questionnaire/date_picker_screen.dart' as _i44;
import '../ui/screens/prevention/self_examination/detail_screen.dart' as _i48;
import '../ui/screens/prevention/self_examination/educational_screen.dart'
    as _i49;
import '../ui/screens/prevention/self_examination/has_finding_screen.dart'
    as _i50;
import '../ui/screens/prevention/self_examination/no_finding_screen.dart'
    as _i51;
import '../ui/screens/prevention/self_examination/progress_screen.dart' as _i52;
import '../ui/screens/prevention/self_examination/result_from_doctor.dart'
    as _i53;
import '../ui/screens/settings/after_deletion.dart' as _i38;
import '../ui/screens/settings/camera_photo_taken.dart' as _i39;
import '../ui/screens/settings/delete_account.dart' as _i37;
import '../ui/screens/settings/edit_email.dart' as _i35;
import '../ui/screens/settings/edit_nickname.dart' as _i34;
import '../ui/screens/settings/edit_photo.dart' as _i36;
import '../ui/screens/settings/gallery_photo_taken.dart' as _i40;
import '../ui/screens/settings/photo_cropped_result.dart' as _i41;
import '../ui/screens/settings/settings_bottom_sheet.dart' as _i61;
import '../ui/screens/welcome.dart' as _i16;
import '../ui/widgets/achievement_screen.dart' as _i43;
import 'guards/check_is_logged_in.dart' as _i55;
import 'sub_routers/app_startup_wrapper_screen.dart' as _i1;
import 'sub_routers/onboarding_wrapper_screen.dart' as _i4;
import 'sub_routers/pre_auth_prevention_wrapper_screen.dart' as _i17;

class AppRouter extends _i14.RootStackRouter {
  AppRouter(
      {_i54.GlobalKey<_i54.NavigatorState>? navigatorKey,
      required this.checkIsLoggedIn})
      : super(navigatorKey);

  final _i55.CheckIsLoggedIn checkIsLoggedIn;

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    AppStartUpWrapperRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i1.AppStartUpWrapperScreen());
    },
    PreAuthMainRoute.name: (routeData) {
      final args = routeData.argsAs<PreAuthMainRouteArgs>(
          orElse: () => const PreAuthMainRouteArgs());
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i2.PreAuthMainScreen(
              key: args.key,
              overridenPreventionRoute: args.overridenPreventionRoute));
    },
    IntroCarouselRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i3.IntroCarouselScreen());
    },
    OnboardingWrapperRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i4.OnboardingWrapperScreen());
    },
    AllowNotificationsRoute.name: (routeData) {
      final args = routeData.argsAs<AllowNotificationsRouteArgs>(
          orElse: () => const AllowNotificationsRouteArgs());
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i5.AllowNotificationsScreen(
              key: args.key,
              onSkipTap: args.onSkipTap,
              onContinueTap: args.onContinueTap),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    FillOnboardingFormLaterRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: const _i6.FillOnboardingFormLaterScreen());
    },
    GamificationIntroductionRoute.name: (routeData) {
      final args = routeData.argsAs<GamificationIntroductionRouteArgs>(
          orElse: () => const GamificationIntroductionRouteArgs());
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i7.GamificationIntroductionScreen(key: args.key));
    },
    NicknameRoute.name: (routeData) {
      final args = routeData.argsAs<NicknameRouteArgs>();
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i8.NicknameScreen(
              key: args.key, socialLoginAccount: args.socialLoginAccount));
    },
    EmailRoute.name: (routeData) {
      final args = routeData.argsAs<EmailRouteArgs>();
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i9.EmailScreen(
              key: args.key, socialLoginAccount: args.socialLoginAccount));
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: _i10.LoginScreen(key: args.key));
    },
    FindDoctorRoute.name: (routeData) {
      final args = routeData.argsAs<FindDoctorRouteArgs>(
          orElse: () => const FindDoctorRouteArgs());
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i11.FindDoctorScreen(
              key: args.key, cancelRouteName: args.cancelRouteName));
    },
    DoctorSearchDetailRoute.name: (routeData) {
      return _i14.CustomPage<_i56.SearchResult>(
          routeData: routeData,
          child: const _i12.DoctorSearchDetailScreen(),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    LogoutRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i13.LogoutScreen());
    },
    MainScreenRouter.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i14.EmptyRouterScreen());
    },
    ForceUpdateRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i15.ForceUpdateScreen());
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: _i16.WelcomeScreen(key: args.key));
    },
    PreAuthPreventionWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<PreAuthPreventionWrapperRouteArgs>(
          orElse: () => const PreAuthPreventionWrapperRouteArgs());
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i17.PreAuthPreventionWrapperScreen(
              key: args.key, forceRoute: args.forceRoute));
    },
    AboutHealthRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData, child: const _i18.AboutHealthScreen());
    },
    StartNewQuestionnaireRoute.name: (routeData) {
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: const _i19.StartNewQuestionnaireScreen());
    },
    ContinueOnboardingFormRoute.name: (routeData) {
      final args = routeData.argsAs<ContinueOnboardingFormRouteArgs>(
          orElse: () => const ContinueOnboardingFormRouteArgs());
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i20.ContinueOnboardingFormScreen(key: args.key));
    },
    OnboardingFormDoneRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingFormDoneRouteArgs>(
          orElse: () => const OnboardingFormDoneRouteArgs());
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i21.OnboardingFormDoneScreen(key: args.key));
    },
    OnboardingGenderRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i22.OnboardingGenderScreen(),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnBoardingBirthdateRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingBirthdateRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i23.OnBoardingBirthdateScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGeneralPracticionerRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGeneralPracticionerRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i24.OnboardingGeneralPracticionerScreen(
              key: args.key, sex: args.sex),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPracticionerAchievementRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i25.GeneralPracticionerAchievementScreen(),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPractitionerDateRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i26.GeneralPractitionerDateScreen(),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGynecologyRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGynecologyRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i27.OnboardingGynecologyScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyAchievementRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i28.GynecologyAchievementScreen(),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyDateRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i29.GynecologyDateScreen(),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingDentistRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingDentistRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i30.OnboardingDentistScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistAchievementRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i31.DentistAchievementScreen(),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistDateRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i32.DentistDateScreen(),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    MainRoute.name: (routeData) {
      final args =
          routeData.argsAs<MainRouteArgs>(orElse: () => const MainRouteArgs());
      return _i14.MaterialPageX<void>(
          routeData: routeData,
          child: _i33.MainScreen(
              key: args.key, selectedIndex: args.selectedIndex));
    },
    EditNicknameRoute.name: (routeData) {
      final args = routeData.argsAs<EditNicknameRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i34.EditNicknameScreen(key: args.key, user: args.user),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditEmailRoute.name: (routeData) {
      final args = routeData.argsAs<EditEmailRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i35.EditEmailScreen(key: args.key, user: args.user),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditPhotoRoute.name: (routeData) {
      final args = routeData.argsAs<EditPhotoRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i36.EditPhotoScreen(
              key: args.key,
              imageBytes: args.imageBytes,
              changePage: args.changePage),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DeleteAccountRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i37.DeleteAccountScreen(),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AfterDeletionRoute.name: (routeData) {
      final args = routeData.argsAs<AfterDeletionRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i38.AfterDeletionScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CameraPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<CameraPhotoTakenRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i39.CameraPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GalleryPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<GalleryPhotoTakenRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i40.GalleryPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    PhotoCroppedResultRoute.name: (routeData) {
      final args = routeData.argsAs<PhotoCroppedResultRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i41.PhotoCroppedResultScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ExaminationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ExaminationDetailRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i42.ExaminationDetailScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination,
              initialMessage: args.initialMessage),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AchievementRoute.name: (routeData) {
      final args = routeData.argsAs<AchievementRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i43.AchievementScreen(
              key: args.key,
              header: args.header,
              textLines: args.textLines,
              numberOfPoints: args.numberOfPoints,
              itemPath: args.itemPath,
              onButtonTap: args.onButtonTap),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DatePickerRoute.name: (routeData) {
      final args = routeData.argsAs<DatePickerRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i44.DatePickerScreen(
              key: args.key,
              assetPath: args.assetPath,
              title: args.title,
              onContinueButtonPress: args.onContinueButtonPress,
              onSkipButtonPress: args.onSkipButtonPress),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CalendarPermissionInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarPermissionInfoRouteArgs>();
      return _i14.CustomPage<bool>(
          routeData: routeData,
          child: _i45.CalendarPermissionInfoScreen(
              key: args.key, examinationRecord: args.examinationRecord),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CalendarListRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarListRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i46.CalendarListScreen(
              key: args.key, examinationRecord: args.examinationRecord),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ChangeLastVisitRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeLastVisitRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i47.ChangeLastVisitScreen(
              key: args.key,
              originalDate: args.originalDate,
              title: args.title,
              examinationType: args.examinationType,
              uuid: args.uuid,
              status: args.status),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    SelfExaminationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SelfExaminationDetailRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i48.SelfExaminationDetailScreen(
              key: args.key,
              sex: args.sex,
              selfExamination: args.selfExamination),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EducationalVideoRoute.name: (routeData) {
      final args = routeData.argsAs<EducationalVideoRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i49.EducationalVideoScreen(
              key: args.key,
              sex: args.sex,
              selfExamination: args.selfExamination),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HasFindingRoute.name: (routeData) {
      final args = routeData.argsAs<HasFindingRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i50.HasFindingScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    NoFindingRoute.name: (routeData) {
      final args = routeData.argsAs<NoFindingRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i51.NoFindingScreen(key: args.key, points: args.points),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ProgressRewardRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i52.ProgressRewardScreen(),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ResultFromDoctorRoute.name: (routeData) {
      final args = routeData.argsAs<ResultFromDoctorRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i53.ResultFromDoctorScreen(
              key: args.key,
              sex: args.sex,
              selfExamination: args.selfExamination),
          transitionsBuilder: _i14.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig('/#redirect',
            path: '/', redirectTo: 'main', fullMatch: true),
        _i14.RouteConfig(AppStartUpWrapperRoute.name,
            path: 'app-start-up',
            children: [
              _i14.RouteConfig(WelcomeRoute.name,
                  path: 'welcome', parent: AppStartUpWrapperRoute.name),
              _i14.RouteConfig(PreAuthMainRoute.name,
                  path: 'pre-auth-main',
                  parent: AppStartUpWrapperRoute.name,
                  children: [
                    _i14.RouteConfig(PreAuthPreventionWrapperRoute.name,
                        path: 'pre-auth-prevention',
                        parent: PreAuthMainRoute.name,
                        children: [
                          _i14.RouteConfig(LoginRoute.name,
                              path: 'login',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i14.RouteConfig(StartNewQuestionnaireRoute.name,
                              path: 'start-new-questionnaire',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i14.RouteConfig(ContinueOnboardingFormRoute.name,
                              path: 'continue-onboarding-form',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i14.RouteConfig(OnboardingFormDoneRoute.name,
                              path: 'onboarding-form-done',
                              parent: PreAuthPreventionWrapperRoute.name)
                        ]),
                    _i14.RouteConfig(FindDoctorRoute.name,
                        path: 'find-doctor', parent: PreAuthMainRoute.name),
                    _i14.RouteConfig(DoctorSearchDetailRoute.name,
                        path: 'find-doctor/search/detail',
                        parent: PreAuthMainRoute.name),
                    _i14.RouteConfig(AboutHealthRoute.name,
                        path: 'about-health', parent: PreAuthMainRoute.name)
                  ])
            ]),
        _i14.RouteConfig(PreAuthMainRoute.name,
            path: 'pre-auth-main',
            children: [
              _i14.RouteConfig(PreAuthPreventionWrapperRoute.name,
                  path: 'pre-auth-prevention',
                  parent: PreAuthMainRoute.name,
                  children: [
                    _i14.RouteConfig(LoginRoute.name,
                        path: 'login',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i14.RouteConfig(StartNewQuestionnaireRoute.name,
                        path: 'start-new-questionnaire',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i14.RouteConfig(ContinueOnboardingFormRoute.name,
                        path: 'continue-onboarding-form',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i14.RouteConfig(OnboardingFormDoneRoute.name,
                        path: 'onboarding-form-done',
                        parent: PreAuthPreventionWrapperRoute.name)
                  ]),
              _i14.RouteConfig(FindDoctorRoute.name,
                  path: 'find-doctor', parent: PreAuthMainRoute.name),
              _i14.RouteConfig(DoctorSearchDetailRoute.name,
                  path: 'find-doctor/search/detail',
                  parent: PreAuthMainRoute.name),
              _i14.RouteConfig(AboutHealthRoute.name,
                  path: 'about-health', parent: PreAuthMainRoute.name)
            ]),
        _i14.RouteConfig(IntroCarouselRoute.name, path: 'intro-carousel'),
        _i14.RouteConfig(OnboardingWrapperRoute.name,
            path: 'onboarding',
            children: [
              _i14.RouteConfig(OnboardingGenderRoute.name,
                  path: 'gender', parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(OnBoardingBirthdateRoute.name,
                  path: 'birthdate', parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(OnboardingGeneralPracticionerRoute.name,
                  path: 'doctor/general-practicioner',
                  parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(GeneralPracticionerAchievementRoute.name,
                  path: 'general-practicioner-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(GeneralPractitionerDateRoute.name,
                  path: 'doctor/general-practitioner-date',
                  parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(AllowNotificationsRoute.name,
                  path: 'allow-notifications',
                  parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(OnboardingGynecologyRoute.name,
                  path: 'doctor/gynecology',
                  parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(GynecologyAchievementRoute.name,
                  path: 'gynecology-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(GynecologyDateRoute.name,
                  path: 'doctor/gynecology-date',
                  parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(OnboardingDentistRoute.name,
                  path: 'doctor/dentist', parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(DentistAchievementRoute.name,
                  path: 'dentist-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i14.RouteConfig(DentistDateRoute.name,
                  path: 'doctor/dentist-date',
                  parent: OnboardingWrapperRoute.name)
            ]),
        _i14.RouteConfig(AllowNotificationsRoute.name,
            path: 'allow-notifications'),
        _i14.RouteConfig(FillOnboardingFormLaterRoute.name,
            path: 'fill-form-later'),
        _i14.RouteConfig(GamificationIntroductionRoute.name,
            path: 'gamification-introduction'),
        _i14.RouteConfig(NicknameRoute.name, path: 'fallback-account/name'),
        _i14.RouteConfig(EmailRoute.name, path: 'fallback-account/email'),
        _i14.RouteConfig(LoginRoute.name, path: 'login'),
        _i14.RouteConfig(FindDoctorRoute.name, path: 'find-doctor'),
        _i14.RouteConfig(DoctorSearchDetailRoute.name,
            path: 'find-doctor/search/detail'),
        _i14.RouteConfig(LogoutRoute.name, path: 'logout'),
        _i14.RouteConfig(MainScreenRouter.name, path: 'main', guards: [
          checkIsLoggedIn
        ], children: [
          _i14.RouteConfig(MainRoute.name,
              path: '', parent: MainScreenRouter.name),
          _i14.RouteConfig(EditNicknameRoute.name,
              path: 'settings/update-profile/nickname',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(EditEmailRoute.name,
              path: 'settings/update-profile/email',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(EditPhotoRoute.name,
              path: 'settings/update-profile/photo',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(DeleteAccountRoute.name,
              path: 'settings/update-profile/delete',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(AfterDeletionRoute.name,
              path: 'settings/update-profile/delete/after-deletion',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(CameraPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/camera-taken',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(GalleryPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/gallery-taken',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(PhotoCroppedResultRoute.name,
              path: 'settings/update-profile/photo/photo-cropped-result',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(ExaminationDetailRoute.name,
              path: 'prevention-detail', parent: MainScreenRouter.name),
          _i14.RouteConfig(AchievementRoute.name,
              path: 'questionnaire/reward', parent: MainScreenRouter.name),
          _i14.RouteConfig(DatePickerRoute.name,
              path: 'questionnaire/date-picker', parent: MainScreenRouter.name),
          _i14.RouteConfig(CalendarPermissionInfoRoute.name,
              path: 'calendar/permission', parent: MainScreenRouter.name),
          _i14.RouteConfig(CalendarListRoute.name,
              path: 'calendar/list', parent: MainScreenRouter.name),
          _i14.RouteConfig(ChangeLastVisitRoute.name,
              path: 'checkup/last-visit-update', parent: MainScreenRouter.name),
          _i14.RouteConfig(SelfExaminationDetailRoute.name,
              path: 'self-examination/detail', parent: MainScreenRouter.name),
          _i14.RouteConfig(EducationalVideoRoute.name,
              path: 'self-examination/detail/educational-video',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(HasFindingRoute.name,
              path: 'self-examination/detail/has-finding',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(NoFindingRoute.name,
              path: 'self-examination/detail/no-finding',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(ProgressRewardRoute.name,
              path: 'self-examination/detail/progress-reward',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(ResultFromDoctorRoute.name,
              path: 'self-examination/detail/reusult-from-doctor',
              parent: MainScreenRouter.name),
          _i14.RouteConfig(FindDoctorRoute.name,
              path: 'find-doctor', parent: MainScreenRouter.name),
          _i14.RouteConfig(DoctorSearchDetailRoute.name,
              path: 'find-doctor/search/detail', parent: MainScreenRouter.name),
          _i14.RouteConfig(AboutHealthRoute.name,
              path: 'about-health', parent: MainScreenRouter.name)
        ]),
        _i14.RouteConfig(ForceUpdateRoute.name, path: 'force-update')
      ];
}

/// generated route for
/// [_i1.AppStartUpWrapperScreen]
class AppStartUpWrapperRoute extends _i14.PageRouteInfo<void> {
  const AppStartUpWrapperRoute({List<_i14.PageRouteInfo>? children})
      : super(AppStartUpWrapperRoute.name,
            path: 'app-start-up', initialChildren: children);

  static const String name = 'AppStartUpWrapperRoute';
}

/// generated route for
/// [_i2.PreAuthMainScreen]
class PreAuthMainRoute extends _i14.PageRouteInfo<PreAuthMainRouteArgs> {
  PreAuthMainRoute(
      {_i54.Key? key,
      _i14.PageRouteInfo<dynamic>? overridenPreventionRoute,
      List<_i14.PageRouteInfo>? children})
      : super(PreAuthMainRoute.name,
            path: 'pre-auth-main',
            args: PreAuthMainRouteArgs(
                key: key, overridenPreventionRoute: overridenPreventionRoute),
            initialChildren: children);

  static const String name = 'PreAuthMainRoute';
}

class PreAuthMainRouteArgs {
  const PreAuthMainRouteArgs({this.key, this.overridenPreventionRoute});

  final _i54.Key? key;

  final _i14.PageRouteInfo<dynamic>? overridenPreventionRoute;

  @override
  String toString() {
    return 'PreAuthMainRouteArgs{key: $key, overridenPreventionRoute: $overridenPreventionRoute}';
  }
}

/// generated route for
/// [_i3.IntroCarouselScreen]
class IntroCarouselRoute extends _i14.PageRouteInfo<void> {
  const IntroCarouselRoute()
      : super(IntroCarouselRoute.name, path: 'intro-carousel');

  static const String name = 'IntroCarouselRoute';
}

/// generated route for
/// [_i4.OnboardingWrapperScreen]
class OnboardingWrapperRoute extends _i14.PageRouteInfo<void> {
  const OnboardingWrapperRoute({List<_i14.PageRouteInfo>? children})
      : super(OnboardingWrapperRoute.name,
            path: 'onboarding', initialChildren: children);

  static const String name = 'OnboardingWrapperRoute';
}

/// generated route for
/// [_i5.AllowNotificationsScreen]
class AllowNotificationsRoute
    extends _i14.PageRouteInfo<AllowNotificationsRouteArgs> {
  AllowNotificationsRoute(
      {_i54.Key? key,
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

  final _i54.Key? key;

  final void Function()? onSkipTap;

  final void Function()? onContinueTap;

  @override
  String toString() {
    return 'AllowNotificationsRouteArgs{key: $key, onSkipTap: $onSkipTap, onContinueTap: $onContinueTap}';
  }
}

/// generated route for
/// [_i6.FillOnboardingFormLaterScreen]
class FillOnboardingFormLaterRoute extends _i14.PageRouteInfo<void> {
  const FillOnboardingFormLaterRoute()
      : super(FillOnboardingFormLaterRoute.name, path: 'fill-form-later');

  static const String name = 'FillOnboardingFormLaterRoute';
}

/// generated route for
/// [_i7.GamificationIntroductionScreen]
class GamificationIntroductionRoute
    extends _i14.PageRouteInfo<GamificationIntroductionRouteArgs> {
  GamificationIntroductionRoute({_i54.Key? key})
      : super(GamificationIntroductionRoute.name,
            path: 'gamification-introduction',
            args: GamificationIntroductionRouteArgs(key: key));

  static const String name = 'GamificationIntroductionRoute';
}

class GamificationIntroductionRouteArgs {
  const GamificationIntroductionRouteArgs({this.key});

  final _i54.Key? key;

  @override
  String toString() {
    return 'GamificationIntroductionRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.NicknameScreen]
class NicknameRoute extends _i14.PageRouteInfo<NicknameRouteArgs> {
  NicknameRoute(
      {_i54.Key? key, required _i57.SocialLoginAccount? socialLoginAccount})
      : super(NicknameRoute.name,
            path: 'fallback-account/name',
            args: NicknameRouteArgs(
                key: key, socialLoginAccount: socialLoginAccount));

  static const String name = 'NicknameRoute';
}

class NicknameRouteArgs {
  const NicknameRouteArgs({this.key, required this.socialLoginAccount});

  final _i54.Key? key;

  final _i57.SocialLoginAccount? socialLoginAccount;

  @override
  String toString() {
    return 'NicknameRouteArgs{key: $key, socialLoginAccount: $socialLoginAccount}';
  }
}

/// generated route for
/// [_i9.EmailScreen]
class EmailRoute extends _i14.PageRouteInfo<EmailRouteArgs> {
  EmailRoute(
      {_i54.Key? key, required _i57.SocialLoginAccount? socialLoginAccount})
      : super(EmailRoute.name,
            path: 'fallback-account/email',
            args: EmailRouteArgs(
                key: key, socialLoginAccount: socialLoginAccount));

  static const String name = 'EmailRoute';
}

class EmailRouteArgs {
  const EmailRouteArgs({this.key, required this.socialLoginAccount});

  final _i54.Key? key;

  final _i57.SocialLoginAccount? socialLoginAccount;

  @override
  String toString() {
    return 'EmailRouteArgs{key: $key, socialLoginAccount: $socialLoginAccount}';
  }
}

/// generated route for
/// [_i10.LoginScreen]
class LoginRoute extends _i14.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i54.Key? key})
      : super(LoginRoute.name, path: 'login', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i54.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.FindDoctorScreen]
class FindDoctorRoute extends _i14.PageRouteInfo<FindDoctorRouteArgs> {
  FindDoctorRoute({_i54.Key? key, _i14.PageRouteInfo<dynamic>? cancelRouteName})
      : super(FindDoctorRoute.name,
            path: 'find-doctor',
            args: FindDoctorRouteArgs(
                key: key, cancelRouteName: cancelRouteName));

  static const String name = 'FindDoctorRoute';
}

class FindDoctorRouteArgs {
  const FindDoctorRouteArgs({this.key, this.cancelRouteName});

  final _i54.Key? key;

  final _i14.PageRouteInfo<dynamic>? cancelRouteName;

  @override
  String toString() {
    return 'FindDoctorRouteArgs{key: $key, cancelRouteName: $cancelRouteName}';
  }
}

/// generated route for
/// [_i12.DoctorSearchDetailScreen]
class DoctorSearchDetailRoute extends _i14.PageRouteInfo<void> {
  const DoctorSearchDetailRoute()
      : super(DoctorSearchDetailRoute.name, path: 'find-doctor/search/detail');

  static const String name = 'DoctorSearchDetailRoute';
}

/// generated route for
/// [_i13.LogoutScreen]
class LogoutRoute extends _i14.PageRouteInfo<void> {
  const LogoutRoute() : super(LogoutRoute.name, path: 'logout');

  static const String name = 'LogoutRoute';
}

/// generated route for
/// [_i14.EmptyRouterScreen]
class MainScreenRouter extends _i14.PageRouteInfo<void> {
  const MainScreenRouter({List<_i14.PageRouteInfo>? children})
      : super(MainScreenRouter.name, path: 'main', initialChildren: children);

  static const String name = 'MainScreenRouter';
}

/// generated route for
/// [_i15.ForceUpdateScreen]
class ForceUpdateRoute extends _i14.PageRouteInfo<void> {
  const ForceUpdateRoute() : super(ForceUpdateRoute.name, path: 'force-update');

  static const String name = 'ForceUpdateRoute';
}

/// generated route for
/// [_i16.WelcomeScreen]
class WelcomeRoute extends _i14.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({_i54.Key? key})
      : super(WelcomeRoute.name,
            path: 'welcome', args: WelcomeRouteArgs(key: key));

  static const String name = 'WelcomeRoute';
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i54.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.PreAuthPreventionWrapperScreen]
class PreAuthPreventionWrapperRoute
    extends _i14.PageRouteInfo<PreAuthPreventionWrapperRouteArgs> {
  PreAuthPreventionWrapperRoute(
      {_i54.Key? key,
      _i14.PageRouteInfo<dynamic>? forceRoute,
      List<_i14.PageRouteInfo>? children})
      : super(PreAuthPreventionWrapperRoute.name,
            path: 'pre-auth-prevention',
            args: PreAuthPreventionWrapperRouteArgs(
                key: key, forceRoute: forceRoute),
            initialChildren: children);

  static const String name = 'PreAuthPreventionWrapperRoute';
}

class PreAuthPreventionWrapperRouteArgs {
  const PreAuthPreventionWrapperRouteArgs({this.key, this.forceRoute});

  final _i54.Key? key;

  final _i14.PageRouteInfo<dynamic>? forceRoute;

  @override
  String toString() {
    return 'PreAuthPreventionWrapperRouteArgs{key: $key, forceRoute: $forceRoute}';
  }
}

/// generated route for
/// [_i18.AboutHealthScreen]
class AboutHealthRoute extends _i14.PageRouteInfo<void> {
  const AboutHealthRoute() : super(AboutHealthRoute.name, path: 'about-health');

  static const String name = 'AboutHealthRoute';
}

/// generated route for
/// [_i19.StartNewQuestionnaireScreen]
class StartNewQuestionnaireRoute extends _i14.PageRouteInfo<void> {
  const StartNewQuestionnaireRoute()
      : super(StartNewQuestionnaireRoute.name, path: 'start-new-questionnaire');

  static const String name = 'StartNewQuestionnaireRoute';
}

/// generated route for
/// [_i20.ContinueOnboardingFormScreen]
class ContinueOnboardingFormRoute
    extends _i14.PageRouteInfo<ContinueOnboardingFormRouteArgs> {
  ContinueOnboardingFormRoute({_i54.Key? key})
      : super(ContinueOnboardingFormRoute.name,
            path: 'continue-onboarding-form',
            args: ContinueOnboardingFormRouteArgs(key: key));

  static const String name = 'ContinueOnboardingFormRoute';
}

class ContinueOnboardingFormRouteArgs {
  const ContinueOnboardingFormRouteArgs({this.key});

  final _i54.Key? key;

  @override
  String toString() {
    return 'ContinueOnboardingFormRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i21.OnboardingFormDoneScreen]
class OnboardingFormDoneRoute
    extends _i14.PageRouteInfo<OnboardingFormDoneRouteArgs> {
  OnboardingFormDoneRoute({_i54.Key? key})
      : super(OnboardingFormDoneRoute.name,
            path: 'onboarding-form-done',
            args: OnboardingFormDoneRouteArgs(key: key));

  static const String name = 'OnboardingFormDoneRoute';
}

class OnboardingFormDoneRouteArgs {
  const OnboardingFormDoneRouteArgs({this.key});

  final _i54.Key? key;

  @override
  String toString() {
    return 'OnboardingFormDoneRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i22.OnboardingGenderScreen]
class OnboardingGenderRoute extends _i14.PageRouteInfo<void> {
  const OnboardingGenderRoute()
      : super(OnboardingGenderRoute.name, path: 'gender');

  static const String name = 'OnboardingGenderRoute';
}

/// generated route for
/// [_i23.OnBoardingBirthdateScreen]
class OnBoardingBirthdateRoute
    extends _i14.PageRouteInfo<OnBoardingBirthdateRouteArgs> {
  OnBoardingBirthdateRoute({_i54.Key? key, required _i58.Sex sex})
      : super(OnBoardingBirthdateRoute.name,
            path: 'birthdate',
            args: OnBoardingBirthdateRouteArgs(key: key, sex: sex));

  static const String name = 'OnBoardingBirthdateRoute';
}

class OnBoardingBirthdateRouteArgs {
  const OnBoardingBirthdateRouteArgs({this.key, required this.sex});

  final _i54.Key? key;

  final _i58.Sex sex;

  @override
  String toString() {
    return 'OnBoardingBirthdateRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i24.OnboardingGeneralPracticionerScreen]
class OnboardingGeneralPracticionerRoute
    extends _i14.PageRouteInfo<OnboardingGeneralPracticionerRouteArgs> {
  OnboardingGeneralPracticionerRoute({_i54.Key? key, required _i58.Sex sex})
      : super(OnboardingGeneralPracticionerRoute.name,
            path: 'doctor/general-practicioner',
            args: OnboardingGeneralPracticionerRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGeneralPracticionerRoute';
}

class OnboardingGeneralPracticionerRouteArgs {
  const OnboardingGeneralPracticionerRouteArgs({this.key, required this.sex});

  final _i54.Key? key;

  final _i58.Sex sex;

  @override
  String toString() {
    return 'OnboardingGeneralPracticionerRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i25.GeneralPracticionerAchievementScreen]
class GeneralPracticionerAchievementRoute extends _i14.PageRouteInfo<void> {
  const GeneralPracticionerAchievementRoute()
      : super(GeneralPracticionerAchievementRoute.name,
            path: 'general-practicioner-achievement');

  static const String name = 'GeneralPracticionerAchievementRoute';
}

/// generated route for
/// [_i26.GeneralPractitionerDateScreen]
class GeneralPractitionerDateRoute extends _i14.PageRouteInfo<void> {
  const GeneralPractitionerDateRoute()
      : super(GeneralPractitionerDateRoute.name,
            path: 'doctor/general-practitioner-date');

  static const String name = 'GeneralPractitionerDateRoute';
}

/// generated route for
/// [_i27.OnboardingGynecologyScreen]
class OnboardingGynecologyRoute
    extends _i14.PageRouteInfo<OnboardingGynecologyRouteArgs> {
  OnboardingGynecologyRoute({_i54.Key? key, required _i58.Sex sex})
      : super(OnboardingGynecologyRoute.name,
            path: 'doctor/gynecology',
            args: OnboardingGynecologyRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGynecologyRoute';
}

class OnboardingGynecologyRouteArgs {
  const OnboardingGynecologyRouteArgs({this.key, required this.sex});

  final _i54.Key? key;

  final _i58.Sex sex;

  @override
  String toString() {
    return 'OnboardingGynecologyRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i28.GynecologyAchievementScreen]
class GynecologyAchievementRoute extends _i14.PageRouteInfo<void> {
  const GynecologyAchievementRoute()
      : super(GynecologyAchievementRoute.name, path: 'gynecology-achievement');

  static const String name = 'GynecologyAchievementRoute';
}

/// generated route for
/// [_i29.GynecologyDateScreen]
class GynecologyDateRoute extends _i14.PageRouteInfo<void> {
  const GynecologyDateRoute()
      : super(GynecologyDateRoute.name, path: 'doctor/gynecology-date');

  static const String name = 'GynecologyDateRoute';
}

/// generated route for
/// [_i30.OnboardingDentistScreen]
class OnboardingDentistRoute
    extends _i14.PageRouteInfo<OnboardingDentistRouteArgs> {
  OnboardingDentistRoute({_i54.Key? key, required _i58.Sex sex})
      : super(OnboardingDentistRoute.name,
            path: 'doctor/dentist',
            args: OnboardingDentistRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingDentistRoute';
}

class OnboardingDentistRouteArgs {
  const OnboardingDentistRouteArgs({this.key, required this.sex});

  final _i54.Key? key;

  final _i58.Sex sex;

  @override
  String toString() {
    return 'OnboardingDentistRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i31.DentistAchievementScreen]
class DentistAchievementRoute extends _i14.PageRouteInfo<void> {
  const DentistAchievementRoute()
      : super(DentistAchievementRoute.name, path: 'dentist-achievement');

  static const String name = 'DentistAchievementRoute';
}

/// generated route for
/// [_i32.DentistDateScreen]
class DentistDateRoute extends _i14.PageRouteInfo<void> {
  const DentistDateRoute()
      : super(DentistDateRoute.name, path: 'doctor/dentist-date');

  static const String name = 'DentistDateRoute';
}

/// generated route for
/// [_i33.MainScreen]
class MainRoute extends _i14.PageRouteInfo<MainRouteArgs> {
  MainRoute({_i54.Key? key, int selectedIndex = 0})
      : super(MainRoute.name,
            path: '',
            args: MainRouteArgs(key: key, selectedIndex: selectedIndex));

  static const String name = 'MainRoute';
}

class MainRouteArgs {
  const MainRouteArgs({this.key, this.selectedIndex = 0});

  final _i54.Key? key;

  final int selectedIndex;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key, selectedIndex: $selectedIndex}';
  }
}

/// generated route for
/// [_i34.EditNicknameScreen]
class EditNicknameRoute extends _i14.PageRouteInfo<EditNicknameRouteArgs> {
  EditNicknameRoute({_i54.Key? key, required _i59.User? user})
      : super(EditNicknameRoute.name,
            path: 'settings/update-profile/nickname',
            args: EditNicknameRouteArgs(key: key, user: user));

  static const String name = 'EditNicknameRoute';
}

class EditNicknameRouteArgs {
  const EditNicknameRouteArgs({this.key, required this.user});

  final _i54.Key? key;

  final _i59.User? user;

  @override
  String toString() {
    return 'EditNicknameRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i35.EditEmailScreen]
class EditEmailRoute extends _i14.PageRouteInfo<EditEmailRouteArgs> {
  EditEmailRoute({_i54.Key? key, required _i59.User? user})
      : super(EditEmailRoute.name,
            path: 'settings/update-profile/email',
            args: EditEmailRouteArgs(key: key, user: user));

  static const String name = 'EditEmailRoute';
}

class EditEmailRouteArgs {
  const EditEmailRouteArgs({this.key, required this.user});

  final _i54.Key? key;

  final _i59.User? user;

  @override
  String toString() {
    return 'EditEmailRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i36.EditPhotoScreen]
class EditPhotoRoute extends _i14.PageRouteInfo<EditPhotoRouteArgs> {
  EditPhotoRoute(
      {_i54.Key? key,
      _i60.Uint8List? imageBytes,
      required dynamic Function(_i61.SettingsPage) changePage})
      : super(EditPhotoRoute.name,
            path: 'settings/update-profile/photo',
            args: EditPhotoRouteArgs(
                key: key, imageBytes: imageBytes, changePage: changePage));

  static const String name = 'EditPhotoRoute';
}

class EditPhotoRouteArgs {
  const EditPhotoRouteArgs(
      {this.key, this.imageBytes, required this.changePage});

  final _i54.Key? key;

  final _i60.Uint8List? imageBytes;

  final dynamic Function(_i61.SettingsPage) changePage;

  @override
  String toString() {
    return 'EditPhotoRouteArgs{key: $key, imageBytes: $imageBytes, changePage: $changePage}';
  }
}

/// generated route for
/// [_i37.DeleteAccountScreen]
class DeleteAccountRoute extends _i14.PageRouteInfo<void> {
  const DeleteAccountRoute()
      : super(DeleteAccountRoute.name, path: 'settings/update-profile/delete');

  static const String name = 'DeleteAccountRoute';
}

/// generated route for
/// [_i38.AfterDeletionScreen]
class AfterDeletionRoute extends _i14.PageRouteInfo<AfterDeletionRouteArgs> {
  AfterDeletionRoute({_i54.Key? key, required _i58.Sex sex})
      : super(AfterDeletionRoute.name,
            path: 'settings/update-profile/delete/after-deletion',
            args: AfterDeletionRouteArgs(key: key, sex: sex));

  static const String name = 'AfterDeletionRoute';
}

class AfterDeletionRouteArgs {
  const AfterDeletionRouteArgs({this.key, required this.sex});

  final _i54.Key? key;

  final _i58.Sex sex;

  @override
  String toString() {
    return 'AfterDeletionRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i39.CameraPhotoTakenScreen]
class CameraPhotoTakenRoute
    extends _i14.PageRouteInfo<CameraPhotoTakenRouteArgs> {
  CameraPhotoTakenRoute({_i54.Key? key, required _i60.Uint8List imageBytes})
      : super(CameraPhotoTakenRoute.name,
            path: 'settings/update-profile/photo/camera-taken',
            args: CameraPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'CameraPhotoTakenRoute';
}

class CameraPhotoTakenRouteArgs {
  const CameraPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i54.Key? key;

  final _i60.Uint8List imageBytes;

  @override
  String toString() {
    return 'CameraPhotoTakenRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i40.GalleryPhotoTakenScreen]
class GalleryPhotoTakenRoute
    extends _i14.PageRouteInfo<GalleryPhotoTakenRouteArgs> {
  GalleryPhotoTakenRoute({_i54.Key? key, required _i60.Uint8List imageBytes})
      : super(GalleryPhotoTakenRoute.name,
            path: 'settings/update-profile/photo/gallery-taken',
            args: GalleryPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'GalleryPhotoTakenRoute';
}

class GalleryPhotoTakenRouteArgs {
  const GalleryPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i54.Key? key;

  final _i60.Uint8List imageBytes;

  @override
  String toString() {
    return 'GalleryPhotoTakenRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i41.PhotoCroppedResultScreen]
class PhotoCroppedResultRoute
    extends _i14.PageRouteInfo<PhotoCroppedResultRouteArgs> {
  PhotoCroppedResultRoute({_i54.Key? key, required _i60.Uint8List imageBytes})
      : super(PhotoCroppedResultRoute.name,
            path: 'settings/update-profile/photo/photo-cropped-result',
            args:
                PhotoCroppedResultRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'PhotoCroppedResultRoute';
}

class PhotoCroppedResultRouteArgs {
  const PhotoCroppedResultRouteArgs({this.key, required this.imageBytes});

  final _i54.Key? key;

  final _i60.Uint8List imageBytes;

  @override
  String toString() {
    return 'PhotoCroppedResultRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i42.ExaminationDetailScreen]
class ExaminationDetailRoute
    extends _i14.PageRouteInfo<ExaminationDetailRouteArgs> {
  ExaminationDetailRoute(
      {_i54.Key? key,
      required _i62.CategorizedExamination categorizedExamination,
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

  final _i54.Key? key;

  final _i62.CategorizedExamination categorizedExamination;

  final String? initialMessage;

  @override
  String toString() {
    return 'ExaminationDetailRouteArgs{key: $key, categorizedExamination: $categorizedExamination, initialMessage: $initialMessage}';
  }
}

/// generated route for
/// [_i43.AchievementScreen]
class AchievementRoute extends _i14.PageRouteInfo<AchievementRouteArgs> {
  AchievementRoute(
      {_i54.Key? key,
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

  final _i54.Key? key;

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
/// [_i44.DatePickerScreen]
class DatePickerRoute extends _i14.PageRouteInfo<DatePickerRouteArgs> {
  DatePickerRoute(
      {_i54.Key? key,
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

  final _i54.Key? key;

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
/// [_i45.CalendarPermissionInfoScreen]
class CalendarPermissionInfoRoute
    extends _i14.PageRouteInfo<CalendarPermissionInfoRouteArgs> {
  CalendarPermissionInfoRoute(
      {_i54.Key? key,
      required _i58.ExaminationPreventionStatus examinationRecord})
      : super(CalendarPermissionInfoRoute.name,
            path: 'calendar/permission',
            args: CalendarPermissionInfoRouteArgs(
                key: key, examinationRecord: examinationRecord));

  static const String name = 'CalendarPermissionInfoRoute';
}

class CalendarPermissionInfoRouteArgs {
  const CalendarPermissionInfoRouteArgs(
      {this.key, required this.examinationRecord});

  final _i54.Key? key;

  final _i58.ExaminationPreventionStatus examinationRecord;

  @override
  String toString() {
    return 'CalendarPermissionInfoRouteArgs{key: $key, examinationRecord: $examinationRecord}';
  }
}

/// generated route for
/// [_i46.CalendarListScreen]
class CalendarListRoute extends _i14.PageRouteInfo<CalendarListRouteArgs> {
  CalendarListRoute(
      {_i54.Key? key,
      required _i58.ExaminationPreventionStatus examinationRecord})
      : super(CalendarListRoute.name,
            path: 'calendar/list',
            args: CalendarListRouteArgs(
                key: key, examinationRecord: examinationRecord));

  static const String name = 'CalendarListRoute';
}

class CalendarListRouteArgs {
  const CalendarListRouteArgs({this.key, required this.examinationRecord});

  final _i54.Key? key;

  final _i58.ExaminationPreventionStatus examinationRecord;

  @override
  String toString() {
    return 'CalendarListRouteArgs{key: $key, examinationRecord: $examinationRecord}';
  }
}

/// generated route for
/// [_i47.ChangeLastVisitScreen]
class ChangeLastVisitRoute
    extends _i14.PageRouteInfo<ChangeLastVisitRouteArgs> {
  ChangeLastVisitRoute(
      {_i54.Key? key,
      required DateTime originalDate,
      required String title,
      required _i58.ExaminationType examinationType,
      required String? uuid,
      required _i63.ExaminationCategory status})
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

  final _i54.Key? key;

  final DateTime originalDate;

  final String title;

  final _i58.ExaminationType examinationType;

  final String? uuid;

  final _i63.ExaminationCategory status;

  @override
  String toString() {
    return 'ChangeLastVisitRouteArgs{key: $key, originalDate: $originalDate, title: $title, examinationType: $examinationType, uuid: $uuid, status: $status}';
  }
}

/// generated route for
/// [_i48.SelfExaminationDetailScreen]
class SelfExaminationDetailRoute
    extends _i14.PageRouteInfo<SelfExaminationDetailRouteArgs> {
  SelfExaminationDetailRoute(
      {_i54.Key? key,
      required _i58.Sex sex,
      required _i58.SelfExaminationPreventionStatus selfExamination})
      : super(SelfExaminationDetailRoute.name,
            path: 'self-examination/detail',
            args: SelfExaminationDetailRouteArgs(
                key: key, sex: sex, selfExamination: selfExamination));

  static const String name = 'SelfExaminationDetailRoute';
}

class SelfExaminationDetailRouteArgs {
  const SelfExaminationDetailRouteArgs(
      {this.key, required this.sex, required this.selfExamination});

  final _i54.Key? key;

  final _i58.Sex sex;

  final _i58.SelfExaminationPreventionStatus selfExamination;

  @override
  String toString() {
    return 'SelfExaminationDetailRouteArgs{key: $key, sex: $sex, selfExamination: $selfExamination}';
  }
}

/// generated route for
/// [_i49.EducationalVideoScreen]
class EducationalVideoRoute
    extends _i14.PageRouteInfo<EducationalVideoRouteArgs> {
  EducationalVideoRoute(
      {_i54.Key? key,
      required _i58.Sex sex,
      required _i58.SelfExaminationPreventionStatus selfExamination})
      : super(EducationalVideoRoute.name,
            path: 'self-examination/detail/educational-video',
            args: EducationalVideoRouteArgs(
                key: key, sex: sex, selfExamination: selfExamination));

  static const String name = 'EducationalVideoRoute';
}

class EducationalVideoRouteArgs {
  const EducationalVideoRouteArgs(
      {this.key, required this.sex, required this.selfExamination});

  final _i54.Key? key;

  final _i58.Sex sex;

  final _i58.SelfExaminationPreventionStatus selfExamination;

  @override
  String toString() {
    return 'EducationalVideoRouteArgs{key: $key, sex: $sex, selfExamination: $selfExamination}';
  }
}

/// generated route for
/// [_i50.HasFindingScreen]
class HasFindingRoute extends _i14.PageRouteInfo<HasFindingRouteArgs> {
  HasFindingRoute({_i54.Key? key, required _i58.Sex sex})
      : super(HasFindingRoute.name,
            path: 'self-examination/detail/has-finding',
            args: HasFindingRouteArgs(key: key, sex: sex));

  static const String name = 'HasFindingRoute';
}

class HasFindingRouteArgs {
  const HasFindingRouteArgs({this.key, required this.sex});

  final _i54.Key? key;

  final _i58.Sex sex;

  @override
  String toString() {
    return 'HasFindingRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i51.NoFindingScreen]
class NoFindingRoute extends _i14.PageRouteInfo<NoFindingRouteArgs> {
  NoFindingRoute({_i54.Key? key, required int points})
      : super(NoFindingRoute.name,
            path: 'self-examination/detail/no-finding',
            args: NoFindingRouteArgs(key: key, points: points));

  static const String name = 'NoFindingRoute';
}

class NoFindingRouteArgs {
  const NoFindingRouteArgs({this.key, required this.points});

  final _i54.Key? key;

  final int points;

  @override
  String toString() {
    return 'NoFindingRouteArgs{key: $key, points: $points}';
  }
}

/// generated route for
/// [_i52.ProgressRewardScreen]
class ProgressRewardRoute extends _i14.PageRouteInfo<void> {
  const ProgressRewardRoute()
      : super(ProgressRewardRoute.name,
            path: 'self-examination/detail/progress-reward');

  static const String name = 'ProgressRewardRoute';
}

/// generated route for
/// [_i53.ResultFromDoctorScreen]
class ResultFromDoctorRoute
    extends _i14.PageRouteInfo<ResultFromDoctorRouteArgs> {
  ResultFromDoctorRoute(
      {_i54.Key? key,
      required _i58.Sex sex,
      required _i58.SelfExaminationPreventionStatus selfExamination})
      : super(ResultFromDoctorRoute.name,
            path: 'self-examination/detail/reusult-from-doctor',
            args: ResultFromDoctorRouteArgs(
                key: key, sex: sex, selfExamination: selfExamination));

  static const String name = 'ResultFromDoctorRoute';
}

class ResultFromDoctorRouteArgs {
  const ResultFromDoctorRouteArgs(
      {this.key, required this.sex, required this.selfExamination});

  final _i54.Key? key;

  final _i58.Sex sex;

  final _i58.SelfExaminationPreventionStatus selfExamination;

  @override
  String toString() {
    return 'ResultFromDoctorRouteArgs{key: $key, sex: $sex, selfExamination: $selfExamination}';
  }
}
