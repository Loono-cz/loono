// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'dart:typed_data' as _i58;

import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i52;
import 'package:loono_api/loono_api.dart' as _i56;

import '../helpers/examination_category.dart' as _i61;
import '../models/categorized_examination.dart' as _i60;
import '../models/search_result.dart' as _i54;
import '../models/social_login_account.dart' as _i55;
import '../services/db/database.dart' as _i57;
import '../ui/screens/about_health/about_health.dart' as _i17;
import '../ui/screens/dentist_achievement.dart' as _i30;
import '../ui/screens/find_doctor/doctor_search_detail.dart' as _i16;
import '../ui/screens/find_doctor/find_doctor.dart' as _i15;
import '../ui/screens/general_practicioner_achievement.dart' as _i24;
import '../ui/screens/gynecology_achievement.dart' as _i27;
import '../ui/screens/logout.dart' as _i11;
import '../ui/screens/main/main_screen.dart' as _i32;
import '../ui/screens/main/pre_auth/continue_onboarding_form.dart' as _i19;
import '../ui/screens/main/pre_auth/login.dart' as _i10;
import '../ui/screens/main/pre_auth/onboarding_form_done.dart' as _i20;
import '../ui/screens/main/pre_auth/pre_auth_main_screen.dart' as _i2;
import '../ui/screens/main/pre_auth/start_new_questionnaire.dart' as _i18;
import '../ui/screens/onboarding/allow_notifications.dart' as _i5;
import '../ui/screens/onboarding/birthdate.dart' as _i22;
import '../ui/screens/onboarding/carousel/carousel.dart' as _i3;
import '../ui/screens/onboarding/doctors/dentist.dart' as _i29;
import '../ui/screens/onboarding/doctors/dentist_date.dart' as _i31;
import '../ui/screens/onboarding/doctors/general_practicioner.dart' as _i23;
import '../ui/screens/onboarding/doctors/general_practitioner_date.dart'
    as _i25;
import '../ui/screens/onboarding/doctors/gynecology.dart' as _i26;
import '../ui/screens/onboarding/doctors/gynecology_date.dart' as _i28;
import '../ui/screens/onboarding/fallback_account/email.dart' as _i9;
import '../ui/screens/onboarding/fallback_account/nickname.dart' as _i8;
import '../ui/screens/onboarding/fill_form_later.dart' as _i6;
import '../ui/screens/onboarding/gamification_introduction.dart' as _i7;
import '../ui/screens/onboarding/gender.dart' as _i21;
import '../ui/screens/prevention/calendar/calendar_list.dart' as _i45;
import '../ui/screens/prevention/calendar/permission_info.dart' as _i44;
import '../ui/screens/prevention/examination_detail/change_last_visit_screen.dart'
    as _i46;
import '../ui/screens/prevention/examination_detail/examination_screen.dart'
    as _i41;
import '../ui/screens/prevention/questionnaire/date_picker_screen.dart' as _i43;
import '../ui/screens/prevention/self_examination/detail_screen.dart' as _i47;
import '../ui/screens/prevention/self_examination/educational_screen.dart'
    as _i48;
import '../ui/screens/prevention/self_examination/has_finding_screen.dart'
    as _i49;
import '../ui/screens/prevention/self_examination/no_finding_screen.dart'
    as _i50;
import '../ui/screens/prevention/self_examination/progress_screen.dart' as _i51;
import '../ui/screens/settings/after_deletion.dart' as _i37;
import '../ui/screens/settings/camera_photo_taken.dart' as _i38;
import '../ui/screens/settings/delete_account.dart' as _i36;
import '../ui/screens/settings/edit_email.dart' as _i34;
import '../ui/screens/settings/edit_nickname.dart' as _i33;
import '../ui/screens/settings/edit_photo.dart' as _i35;
import '../ui/screens/settings/gallery_photo_taken.dart' as _i39;
import '../ui/screens/settings/photo_cropped_result.dart' as _i40;
import '../ui/screens/settings/settings_bottom_sheet.dart' as _i59;
import '../ui/screens/welcome.dart' as _i13;
import '../ui/widgets/achievement_screen.dart' as _i42;
import 'guards/check_is_logged_in.dart' as _i53;
import 'sub_routers/app_startup_wrapper_screen.dart' as _i1;
import 'sub_routers/onboarding_wrapper_screen.dart' as _i4;
import 'sub_routers/pre_auth_prevention_wrapper_screen.dart' as _i14;

class AppRouter extends _i12.RootStackRouter {
  AppRouter(
      {_i52.GlobalKey<_i52.NavigatorState>? navigatorKey,
      required this.checkIsLoggedIn})
      : super(navigatorKey);

  final _i53.CheckIsLoggedIn checkIsLoggedIn;

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    AppStartUpWrapperRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i1.AppStartUpWrapperScreen());
    },
    PreAuthMainRoute.name: (routeData) {
      final args = routeData.argsAs<PreAuthMainRouteArgs>(
          orElse: () => const PreAuthMainRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i2.PreAuthMainScreen(
              key: args.key,
              overridenPreventionRoute: args.overridenPreventionRoute));
    },
    IntroCarouselRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i3.IntroCarouselScreen());
    },
    OnboardingWrapperRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i4.OnboardingWrapperScreen());
    },
    AllowNotificationsRoute.name: (routeData) {
      final args = routeData.argsAs<AllowNotificationsRouteArgs>(
          orElse: () => const AllowNotificationsRouteArgs());
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i5.AllowNotificationsScreen(
              key: args.key,
              onSkipTap: args.onSkipTap,
              onContinueTap: args.onContinueTap),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    FillOnboardingFormLaterRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: const _i6.FillOnboardingFormLaterScreen());
    },
    GamificationIntroductionRoute.name: (routeData) {
      final args = routeData.argsAs<GamificationIntroductionRouteArgs>(
          orElse: () => const GamificationIntroductionRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i7.GamificationIntroductionScreen(key: args.key));
    },
    NicknameRoute.name: (routeData) {
      final args = routeData.argsAs<NicknameRouteArgs>();
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i8.NicknameScreen(
              key: args.key, socialLoginAccount: args.socialLoginAccount));
    },
    EmailRoute.name: (routeData) {
      final args = routeData.argsAs<EmailRouteArgs>();
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i9.EmailScreen(
              key: args.key, socialLoginAccount: args.socialLoginAccount));
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: _i10.LoginScreen(key: args.key));
    },
    LogoutRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i11.LogoutScreen());
    },
    MainScreenRouter.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i12.EmptyRouterScreen());
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: _i13.WelcomeScreen(key: args.key));
    },
    PreAuthPreventionWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<PreAuthPreventionWrapperRouteArgs>(
          orElse: () => const PreAuthPreventionWrapperRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i14.PreAuthPreventionWrapperScreen(
              key: args.key, forceRoute: args.forceRoute));
    },
    FindDoctorRoute.name: (routeData) {
      final args = routeData.argsAs<FindDoctorRouteArgs>(
          orElse: () => const FindDoctorRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i15.FindDoctorScreen(
              key: args.key, cancelRouteName: args.cancelRouteName));
    },
    DoctorSearchDetailRoute.name: (routeData) {
      return _i12.CustomPage<_i54.SearchResult>(
          routeData: routeData,
          child: const _i16.DoctorSearchDetailScreen(),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AboutHealthRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i17.AboutHealthScreen());
    },
    StartNewQuestionnaireRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: const _i18.StartNewQuestionnaireScreen());
    },
    ContinueOnboardingFormRoute.name: (routeData) {
      final args = routeData.argsAs<ContinueOnboardingFormRouteArgs>(
          orElse: () => const ContinueOnboardingFormRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i19.ContinueOnboardingFormScreen(key: args.key));
    },
    OnboardingFormDoneRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingFormDoneRouteArgs>(
          orElse: () => const OnboardingFormDoneRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i20.OnboardingFormDoneScreen(key: args.key));
    },
    OnboardingGenderRoute.name: (routeData) {
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: const _i21.OnboardingGenderScreen(),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnBoardingBirthdateRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingBirthdateRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i22.OnBoardingBirthdateScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGeneralPracticionerRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGeneralPracticionerRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i23.OnboardingGeneralPracticionerScreen(
              key: args.key, sex: args.sex),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPracticionerAchievementRoute.name: (routeData) {
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: const _i24.GeneralPracticionerAchievementScreen(),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPractitionerDateRoute.name: (routeData) {
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: const _i25.GeneralPractitionerDateScreen(),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGynecologyRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGynecologyRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i26.OnboardingGynecologyScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyAchievementRoute.name: (routeData) {
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: const _i27.GynecologyAchievementScreen(),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyDateRoute.name: (routeData) {
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: const _i28.GynecologyDateScreen(),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingDentistRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingDentistRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i29.OnboardingDentistScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistAchievementRoute.name: (routeData) {
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: const _i30.DentistAchievementScreen(),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistDateRoute.name: (routeData) {
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: const _i31.DentistDateScreen(),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    MainRoute.name: (routeData) {
      final args =
          routeData.argsAs<MainRouteArgs>(orElse: () => const MainRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i32.MainScreen(
              key: args.key, selectedIndex: args.selectedIndex));
    },
    EditNicknameRoute.name: (routeData) {
      final args = routeData.argsAs<EditNicknameRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i33.EditNicknameScreen(key: args.key, user: args.user),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditEmailRoute.name: (routeData) {
      final args = routeData.argsAs<EditEmailRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i34.EditEmailScreen(key: args.key, user: args.user),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditPhotoRoute.name: (routeData) {
      final args = routeData.argsAs<EditPhotoRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i35.EditPhotoScreen(
              key: args.key,
              imageBytes: args.imageBytes,
              changePage: args.changePage),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DeleteAccountRoute.name: (routeData) {
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: const _i36.DeleteAccountScreen(),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AfterDeletionRoute.name: (routeData) {
      final args = routeData.argsAs<AfterDeletionRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i37.AfterDeletionScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CameraPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<CameraPhotoTakenRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i38.CameraPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GalleryPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<GalleryPhotoTakenRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i39.GalleryPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    PhotoCroppedResultRoute.name: (routeData) {
      final args = routeData.argsAs<PhotoCroppedResultRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i40.PhotoCroppedResultScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ExaminationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ExaminationDetailRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i41.ExaminationDetailScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AchievementRoute.name: (routeData) {
      final args = routeData.argsAs<AchievementRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i42.AchievementScreen(
              key: args.key,
              header: args.header,
              textLines: args.textLines,
              numberOfPoints: args.numberOfPoints,
              itemPath: args.itemPath,
              onButtonTap: args.onButtonTap),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DatePickerRoute.name: (routeData) {
      final args = routeData.argsAs<DatePickerRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i43.DatePickerScreen(
              key: args.key,
              assetPath: args.assetPath,
              title: args.title,
              onContinueButtonPress: args.onContinueButtonPress,
              onSkipButtonPress: args.onSkipButtonPress),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CalendarPermissionInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarPermissionInfoRouteArgs>();
      return _i12.CustomPage<bool>(
          routeData: routeData,
          child: _i44.CalendarPermissionInfoScreen(
              key: args.key, examinationRecord: args.examinationRecord),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CalendarListRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarListRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i45.CalendarListScreen(
              key: args.key, examinationRecord: args.examinationRecord),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ChangeLastVisitRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeLastVisitRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i46.ChangeLastVisitScreen(
              key: args.key,
              originalDate: args.originalDate,
              title: args.title,
              examinationType: args.examinationType,
              uuid: args.uuid,
              status: args.status),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    SelfExaminationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SelfExaminationDetailRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i47.SelfExaminationDetailScreen(
              key: args.key,
              sex: args.sex,
              selfExamination: args.selfExamination),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EducationalVideoRoute.name: (routeData) {
      final args = routeData.argsAs<EducationalVideoRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i48.EducationalVideoScreen(
              key: args.key,
              sex: args.sex,
              selfExamination: args.selfExamination),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HasFindingRoute.name: (routeData) {
      final args = routeData.argsAs<HasFindingRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i49.HasFindingScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    NoFindingRoute.name: (routeData) {
      final args = routeData.argsAs<NoFindingRouteArgs>();
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: _i50.NoFindingScreen(key: args.key, points: args.points),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ProgressRewardRoute.name: (routeData) {
      return _i12.CustomPage<void>(
          routeData: routeData,
          child: const _i51.ProgressRewardScreen(),
          transitionsBuilder: _i12.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig('/#redirect',
            path: '/', redirectTo: 'main', fullMatch: true),
        _i12.RouteConfig(AppStartUpWrapperRoute.name,
            path: 'app-start-up',
            children: [
              _i12.RouteConfig(WelcomeRoute.name,
                  path: 'welcome', parent: AppStartUpWrapperRoute.name),
              _i12.RouteConfig(PreAuthMainRoute.name,
                  path: 'pre-auth-main',
                  parent: AppStartUpWrapperRoute.name,
                  children: [
                    _i12.RouteConfig(PreAuthPreventionWrapperRoute.name,
                        path: 'pre-auth-prevention',
                        parent: PreAuthMainRoute.name,
                        children: [
                          _i12.RouteConfig(LoginRoute.name,
                              path: 'login',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i12.RouteConfig(StartNewQuestionnaireRoute.name,
                              path: 'start-new-questionnaire',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i12.RouteConfig(ContinueOnboardingFormRoute.name,
                              path: 'continue-onboarding-form',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i12.RouteConfig(OnboardingFormDoneRoute.name,
                              path: 'onboarding-form-done',
                              parent: PreAuthPreventionWrapperRoute.name)
                        ]),
                    _i12.RouteConfig(FindDoctorRoute.name,
                        path: 'find-doctor', parent: PreAuthMainRoute.name),
                    _i12.RouteConfig(DoctorSearchDetailRoute.name,
                        path: 'find-doctor/search/detail',
                        parent: PreAuthMainRoute.name),
                    _i12.RouteConfig(AboutHealthRoute.name,
                        path: 'about-health', parent: PreAuthMainRoute.name)
                  ])
            ]),
        _i12.RouteConfig(PreAuthMainRoute.name,
            path: 'pre-auth-main',
            children: [
              _i12.RouteConfig(PreAuthPreventionWrapperRoute.name,
                  path: 'pre-auth-prevention',
                  parent: PreAuthMainRoute.name,
                  children: [
                    _i12.RouteConfig(LoginRoute.name,
                        path: 'login',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i12.RouteConfig(StartNewQuestionnaireRoute.name,
                        path: 'start-new-questionnaire',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i12.RouteConfig(ContinueOnboardingFormRoute.name,
                        path: 'continue-onboarding-form',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i12.RouteConfig(OnboardingFormDoneRoute.name,
                        path: 'onboarding-form-done',
                        parent: PreAuthPreventionWrapperRoute.name)
                  ]),
              _i12.RouteConfig(FindDoctorRoute.name,
                  path: 'find-doctor', parent: PreAuthMainRoute.name),
              _i12.RouteConfig(DoctorSearchDetailRoute.name,
                  path: 'find-doctor/search/detail',
                  parent: PreAuthMainRoute.name),
              _i12.RouteConfig(AboutHealthRoute.name,
                  path: 'about-health', parent: PreAuthMainRoute.name)
            ]),
        _i12.RouteConfig(IntroCarouselRoute.name, path: 'intro-carousel'),
        _i12.RouteConfig(OnboardingWrapperRoute.name,
            path: 'onboarding',
            children: [
              _i12.RouteConfig(OnboardingGenderRoute.name,
                  path: 'gender', parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(OnBoardingBirthdateRoute.name,
                  path: 'birthdate', parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(OnboardingGeneralPracticionerRoute.name,
                  path: 'doctor/general-practicioner',
                  parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(GeneralPracticionerAchievementRoute.name,
                  path: 'general-practicioner-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(GeneralPractitionerDateRoute.name,
                  path: 'doctor/general-practitioner-date',
                  parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(AllowNotificationsRoute.name,
                  path: 'allow-notifications',
                  parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(OnboardingGynecologyRoute.name,
                  path: 'doctor/gynecology',
                  parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(GynecologyAchievementRoute.name,
                  path: 'gynecology-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(GynecologyDateRoute.name,
                  path: 'doctor/gynecology-date',
                  parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(OnboardingDentistRoute.name,
                  path: 'doctor/dentist', parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(DentistAchievementRoute.name,
                  path: 'dentist-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i12.RouteConfig(DentistDateRoute.name,
                  path: 'doctor/dentist-date',
                  parent: OnboardingWrapperRoute.name)
            ]),
        _i12.RouteConfig(AllowNotificationsRoute.name,
            path: 'allow-notifications'),
        _i12.RouteConfig(FillOnboardingFormLaterRoute.name,
            path: 'fill-form-later'),
        _i12.RouteConfig(GamificationIntroductionRoute.name,
            path: 'gamification-introduction'),
        _i12.RouteConfig(NicknameRoute.name, path: 'fallback-account/name'),
        _i12.RouteConfig(EmailRoute.name, path: 'fallback-account/email'),
        _i12.RouteConfig(LoginRoute.name, path: 'login'),
        _i12.RouteConfig(LogoutRoute.name, path: 'logout'),
        _i12.RouteConfig(MainScreenRouter.name, path: 'main', guards: [
          checkIsLoggedIn
        ], children: [
          _i12.RouteConfig(MainRoute.name,
              path: '', parent: MainScreenRouter.name),
          _i12.RouteConfig(EditNicknameRoute.name,
              path: 'settings/update-profile/nickname',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(EditEmailRoute.name,
              path: 'settings/update-profile/email',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(EditPhotoRoute.name,
              path: 'settings/update-profile/photo',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(DeleteAccountRoute.name,
              path: 'settings/update-profile/delete',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(AfterDeletionRoute.name,
              path: 'settings/update-profile/delete/after-deletion',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(CameraPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/camera-taken',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(GalleryPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/gallery-taken',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(PhotoCroppedResultRoute.name,
              path: 'settings/update-profile/photo/photo-cropped-result',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(ExaminationDetailRoute.name,
              path: 'prevention-detail', parent: MainScreenRouter.name),
          _i12.RouteConfig(AchievementRoute.name,
              path: 'questionnaire/reward', parent: MainScreenRouter.name),
          _i12.RouteConfig(DatePickerRoute.name,
              path: 'questionnaire/date-picker', parent: MainScreenRouter.name),
          _i12.RouteConfig(CalendarPermissionInfoRoute.name,
              path: 'calendar/permission', parent: MainScreenRouter.name),
          _i12.RouteConfig(CalendarListRoute.name,
              path: 'calendar/list', parent: MainScreenRouter.name),
          _i12.RouteConfig(ChangeLastVisitRoute.name,
              path: 'checkup/last-visit-update', parent: MainScreenRouter.name),
          _i12.RouteConfig(SelfExaminationDetailRoute.name,
              path: 'self-examination/detail', parent: MainScreenRouter.name),
          _i12.RouteConfig(EducationalVideoRoute.name,
              path: 'self-examination/detail/educational-video',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(HasFindingRoute.name,
              path: 'self-examination/detail/has-finding',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(NoFindingRoute.name,
              path: 'self-examination/detail/no-finding',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(ProgressRewardRoute.name,
              path: 'self-examination/detail/progress-reward',
              parent: MainScreenRouter.name),
          _i12.RouteConfig(FindDoctorRoute.name,
              path: 'find-doctor', parent: MainScreenRouter.name),
          _i12.RouteConfig(DoctorSearchDetailRoute.name,
              path: 'find-doctor/search/detail', parent: MainScreenRouter.name),
          _i12.RouteConfig(AboutHealthRoute.name,
              path: 'about-health', parent: MainScreenRouter.name)
        ])
      ];
}

/// generated route for
/// [_i1.AppStartUpWrapperScreen]
class AppStartUpWrapperRoute extends _i12.PageRouteInfo<void> {
  const AppStartUpWrapperRoute({List<_i12.PageRouteInfo>? children})
      : super(AppStartUpWrapperRoute.name,
            path: 'app-start-up', initialChildren: children);

  static const String name = 'AppStartUpWrapperRoute';
}

/// generated route for
/// [_i2.PreAuthMainScreen]
class PreAuthMainRoute extends _i12.PageRouteInfo<PreAuthMainRouteArgs> {
  PreAuthMainRoute(
      {_i52.Key? key,
      _i12.PageRouteInfo<dynamic>? overridenPreventionRoute,
      List<_i12.PageRouteInfo>? children})
      : super(PreAuthMainRoute.name,
            path: 'pre-auth-main',
            args: PreAuthMainRouteArgs(
                key: key, overridenPreventionRoute: overridenPreventionRoute),
            initialChildren: children);

  static const String name = 'PreAuthMainRoute';
}

class PreAuthMainRouteArgs {
  const PreAuthMainRouteArgs({this.key, this.overridenPreventionRoute});

  final _i52.Key? key;

  final _i12.PageRouteInfo<dynamic>? overridenPreventionRoute;

  @override
  String toString() {
    return 'PreAuthMainRouteArgs{key: $key, overridenPreventionRoute: $overridenPreventionRoute}';
  }
}

/// generated route for
/// [_i3.IntroCarouselScreen]
class IntroCarouselRoute extends _i12.PageRouteInfo<void> {
  const IntroCarouselRoute()
      : super(IntroCarouselRoute.name, path: 'intro-carousel');

  static const String name = 'IntroCarouselRoute';
}

/// generated route for
/// [_i4.OnboardingWrapperScreen]
class OnboardingWrapperRoute extends _i12.PageRouteInfo<void> {
  const OnboardingWrapperRoute({List<_i12.PageRouteInfo>? children})
      : super(OnboardingWrapperRoute.name,
            path: 'onboarding', initialChildren: children);

  static const String name = 'OnboardingWrapperRoute';
}

/// generated route for
/// [_i5.AllowNotificationsScreen]
class AllowNotificationsRoute
    extends _i12.PageRouteInfo<AllowNotificationsRouteArgs> {
  AllowNotificationsRoute(
      {_i52.Key? key,
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

  final _i52.Key? key;

  final void Function()? onSkipTap;

  final void Function()? onContinueTap;

  @override
  String toString() {
    return 'AllowNotificationsRouteArgs{key: $key, onSkipTap: $onSkipTap, onContinueTap: $onContinueTap}';
  }
}

/// generated route for
/// [_i6.FillOnboardingFormLaterScreen]
class FillOnboardingFormLaterRoute extends _i12.PageRouteInfo<void> {
  const FillOnboardingFormLaterRoute()
      : super(FillOnboardingFormLaterRoute.name, path: 'fill-form-later');

  static const String name = 'FillOnboardingFormLaterRoute';
}

/// generated route for
/// [_i7.GamificationIntroductionScreen]
class GamificationIntroductionRoute
    extends _i12.PageRouteInfo<GamificationIntroductionRouteArgs> {
  GamificationIntroductionRoute({_i52.Key? key})
      : super(GamificationIntroductionRoute.name,
            path: 'gamification-introduction',
            args: GamificationIntroductionRouteArgs(key: key));

  static const String name = 'GamificationIntroductionRoute';
}

class GamificationIntroductionRouteArgs {
  const GamificationIntroductionRouteArgs({this.key});

  final _i52.Key? key;

  @override
  String toString() {
    return 'GamificationIntroductionRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.NicknameScreen]
class NicknameRoute extends _i12.PageRouteInfo<NicknameRouteArgs> {
  NicknameRoute(
      {_i52.Key? key, required _i55.SocialLoginAccount socialLoginAccount})
      : super(NicknameRoute.name,
            path: 'fallback-account/name',
            args: NicknameRouteArgs(
                key: key, socialLoginAccount: socialLoginAccount));

  static const String name = 'NicknameRoute';
}

class NicknameRouteArgs {
  const NicknameRouteArgs({this.key, required this.socialLoginAccount});

  final _i52.Key? key;

  final _i55.SocialLoginAccount socialLoginAccount;

  @override
  String toString() {
    return 'NicknameRouteArgs{key: $key, socialLoginAccount: $socialLoginAccount}';
  }
}

/// generated route for
/// [_i9.EmailScreen]
class EmailRoute extends _i12.PageRouteInfo<EmailRouteArgs> {
  EmailRoute(
      {_i52.Key? key, required _i55.SocialLoginAccount socialLoginAccount})
      : super(EmailRoute.name,
            path: 'fallback-account/email',
            args: EmailRouteArgs(
                key: key, socialLoginAccount: socialLoginAccount));

  static const String name = 'EmailRoute';
}

class EmailRouteArgs {
  const EmailRouteArgs({this.key, required this.socialLoginAccount});

  final _i52.Key? key;

  final _i55.SocialLoginAccount socialLoginAccount;

  @override
  String toString() {
    return 'EmailRouteArgs{key: $key, socialLoginAccount: $socialLoginAccount}';
  }
}

/// generated route for
/// [_i10.LoginScreen]
class LoginRoute extends _i12.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i52.Key? key})
      : super(LoginRoute.name, path: 'login', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i52.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.LogoutScreen]
class LogoutRoute extends _i12.PageRouteInfo<void> {
  const LogoutRoute() : super(LogoutRoute.name, path: 'logout');

  static const String name = 'LogoutRoute';
}

/// generated route for
/// [_i12.EmptyRouterScreen]
class MainScreenRouter extends _i12.PageRouteInfo<void> {
  const MainScreenRouter({List<_i12.PageRouteInfo>? children})
      : super(MainScreenRouter.name, path: 'main', initialChildren: children);

  static const String name = 'MainScreenRouter';
}

/// generated route for
/// [_i13.WelcomeScreen]
class WelcomeRoute extends _i12.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({_i52.Key? key})
      : super(WelcomeRoute.name,
            path: 'welcome', args: WelcomeRouteArgs(key: key));

  static const String name = 'WelcomeRoute';
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i52.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.PreAuthPreventionWrapperScreen]
class PreAuthPreventionWrapperRoute
    extends _i12.PageRouteInfo<PreAuthPreventionWrapperRouteArgs> {
  PreAuthPreventionWrapperRoute(
      {_i52.Key? key,
      _i12.PageRouteInfo<dynamic>? forceRoute,
      List<_i12.PageRouteInfo>? children})
      : super(PreAuthPreventionWrapperRoute.name,
            path: 'pre-auth-prevention',
            args: PreAuthPreventionWrapperRouteArgs(
                key: key, forceRoute: forceRoute),
            initialChildren: children);

  static const String name = 'PreAuthPreventionWrapperRoute';
}

class PreAuthPreventionWrapperRouteArgs {
  const PreAuthPreventionWrapperRouteArgs({this.key, this.forceRoute});

  final _i52.Key? key;

  final _i12.PageRouteInfo<dynamic>? forceRoute;

  @override
  String toString() {
    return 'PreAuthPreventionWrapperRouteArgs{key: $key, forceRoute: $forceRoute}';
  }
}

/// generated route for
/// [_i15.FindDoctorScreen]
class FindDoctorRoute extends _i12.PageRouteInfo<FindDoctorRouteArgs> {
  FindDoctorRoute({_i52.Key? key, _i12.PageRouteInfo<dynamic>? cancelRouteName})
      : super(FindDoctorRoute.name,
            path: 'find-doctor',
            args: FindDoctorRouteArgs(
                key: key, cancelRouteName: cancelRouteName));

  static const String name = 'FindDoctorRoute';
}

class FindDoctorRouteArgs {
  const FindDoctorRouteArgs({this.key, this.cancelRouteName});

  final _i52.Key? key;

  final _i12.PageRouteInfo<dynamic>? cancelRouteName;

  @override
  String toString() {
    return 'FindDoctorRouteArgs{key: $key, cancelRouteName: $cancelRouteName}';
  }
}

/// generated route for
/// [_i16.DoctorSearchDetailScreen]
class DoctorSearchDetailRoute extends _i12.PageRouteInfo<void> {
  const DoctorSearchDetailRoute()
      : super(DoctorSearchDetailRoute.name, path: 'find-doctor/search/detail');

  static const String name = 'DoctorSearchDetailRoute';
}

/// generated route for
/// [_i17.AboutHealthScreen]
class AboutHealthRoute extends _i12.PageRouteInfo<void> {
  const AboutHealthRoute() : super(AboutHealthRoute.name, path: 'about-health');

  static const String name = 'AboutHealthRoute';
}

/// generated route for
/// [_i18.StartNewQuestionnaireScreen]
class StartNewQuestionnaireRoute extends _i12.PageRouteInfo<void> {
  const StartNewQuestionnaireRoute()
      : super(StartNewQuestionnaireRoute.name, path: 'start-new-questionnaire');

  static const String name = 'StartNewQuestionnaireRoute';
}

/// generated route for
/// [_i19.ContinueOnboardingFormScreen]
class ContinueOnboardingFormRoute
    extends _i12.PageRouteInfo<ContinueOnboardingFormRouteArgs> {
  ContinueOnboardingFormRoute({_i52.Key? key})
      : super(ContinueOnboardingFormRoute.name,
            path: 'continue-onboarding-form',
            args: ContinueOnboardingFormRouteArgs(key: key));

  static const String name = 'ContinueOnboardingFormRoute';
}

class ContinueOnboardingFormRouteArgs {
  const ContinueOnboardingFormRouteArgs({this.key});

  final _i52.Key? key;

  @override
  String toString() {
    return 'ContinueOnboardingFormRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.OnboardingFormDoneScreen]
class OnboardingFormDoneRoute
    extends _i12.PageRouteInfo<OnboardingFormDoneRouteArgs> {
  OnboardingFormDoneRoute({_i52.Key? key})
      : super(OnboardingFormDoneRoute.name,
            path: 'onboarding-form-done',
            args: OnboardingFormDoneRouteArgs(key: key));

  static const String name = 'OnboardingFormDoneRoute';
}

class OnboardingFormDoneRouteArgs {
  const OnboardingFormDoneRouteArgs({this.key});

  final _i52.Key? key;

  @override
  String toString() {
    return 'OnboardingFormDoneRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i21.OnboardingGenderScreen]
class OnboardingGenderRoute extends _i12.PageRouteInfo<void> {
  const OnboardingGenderRoute()
      : super(OnboardingGenderRoute.name, path: 'gender');

  static const String name = 'OnboardingGenderRoute';
}

/// generated route for
/// [_i22.OnBoardingBirthdateScreen]
class OnBoardingBirthdateRoute
    extends _i12.PageRouteInfo<OnBoardingBirthdateRouteArgs> {
  OnBoardingBirthdateRoute({_i52.Key? key, required _i56.Sex sex})
      : super(OnBoardingBirthdateRoute.name,
            path: 'birthdate',
            args: OnBoardingBirthdateRouteArgs(key: key, sex: sex));

  static const String name = 'OnBoardingBirthdateRoute';
}

class OnBoardingBirthdateRouteArgs {
  const OnBoardingBirthdateRouteArgs({this.key, required this.sex});

  final _i52.Key? key;

  final _i56.Sex sex;

  @override
  String toString() {
    return 'OnBoardingBirthdateRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i23.OnboardingGeneralPracticionerScreen]
class OnboardingGeneralPracticionerRoute
    extends _i12.PageRouteInfo<OnboardingGeneralPracticionerRouteArgs> {
  OnboardingGeneralPracticionerRoute({_i52.Key? key, required _i56.Sex sex})
      : super(OnboardingGeneralPracticionerRoute.name,
            path: 'doctor/general-practicioner',
            args: OnboardingGeneralPracticionerRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGeneralPracticionerRoute';
}

class OnboardingGeneralPracticionerRouteArgs {
  const OnboardingGeneralPracticionerRouteArgs({this.key, required this.sex});

  final _i52.Key? key;

  final _i56.Sex sex;

  @override
  String toString() {
    return 'OnboardingGeneralPracticionerRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i24.GeneralPracticionerAchievementScreen]
class GeneralPracticionerAchievementRoute extends _i12.PageRouteInfo<void> {
  const GeneralPracticionerAchievementRoute()
      : super(GeneralPracticionerAchievementRoute.name,
            path: 'general-practicioner-achievement');

  static const String name = 'GeneralPracticionerAchievementRoute';
}

/// generated route for
/// [_i25.GeneralPractitionerDateScreen]
class GeneralPractitionerDateRoute extends _i12.PageRouteInfo<void> {
  const GeneralPractitionerDateRoute()
      : super(GeneralPractitionerDateRoute.name,
            path: 'doctor/general-practitioner-date');

  static const String name = 'GeneralPractitionerDateRoute';
}

/// generated route for
/// [_i26.OnboardingGynecologyScreen]
class OnboardingGynecologyRoute
    extends _i12.PageRouteInfo<OnboardingGynecologyRouteArgs> {
  OnboardingGynecologyRoute({_i52.Key? key, required _i56.Sex sex})
      : super(OnboardingGynecologyRoute.name,
            path: 'doctor/gynecology',
            args: OnboardingGynecologyRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGynecologyRoute';
}

class OnboardingGynecologyRouteArgs {
  const OnboardingGynecologyRouteArgs({this.key, required this.sex});

  final _i52.Key? key;

  final _i56.Sex sex;

  @override
  String toString() {
    return 'OnboardingGynecologyRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i27.GynecologyAchievementScreen]
class GynecologyAchievementRoute extends _i12.PageRouteInfo<void> {
  const GynecologyAchievementRoute()
      : super(GynecologyAchievementRoute.name, path: 'gynecology-achievement');

  static const String name = 'GynecologyAchievementRoute';
}

/// generated route for
/// [_i28.GynecologyDateScreen]
class GynecologyDateRoute extends _i12.PageRouteInfo<void> {
  const GynecologyDateRoute()
      : super(GynecologyDateRoute.name, path: 'doctor/gynecology-date');

  static const String name = 'GynecologyDateRoute';
}

/// generated route for
/// [_i29.OnboardingDentistScreen]
class OnboardingDentistRoute
    extends _i12.PageRouteInfo<OnboardingDentistRouteArgs> {
  OnboardingDentistRoute({_i52.Key? key, required _i56.Sex sex})
      : super(OnboardingDentistRoute.name,
            path: 'doctor/dentist',
            args: OnboardingDentistRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingDentistRoute';
}

class OnboardingDentistRouteArgs {
  const OnboardingDentistRouteArgs({this.key, required this.sex});

  final _i52.Key? key;

  final _i56.Sex sex;

  @override
  String toString() {
    return 'OnboardingDentistRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i30.DentistAchievementScreen]
class DentistAchievementRoute extends _i12.PageRouteInfo<void> {
  const DentistAchievementRoute()
      : super(DentistAchievementRoute.name, path: 'dentist-achievement');

  static const String name = 'DentistAchievementRoute';
}

/// generated route for
/// [_i31.DentistDateScreen]
class DentistDateRoute extends _i12.PageRouteInfo<void> {
  const DentistDateRoute()
      : super(DentistDateRoute.name, path: 'doctor/dentist-date');

  static const String name = 'DentistDateRoute';
}

/// generated route for
/// [_i32.MainScreen]
class MainRoute extends _i12.PageRouteInfo<MainRouteArgs> {
  MainRoute({_i52.Key? key, int selectedIndex = 0})
      : super(MainRoute.name,
            path: '',
            args: MainRouteArgs(key: key, selectedIndex: selectedIndex));

  static const String name = 'MainRoute';
}

class MainRouteArgs {
  const MainRouteArgs({this.key, this.selectedIndex = 0});

  final _i52.Key? key;

  final int selectedIndex;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key, selectedIndex: $selectedIndex}';
  }
}

/// generated route for
/// [_i33.EditNicknameScreen]
class EditNicknameRoute extends _i12.PageRouteInfo<EditNicknameRouteArgs> {
  EditNicknameRoute({_i52.Key? key, required _i57.User? user})
      : super(EditNicknameRoute.name,
            path: 'settings/update-profile/nickname',
            args: EditNicknameRouteArgs(key: key, user: user));

  static const String name = 'EditNicknameRoute';
}

class EditNicknameRouteArgs {
  const EditNicknameRouteArgs({this.key, required this.user});

  final _i52.Key? key;

  final _i57.User? user;

  @override
  String toString() {
    return 'EditNicknameRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i34.EditEmailScreen]
class EditEmailRoute extends _i12.PageRouteInfo<EditEmailRouteArgs> {
  EditEmailRoute({_i52.Key? key, required _i57.User? user})
      : super(EditEmailRoute.name,
            path: 'settings/update-profile/email',
            args: EditEmailRouteArgs(key: key, user: user));

  static const String name = 'EditEmailRoute';
}

class EditEmailRouteArgs {
  const EditEmailRouteArgs({this.key, required this.user});

  final _i52.Key? key;

  final _i57.User? user;

  @override
  String toString() {
    return 'EditEmailRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i35.EditPhotoScreen]
class EditPhotoRoute extends _i12.PageRouteInfo<EditPhotoRouteArgs> {
  EditPhotoRoute(
      {_i52.Key? key,
      _i58.Uint8List? imageBytes,
      required dynamic Function(_i59.SettingsPage) changePage})
      : super(EditPhotoRoute.name,
            path: 'settings/update-profile/photo',
            args: EditPhotoRouteArgs(
                key: key, imageBytes: imageBytes, changePage: changePage));

  static const String name = 'EditPhotoRoute';
}

class EditPhotoRouteArgs {
  const EditPhotoRouteArgs(
      {this.key, this.imageBytes, required this.changePage});

  final _i52.Key? key;

  final _i58.Uint8List? imageBytes;

  final dynamic Function(_i59.SettingsPage) changePage;

  @override
  String toString() {
    return 'EditPhotoRouteArgs{key: $key, imageBytes: $imageBytes, changePage: $changePage}';
  }
}

/// generated route for
/// [_i36.DeleteAccountScreen]
class DeleteAccountRoute extends _i12.PageRouteInfo<void> {
  const DeleteAccountRoute()
      : super(DeleteAccountRoute.name, path: 'settings/update-profile/delete');

  static const String name = 'DeleteAccountRoute';
}

/// generated route for
/// [_i37.AfterDeletionScreen]
class AfterDeletionRoute extends _i12.PageRouteInfo<AfterDeletionRouteArgs> {
  AfterDeletionRoute({_i52.Key? key, required _i56.Sex sex})
      : super(AfterDeletionRoute.name,
            path: 'settings/update-profile/delete/after-deletion',
            args: AfterDeletionRouteArgs(key: key, sex: sex));

  static const String name = 'AfterDeletionRoute';
}

class AfterDeletionRouteArgs {
  const AfterDeletionRouteArgs({this.key, required this.sex});

  final _i52.Key? key;

  final _i56.Sex sex;

  @override
  String toString() {
    return 'AfterDeletionRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i38.CameraPhotoTakenScreen]
class CameraPhotoTakenRoute
    extends _i12.PageRouteInfo<CameraPhotoTakenRouteArgs> {
  CameraPhotoTakenRoute({_i52.Key? key, required _i58.Uint8List imageBytes})
      : super(CameraPhotoTakenRoute.name,
            path: 'settings/update-profile/photo/camera-taken',
            args: CameraPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'CameraPhotoTakenRoute';
}

class CameraPhotoTakenRouteArgs {
  const CameraPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i52.Key? key;

  final _i58.Uint8List imageBytes;

  @override
  String toString() {
    return 'CameraPhotoTakenRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i39.GalleryPhotoTakenScreen]
class GalleryPhotoTakenRoute
    extends _i12.PageRouteInfo<GalleryPhotoTakenRouteArgs> {
  GalleryPhotoTakenRoute({_i52.Key? key, required _i58.Uint8List imageBytes})
      : super(GalleryPhotoTakenRoute.name,
            path: 'settings/update-profile/photo/gallery-taken',
            args: GalleryPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'GalleryPhotoTakenRoute';
}

class GalleryPhotoTakenRouteArgs {
  const GalleryPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i52.Key? key;

  final _i58.Uint8List imageBytes;

  @override
  String toString() {
    return 'GalleryPhotoTakenRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i40.PhotoCroppedResultScreen]
class PhotoCroppedResultRoute
    extends _i12.PageRouteInfo<PhotoCroppedResultRouteArgs> {
  PhotoCroppedResultRoute({_i52.Key? key, required _i58.Uint8List imageBytes})
      : super(PhotoCroppedResultRoute.name,
            path: 'settings/update-profile/photo/photo-cropped-result',
            args:
                PhotoCroppedResultRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'PhotoCroppedResultRoute';
}

class PhotoCroppedResultRouteArgs {
  const PhotoCroppedResultRouteArgs({this.key, required this.imageBytes});

  final _i52.Key? key;

  final _i58.Uint8List imageBytes;

  @override
  String toString() {
    return 'PhotoCroppedResultRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i41.ExaminationDetailScreen]
class ExaminationDetailRoute
    extends _i12.PageRouteInfo<ExaminationDetailRouteArgs> {
  ExaminationDetailRoute(
      {_i52.Key? key,
      required _i60.CategorizedExamination categorizedExamination})
      : super(ExaminationDetailRoute.name,
            path: 'prevention-detail',
            args: ExaminationDetailRouteArgs(
                key: key, categorizedExamination: categorizedExamination));

  static const String name = 'ExaminationDetailRoute';
}

class ExaminationDetailRouteArgs {
  const ExaminationDetailRouteArgs(
      {this.key, required this.categorizedExamination});

  final _i52.Key? key;

  final _i60.CategorizedExamination categorizedExamination;

  @override
  String toString() {
    return 'ExaminationDetailRouteArgs{key: $key, categorizedExamination: $categorizedExamination}';
  }
}

/// generated route for
/// [_i42.AchievementScreen]
class AchievementRoute extends _i12.PageRouteInfo<AchievementRouteArgs> {
  AchievementRoute(
      {_i52.Key? key,
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

  final _i52.Key? key;

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
/// [_i43.DatePickerScreen]
class DatePickerRoute extends _i12.PageRouteInfo<DatePickerRouteArgs> {
  DatePickerRoute(
      {_i52.Key? key,
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

  final _i52.Key? key;

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
/// [_i44.CalendarPermissionInfoScreen]
class CalendarPermissionInfoRoute
    extends _i12.PageRouteInfo<CalendarPermissionInfoRouteArgs> {
  CalendarPermissionInfoRoute(
      {_i52.Key? key,
      required _i56.ExaminationPreventionStatus examinationRecord})
      : super(CalendarPermissionInfoRoute.name,
            path: 'calendar/permission',
            args: CalendarPermissionInfoRouteArgs(
                key: key, examinationRecord: examinationRecord));

  static const String name = 'CalendarPermissionInfoRoute';
}

class CalendarPermissionInfoRouteArgs {
  const CalendarPermissionInfoRouteArgs(
      {this.key, required this.examinationRecord});

  final _i52.Key? key;

  final _i56.ExaminationPreventionStatus examinationRecord;

  @override
  String toString() {
    return 'CalendarPermissionInfoRouteArgs{key: $key, examinationRecord: $examinationRecord}';
  }
}

/// generated route for
/// [_i45.CalendarListScreen]
class CalendarListRoute extends _i12.PageRouteInfo<CalendarListRouteArgs> {
  CalendarListRoute(
      {_i52.Key? key,
      required _i56.ExaminationPreventionStatus examinationRecord})
      : super(CalendarListRoute.name,
            path: 'calendar/list',
            args: CalendarListRouteArgs(
                key: key, examinationRecord: examinationRecord));

  static const String name = 'CalendarListRoute';
}

class CalendarListRouteArgs {
  const CalendarListRouteArgs({this.key, required this.examinationRecord});

  final _i52.Key? key;

  final _i56.ExaminationPreventionStatus examinationRecord;

  @override
  String toString() {
    return 'CalendarListRouteArgs{key: $key, examinationRecord: $examinationRecord}';
  }
}

/// generated route for
/// [_i46.ChangeLastVisitScreen]
class ChangeLastVisitRoute
    extends _i12.PageRouteInfo<ChangeLastVisitRouteArgs> {
  ChangeLastVisitRoute(
      {_i52.Key? key,
      required DateTime originalDate,
      required String title,
      required _i56.ExaminationType examinationType,
      required String? uuid,
      required _i61.ExaminationCategory status})
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

  final _i52.Key? key;

  final DateTime originalDate;

  final String title;

  final _i56.ExaminationType examinationType;

  final String? uuid;

  final _i61.ExaminationCategory status;

  @override
  String toString() {
    return 'ChangeLastVisitRouteArgs{key: $key, originalDate: $originalDate, title: $title, examinationType: $examinationType, uuid: $uuid, status: $status}';
  }
}

/// generated route for
/// [_i47.SelfExaminationDetailScreen]
class SelfExaminationDetailRoute
    extends _i12.PageRouteInfo<SelfExaminationDetailRouteArgs> {
  SelfExaminationDetailRoute(
      {_i52.Key? key,
      required _i56.Sex sex,
      required _i56.SelfExaminationPreventionStatus selfExamination})
      : super(SelfExaminationDetailRoute.name,
            path: 'self-examination/detail',
            args: SelfExaminationDetailRouteArgs(
                key: key, sex: sex, selfExamination: selfExamination));

  static const String name = 'SelfExaminationDetailRoute';
}

class SelfExaminationDetailRouteArgs {
  const SelfExaminationDetailRouteArgs(
      {this.key, required this.sex, required this.selfExamination});

  final _i52.Key? key;

  final _i56.Sex sex;

  final _i56.SelfExaminationPreventionStatus selfExamination;

  @override
  String toString() {
    return 'SelfExaminationDetailRouteArgs{key: $key, sex: $sex, selfExamination: $selfExamination}';
  }
}

/// generated route for
/// [_i48.EducationalVideoScreen]
class EducationalVideoRoute
    extends _i12.PageRouteInfo<EducationalVideoRouteArgs> {
  EducationalVideoRoute(
      {_i52.Key? key,
      required _i56.Sex sex,
      required _i56.SelfExaminationPreventionStatus selfExamination})
      : super(EducationalVideoRoute.name,
            path: 'self-examination/detail/educational-video',
            args: EducationalVideoRouteArgs(
                key: key, sex: sex, selfExamination: selfExamination));

  static const String name = 'EducationalVideoRoute';
}

class EducationalVideoRouteArgs {
  const EducationalVideoRouteArgs(
      {this.key, required this.sex, required this.selfExamination});

  final _i52.Key? key;

  final _i56.Sex sex;

  final _i56.SelfExaminationPreventionStatus selfExamination;

  @override
  String toString() {
    return 'EducationalVideoRouteArgs{key: $key, sex: $sex, selfExamination: $selfExamination}';
  }
}

/// generated route for
/// [_i49.HasFindingScreen]
class HasFindingRoute extends _i12.PageRouteInfo<HasFindingRouteArgs> {
  HasFindingRoute({_i52.Key? key, required _i56.Sex sex})
      : super(HasFindingRoute.name,
            path: 'self-examination/detail/has-finding',
            args: HasFindingRouteArgs(key: key, sex: sex));

  static const String name = 'HasFindingRoute';
}

class HasFindingRouteArgs {
  const HasFindingRouteArgs({this.key, required this.sex});

  final _i52.Key? key;

  final _i56.Sex sex;

  @override
  String toString() {
    return 'HasFindingRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i50.NoFindingScreen]
class NoFindingRoute extends _i12.PageRouteInfo<NoFindingRouteArgs> {
  NoFindingRoute({_i52.Key? key, required int points})
      : super(NoFindingRoute.name,
            path: 'self-examination/detail/no-finding',
            args: NoFindingRouteArgs(key: key, points: points));

  static const String name = 'NoFindingRoute';
}

class NoFindingRouteArgs {
  const NoFindingRouteArgs({this.key, required this.points});

  final _i52.Key? key;

  final int points;

  @override
  String toString() {
    return 'NoFindingRouteArgs{key: $key, points: $points}';
  }
}

/// generated route for
/// [_i51.ProgressRewardScreen]
class ProgressRewardRoute extends _i12.PageRouteInfo<void> {
  const ProgressRewardRoute()
      : super(ProgressRewardRoute.name,
            path: 'self-examination/detail/progress-reward');

  static const String name = 'ProgressRewardRoute';
}
