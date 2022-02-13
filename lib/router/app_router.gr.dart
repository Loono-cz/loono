// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'dart:typed_data' as _i59;

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:loono_api/loono_api.dart' as _i57;

import '../helpers/examination_category.dart' as _i61;
import '../models/categorized_examination.dart' as _i60;
import '../models/firebase_user.dart' as _i56;
import '../services/db/database.dart' as _i58;
import '../ui/screens/about_health/about_health.dart' as _i18;
import '../ui/screens/dentist_achievement.dart' as _i32;
import '../ui/screens/find_doctor/find_doctor.dart' as _i17;
import '../ui/screens/general_practicioner_achievement.dart' as _i25;
import '../ui/screens/gynecology_achievement.dart' as _i29;
import '../ui/screens/logout.dart' as _i13;
import '../ui/screens/main/main_screen.dart' as _i34;
import '../ui/screens/main/pre_auth/continue_onboarding_form.dart' as _i20;
import '../ui/screens/main/pre_auth/login.dart' as _i12;
import '../ui/screens/main/pre_auth/onboarding_form_done.dart' as _i21;
import '../ui/screens/main/pre_auth/pre_auth_main_screen.dart' as _i5;
import '../ui/screens/main/pre_auth/start_new_questionnaire.dart' as _i19;
import '../ui/screens/onboarding/allow_notifications.dart' as _i27;
import '../ui/screens/onboarding/birthdate.dart' as _i23;
import '../ui/screens/onboarding/carousel/carousel.dart' as _i6;
import '../ui/screens/onboarding/doctors/dentist.dart' as _i31;
import '../ui/screens/onboarding/doctors/dentist_date.dart' as _i33;
import '../ui/screens/onboarding/doctors/general_practicioner.dart' as _i24;
import '../ui/screens/onboarding/doctors/general_practitioner_date.dart'
    as _i26;
import '../ui/screens/onboarding/doctors/gynecology.dart' as _i28;
import '../ui/screens/onboarding/doctors/gynecology_date.dart' as _i30;
import '../ui/screens/onboarding/fallback_account/email.dart' as _i11;
import '../ui/screens/onboarding/fallback_account/nickname.dart' as _i10;
import '../ui/screens/onboarding/fill_form_later.dart' as _i8;
import '../ui/screens/onboarding/gamification_introduction.dart' as _i9;
import '../ui/screens/onboarding/gender.dart' as _i22;
import '../ui/screens/prevention/calendar/calendar_list.dart' as _i50;
import '../ui/screens/prevention/calendar/permission_info.dart' as _i49;
import '../ui/screens/prevention/examination_detail/change_date_screen.dart'
    as _i54;
import '../ui/screens/prevention/examination_detail/change_last_visit_screen.dart'
    as _i51;
import '../ui/screens/prevention/examination_detail/change_time_screen.dart'
    as _i55;
import '../ui/screens/prevention/examination_detail/examination_screen.dart'
    as _i46;
import '../ui/screens/prevention/examination_detail/new_date_screen.dart'
    as _i52;
import '../ui/screens/prevention/examination_detail/new_time_screen.dart'
    as _i53;
import '../ui/screens/prevention/questionnaire/date_picker_screen.dart' as _i48;
import '../ui/screens/settings/camera_photo_taken.dart' as _i41;
import '../ui/screens/settings/delete_account.dart' as _i40;
import '../ui/screens/settings/edit_email.dart' as _i38;
import '../ui/screens/settings/edit_nickname.dart' as _i37;
import '../ui/screens/settings/edit_photo.dart' as _i39;
import '../ui/screens/settings/gallery_photo_taken.dart' as _i42;
import '../ui/screens/settings/leaderboard.dart' as _i44;
import '../ui/screens/settings/open_settings.dart' as _i35;
import '../ui/screens/settings/photo_cropped_result.dart' as _i43;
import '../ui/screens/settings/points_help.dart' as _i45;
import '../ui/screens/settings/update_profile.dart' as _i36;
import '../ui/screens/splash_screen.dart' as _i14;
import '../ui/screens/welcome.dart' as _i15;
import '../ui/widgets/achievement_screen.dart' as _i47;
import 'guards/check_is_logged_in.dart' as _i3;
import 'sub_routers/app_startup_wrapper_screen.dart' as _i4;
import 'sub_routers/onboarding_wrapper_screen.dart' as _i7;
import 'sub_routers/pre_auth_prevention_wrapper_screen.dart' as _i16;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i2.GlobalKey<_i2.NavigatorState>? navigatorKey,
      required this.checkIsLoggedIn})
      : super(navigatorKey);

  final _i3.CheckIsLoggedIn checkIsLoggedIn;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    AppStartUpWrapperRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData, child: const _i4.AppStartUpWrapperScreen());
    },
    PreAuthMainRoute.name: (routeData) {
      final args = routeData.argsAs<PreAuthMainRouteArgs>(
          orElse: () => const PreAuthMainRouteArgs());
      return _i1.MaterialPageX<void>(
          routeData: routeData,
          child: _i5.PreAuthMainScreen(
              key: args.key,
              overridenPreventionRoute: args.overridenPreventionRoute));
    },
    IntroCarouselRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData, child: const _i6.IntroCarouselScreen());
    },
    OnboardingWrapperRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData, child: const _i7.OnboardingWrapperScreen());
    },
    FillOnboardingFormLaterRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData,
          child: const _i8.FillOnboardingFormLaterScreen());
    },
    GamificationIntroductionRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData,
          child: const _i9.GamificationIntroductionScreen());
    },
    NicknameRoute.name: (routeData) {
      final args = routeData.argsAs<NicknameRouteArgs>(
          orElse: () => const NicknameRouteArgs());
      return _i1.MaterialPageX<void>(
          routeData: routeData,
          child: _i10.NicknameScreen(key: args.key, authUser: args.authUser));
    },
    EmailRoute.name: (routeData) {
      final args = routeData.argsAs<EmailRouteArgs>(
          orElse: () => const EmailRouteArgs());
      return _i1.MaterialPageX<void>(
          routeData: routeData,
          child: _i11.EmailScreen(key: args.key, authUser: args.authUser));
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i1.MaterialPageX<void>(
          routeData: routeData, child: _i12.LoginScreen(key: args.key));
    },
    LogoutRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData, child: const _i13.LogoutScreen());
    },
    MainScreenRouter.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData, child: const _i1.EmptyRouterScreen());
    },
    SplashRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData, child: const _i14.SplashScreen());
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i1.MaterialPageX<void>(
          routeData: routeData, child: _i15.WelcomeScreen(key: args.key));
    },
    PreAuthPreventionWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<PreAuthPreventionWrapperRouteArgs>(
          orElse: () => const PreAuthPreventionWrapperRouteArgs());
      return _i1.MaterialPageX<void>(
          routeData: routeData,
          child: _i16.PreAuthPreventionWrapperScreen(
              key: args.key, forceRoute: args.forceRoute));
    },
    FindDoctorRoute.name: (routeData) {
      final args = routeData.argsAs<FindDoctorRouteArgs>(
          orElse: () => const FindDoctorRouteArgs());
      return _i1.MaterialPageX<void>(
          routeData: routeData,
          child: _i17.FindDoctorScreen(
              key: args.key, cancelRouteName: args.cancelRouteName));
    },
    AboutHealthRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData, child: const _i18.AboutHealthScreen());
    },
    StartNewQuestionnaireRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData,
          child: const _i19.StartNewQuestionnaireScreen());
    },
    ContinueOnboardingFormRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData,
          child: const _i20.ContinueOnboardingFormScreen());
    },
    OnboardingFormDoneRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingFormDoneRouteArgs>(
          orElse: () => const OnboardingFormDoneRouteArgs());
      return _i1.MaterialPageX<void>(
          routeData: routeData,
          child: _i21.OnboardingFormDoneScreen(key: args.key));
    },
    OnboardingGenderRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i22.OnboardingGenderScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnBoardingBirthdateRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingBirthdateRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i23.OnBoardingBirthdateScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGeneralPracticionerRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGeneralPracticionerRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i24.OnboardingGeneralPracticionerScreen(
              key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPracticionerAchievementRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i25.GeneralPracticionerAchievementScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPractitionerDateRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i26.GeneralPractitionerDateScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AllowNotificationsRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i27.AllowNotificationsScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGynecologyRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGynecologyRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i28.OnboardingGynecologyScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyAchievementRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i29.GynecologyAchievementScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyDateRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i30.GynecologyDateScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingDentistRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingDentistRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i31.OnboardingDentistScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistAchievementRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i32.DentistAchievementScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistDateRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i33.DentistDateScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    MainRoute.name: (routeData) {
      return _i1.MaterialPageX<void>(
          routeData: routeData, child: const _i34.MainScreen());
    },
    OpenSettingsRoute.name: (routeData) {
      final args = routeData.argsAs<OpenSettingsRouteArgs>(
          orElse: () => const OpenSettingsRouteArgs());
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i35.OpenSettingsScreen(key: args.key),
          transitionsBuilder: _i1.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    UpdateProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateProfileRouteArgs>(
          orElse: () => const UpdateProfileRouteArgs());
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i36.UpdateProfileScreen(key: args.key),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditNicknameRoute.name: (routeData) {
      final args = routeData.argsAs<EditNicknameRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i37.EditNicknameScreen(key: args.key, user: args.user),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditEmailRoute.name: (routeData) {
      final args = routeData.argsAs<EditEmailRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i38.EditEmailScreen(key: args.key, user: args.user),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditPhotoRoute.name: (routeData) {
      final args = routeData.argsAs<EditPhotoRouteArgs>(
          orElse: () => const EditPhotoRouteArgs());
      return _i1.CustomPage<void>(
          routeData: routeData,
          child:
              _i39.EditPhotoScreen(key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DeleteAccountRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i40.DeleteAccountScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CameraPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<CameraPhotoTakenRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i41.CameraPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GalleryPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<GalleryPhotoTakenRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i42.GalleryPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    PhotoCroppedResultRoute.name: (routeData) {
      final args = routeData.argsAs<PhotoCroppedResultRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i43.PhotoCroppedResultScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    LeaderboardRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i44.LeaderboardScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    PointsHelpRoute.name: (routeData) {
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: const _i45.PointsHelpScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ExaminationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ExaminationDetailRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i46.ExaminationDetailScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AchievementRoute.name: (routeData) {
      final args = routeData.argsAs<AchievementRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i47.AchievementScreen(
              key: args.key,
              header: args.header,
              textLines: args.textLines,
              numberOfPoints: args.numberOfPoints,
              itemPath: args.itemPath,
              onButtonTap: args.onButtonTap),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DatePickerRoute.name: (routeData) {
      final args = routeData.argsAs<DatePickerRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i48.DatePickerScreen(
              key: args.key,
              assetPath: args.assetPath,
              title: args.title,
              onContinueButtonPress: args.onContinueButtonPress,
              onSkipButtonPress: args.onSkipButtonPress),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CalendarPermissionInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarPermissionInfoRouteArgs>();
      return _i1.CustomPage<bool>(
          routeData: routeData,
          child: _i49.CalendarPermissionInfoScreen(
              key: args.key, examinationRecord: args.examinationRecord),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CalendarListRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarListRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i50.CalendarListScreen(
              key: args.key, examinationRecord: args.examinationRecord),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ChangeLastVisitRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeLastVisitRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i51.ChangeLastVisitScreen(
              key: args.key,
              originalDate: args.originalDate,
              title: args.title,
              examinationType: args.examinationType,
              uuid: args.uuid,
              status: args.status),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    NewDateRoute.name: (routeData) {
      final args = routeData.argsAs<NewDateRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i52.NewDateScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination,
              showCancelIcon: args.showCancelIcon),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    NewTimeRoute.name: (routeData) {
      final args = routeData.argsAs<NewTimeRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i53.NewTimeScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination,
              newDate: args.newDate),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ChangeDateRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeDateRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i54.ChangeDateScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ChangeTimeRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeTimeRouteArgs>();
      return _i1.CustomPage<void>(
          routeData: routeData,
          child: _i55.ChangeTimeScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination,
              newDate: args.newDate,
              uuid: args.uuid),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: 'main', fullMatch: true),
        _i1.RouteConfig(AppStartUpWrapperRoute.name,
            path: 'app-start-up',
            children: [
              _i1.RouteConfig(SplashRoute.name, path: 'splash-screen'),
              _i1.RouteConfig(WelcomeRoute.name, path: 'welcome'),
              _i1.RouteConfig(PreAuthMainRoute.name,
                  path: 'pre-auth-main',
                  children: [
                    _i1.RouteConfig(PreAuthPreventionWrapperRoute.name,
                        path: 'pre-auth-prevention',
                        children: [
                          _i1.RouteConfig(LoginRoute.name, path: 'login'),
                          _i1.RouteConfig(StartNewQuestionnaireRoute.name,
                              path: 'start-new-questionnaire'),
                          _i1.RouteConfig(ContinueOnboardingFormRoute.name,
                              path: 'continue-onboarding-form'),
                          _i1.RouteConfig(OnboardingFormDoneRoute.name,
                              path: 'onboarding-form-done')
                        ]),
                    _i1.RouteConfig(FindDoctorRoute.name, path: 'find-doctor'),
                    _i1.RouteConfig(AboutHealthRoute.name, path: 'about-health')
                  ])
            ]),
        _i1.RouteConfig(PreAuthMainRoute.name,
            path: 'pre-auth-main',
            children: [
              _i1.RouteConfig(PreAuthPreventionWrapperRoute.name,
                  path: 'pre-auth-prevention',
                  children: [
                    _i1.RouteConfig(LoginRoute.name, path: 'login'),
                    _i1.RouteConfig(StartNewQuestionnaireRoute.name,
                        path: 'start-new-questionnaire'),
                    _i1.RouteConfig(ContinueOnboardingFormRoute.name,
                        path: 'continue-onboarding-form'),
                    _i1.RouteConfig(OnboardingFormDoneRoute.name,
                        path: 'onboarding-form-done')
                  ]),
              _i1.RouteConfig(FindDoctorRoute.name, path: 'find-doctor'),
              _i1.RouteConfig(AboutHealthRoute.name, path: 'about-health')
            ]),
        _i1.RouteConfig(IntroCarouselRoute.name, path: 'intro-carousel'),
        _i1.RouteConfig(OnboardingWrapperRoute.name,
            path: 'onboarding',
            children: [
              _i1.RouteConfig(OnboardingGenderRoute.name, path: 'gender'),
              _i1.RouteConfig(OnBoardingBirthdateRoute.name, path: 'birthdate'),
              _i1.RouteConfig(OnboardingGeneralPracticionerRoute.name,
                  path: 'doctor/general-practicioner'),
              _i1.RouteConfig(GeneralPracticionerAchievementRoute.name,
                  path: 'general-practicioner-achievement'),
              _i1.RouteConfig(GeneralPractitionerDateRoute.name,
                  path: 'doctor/general-practitioner-date'),
              _i1.RouteConfig(AllowNotificationsRoute.name,
                  path: 'allow-notifications'),
              _i1.RouteConfig(OnboardingGynecologyRoute.name,
                  path: 'doctor/gynecology'),
              _i1.RouteConfig(GynecologyAchievementRoute.name,
                  path: 'gynecology-achievement'),
              _i1.RouteConfig(GynecologyDateRoute.name,
                  path: 'doctor/gynecology-date'),
              _i1.RouteConfig(OnboardingDentistRoute.name,
                  path: 'doctor/dentist'),
              _i1.RouteConfig(DentistAchievementRoute.name,
                  path: 'dentist-achievement'),
              _i1.RouteConfig(DentistDateRoute.name,
                  path: 'doctor/dentist-date')
            ]),
        _i1.RouteConfig(FillOnboardingFormLaterRoute.name,
            path: 'fill-form-later'),
        _i1.RouteConfig(GamificationIntroductionRoute.name,
            path: 'gamification-introduction'),
        _i1.RouteConfig(NicknameRoute.name, path: 'fallback-account/name'),
        _i1.RouteConfig(EmailRoute.name, path: 'fallback-account/email'),
        _i1.RouteConfig(LoginRoute.name, path: 'login'),
        _i1.RouteConfig(LogoutRoute.name, path: 'logout'),
        _i1.RouteConfig(MainScreenRouter.name, path: 'main', guards: [
          checkIsLoggedIn
        ], children: [
          _i1.RouteConfig(MainRoute.name, path: ''),
          _i1.RouteConfig(OpenSettingsRoute.name, path: 'settings'),
          _i1.RouteConfig(UpdateProfileRoute.name,
              path: 'settings/update-profile'),
          _i1.RouteConfig(EditNicknameRoute.name,
              path: 'settings/update-profile/nickname'),
          _i1.RouteConfig(EditEmailRoute.name,
              path: 'settings/update-profile/email'),
          _i1.RouteConfig(EditPhotoRoute.name,
              path: 'settings/update-profile/photo'),
          _i1.RouteConfig(DeleteAccountRoute.name,
              path: 'settings/update-profile/delete'),
          _i1.RouteConfig(CameraPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/camera-taken'),
          _i1.RouteConfig(GalleryPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/gallery-taken'),
          _i1.RouteConfig(PhotoCroppedResultRoute.name,
              path: 'settings/update-profile/photo/photo-cropped-result'),
          _i1.RouteConfig(LeaderboardRoute.name, path: 'settings/leaderboard'),
          _i1.RouteConfig(PointsHelpRoute.name, path: 'settings/points-help'),
          _i1.RouteConfig(ExaminationDetailRoute.name,
              path: 'prevention-detail'),
          _i1.RouteConfig(AchievementRoute.name, path: 'questionnaire/reward'),
          _i1.RouteConfig(DatePickerRoute.name,
              path: 'questionnaire/date-picker'),
          _i1.RouteConfig(CalendarPermissionInfoRoute.name,
              path: 'calendar/permission'),
          _i1.RouteConfig(CalendarListRoute.name, path: 'calendar/list'),
          _i1.RouteConfig(ChangeLastVisitRoute.name,
              path: 'checkup/last-visit-update'),
          _i1.RouteConfig(NewDateRoute.name, path: 'checkup/set-date'),
          _i1.RouteConfig(NewTimeRoute.name, path: 'checkup/set-time'),
          _i1.RouteConfig(ChangeDateRoute.name, path: 'checkup/change-date'),
          _i1.RouteConfig(ChangeTimeRoute.name, path: 'checkup/change-time'),
          _i1.RouteConfig(FindDoctorRoute.name, path: 'find-doctor')
        ])
      ];
}

class AppStartUpWrapperRoute extends _i1.PageRouteInfo<void> {
  const AppStartUpWrapperRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'app-start-up', initialChildren: children);

  static const String name = 'AppStartUpWrapperRoute';
}

class PreAuthMainRoute extends _i1.PageRouteInfo<PreAuthMainRouteArgs> {
  PreAuthMainRoute(
      {_i2.Key? key,
      _i1.PageRouteInfo<dynamic>? overridenPreventionRoute,
      List<_i1.PageRouteInfo>? children})
      : super(name,
            path: 'pre-auth-main',
            args: PreAuthMainRouteArgs(
                key: key, overridenPreventionRoute: overridenPreventionRoute),
            initialChildren: children);

  static const String name = 'PreAuthMainRoute';
}

class PreAuthMainRouteArgs {
  const PreAuthMainRouteArgs({this.key, this.overridenPreventionRoute});

  final _i2.Key? key;

  final _i1.PageRouteInfo<dynamic>? overridenPreventionRoute;
}

class IntroCarouselRoute extends _i1.PageRouteInfo<void> {
  const IntroCarouselRoute() : super(name, path: 'intro-carousel');

  static const String name = 'IntroCarouselRoute';
}

class OnboardingWrapperRoute extends _i1.PageRouteInfo<void> {
  const OnboardingWrapperRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'onboarding', initialChildren: children);

  static const String name = 'OnboardingWrapperRoute';
}

class FillOnboardingFormLaterRoute extends _i1.PageRouteInfo<void> {
  const FillOnboardingFormLaterRoute() : super(name, path: 'fill-form-later');

  static const String name = 'FillOnboardingFormLaterRoute';
}

class GamificationIntroductionRoute extends _i1.PageRouteInfo<void> {
  const GamificationIntroductionRoute()
      : super(name, path: 'gamification-introduction');

  static const String name = 'GamificationIntroductionRoute';
}

class NicknameRoute extends _i1.PageRouteInfo<NicknameRouteArgs> {
  NicknameRoute({_i2.Key? key, _i56.AuthUser? authUser})
      : super(name,
            path: 'fallback-account/name',
            args: NicknameRouteArgs(key: key, authUser: authUser));

  static const String name = 'NicknameRoute';
}

class NicknameRouteArgs {
  const NicknameRouteArgs({this.key, this.authUser});

  final _i2.Key? key;

  final _i56.AuthUser? authUser;
}

class EmailRoute extends _i1.PageRouteInfo<EmailRouteArgs> {
  EmailRoute({_i2.Key? key, _i56.AuthUser? authUser})
      : super(name,
            path: 'fallback-account/email',
            args: EmailRouteArgs(key: key, authUser: authUser));

  static const String name = 'EmailRoute';
}

class EmailRouteArgs {
  const EmailRouteArgs({this.key, this.authUser});

  final _i2.Key? key;

  final _i56.AuthUser? authUser;
}

class LoginRoute extends _i1.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i2.Key? key})
      : super(name, path: 'login', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i2.Key? key;
}

class LogoutRoute extends _i1.PageRouteInfo<void> {
  const LogoutRoute() : super(name, path: 'logout');

  static const String name = 'LogoutRoute';
}

class MainScreenRouter extends _i1.PageRouteInfo<void> {
  const MainScreenRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'main', initialChildren: children);

  static const String name = 'MainScreenRouter';
}

class SplashRoute extends _i1.PageRouteInfo<void> {
  const SplashRoute() : super(name, path: 'splash-screen');

  static const String name = 'SplashRoute';
}

class WelcomeRoute extends _i1.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({_i2.Key? key})
      : super(name, path: 'welcome', args: WelcomeRouteArgs(key: key));

  static const String name = 'WelcomeRoute';
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i2.Key? key;
}

class PreAuthPreventionWrapperRoute
    extends _i1.PageRouteInfo<PreAuthPreventionWrapperRouteArgs> {
  PreAuthPreventionWrapperRoute(
      {_i2.Key? key,
      _i1.PageRouteInfo<dynamic>? forceRoute,
      List<_i1.PageRouteInfo>? children})
      : super(name,
            path: 'pre-auth-prevention',
            args: PreAuthPreventionWrapperRouteArgs(
                key: key, forceRoute: forceRoute),
            initialChildren: children);

  static const String name = 'PreAuthPreventionWrapperRoute';
}

class PreAuthPreventionWrapperRouteArgs {
  const PreAuthPreventionWrapperRouteArgs({this.key, this.forceRoute});

  final _i2.Key? key;

  final _i1.PageRouteInfo<dynamic>? forceRoute;
}

class FindDoctorRoute extends _i1.PageRouteInfo<FindDoctorRouteArgs> {
  FindDoctorRoute({_i2.Key? key, _i1.PageRouteInfo<dynamic>? cancelRouteName})
      : super(name,
            path: 'find-doctor',
            args: FindDoctorRouteArgs(
                key: key, cancelRouteName: cancelRouteName));

  static const String name = 'FindDoctorRoute';
}

class FindDoctorRouteArgs {
  const FindDoctorRouteArgs({this.key, this.cancelRouteName});

  final _i2.Key? key;

  final _i1.PageRouteInfo<dynamic>? cancelRouteName;
}

class AboutHealthRoute extends _i1.PageRouteInfo<void> {
  const AboutHealthRoute() : super(name, path: 'about-health');

  static const String name = 'AboutHealthRoute';
}

class StartNewQuestionnaireRoute extends _i1.PageRouteInfo<void> {
  const StartNewQuestionnaireRoute()
      : super(name, path: 'start-new-questionnaire');

  static const String name = 'StartNewQuestionnaireRoute';
}

class ContinueOnboardingFormRoute extends _i1.PageRouteInfo<void> {
  const ContinueOnboardingFormRoute()
      : super(name, path: 'continue-onboarding-form');

  static const String name = 'ContinueOnboardingFormRoute';
}

class OnboardingFormDoneRoute
    extends _i1.PageRouteInfo<OnboardingFormDoneRouteArgs> {
  OnboardingFormDoneRoute({_i2.Key? key})
      : super(name,
            path: 'onboarding-form-done',
            args: OnboardingFormDoneRouteArgs(key: key));

  static const String name = 'OnboardingFormDoneRoute';
}

class OnboardingFormDoneRouteArgs {
  const OnboardingFormDoneRouteArgs({this.key});

  final _i2.Key? key;
}

class OnboardingGenderRoute extends _i1.PageRouteInfo<void> {
  const OnboardingGenderRoute() : super(name, path: 'gender');

  static const String name = 'OnboardingGenderRoute';
}

class OnBoardingBirthdateRoute
    extends _i1.PageRouteInfo<OnBoardingBirthdateRouteArgs> {
  OnBoardingBirthdateRoute({_i2.Key? key, required _i57.Sex sex})
      : super(name,
            path: 'birthdate',
            args: OnBoardingBirthdateRouteArgs(key: key, sex: sex));

  static const String name = 'OnBoardingBirthdateRoute';
}

class OnBoardingBirthdateRouteArgs {
  const OnBoardingBirthdateRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i57.Sex sex;
}

class OnboardingGeneralPracticionerRoute
    extends _i1.PageRouteInfo<OnboardingGeneralPracticionerRouteArgs> {
  OnboardingGeneralPracticionerRoute({_i2.Key? key, required _i57.Sex sex})
      : super(name,
            path: 'doctor/general-practicioner',
            args: OnboardingGeneralPracticionerRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGeneralPracticionerRoute';
}

class OnboardingGeneralPracticionerRouteArgs {
  const OnboardingGeneralPracticionerRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i57.Sex sex;
}

class GeneralPracticionerAchievementRoute extends _i1.PageRouteInfo<void> {
  const GeneralPracticionerAchievementRoute()
      : super(name, path: 'general-practicioner-achievement');

  static const String name = 'GeneralPracticionerAchievementRoute';
}

class GeneralPractitionerDateRoute extends _i1.PageRouteInfo<void> {
  const GeneralPractitionerDateRoute()
      : super(name, path: 'doctor/general-practitioner-date');

  static const String name = 'GeneralPractitionerDateRoute';
}

class AllowNotificationsRoute extends _i1.PageRouteInfo<void> {
  const AllowNotificationsRoute() : super(name, path: 'allow-notifications');

  static const String name = 'AllowNotificationsRoute';
}

class OnboardingGynecologyRoute
    extends _i1.PageRouteInfo<OnboardingGynecologyRouteArgs> {
  OnboardingGynecologyRoute({_i2.Key? key, required _i57.Sex sex})
      : super(name,
            path: 'doctor/gynecology',
            args: OnboardingGynecologyRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGynecologyRoute';
}

class OnboardingGynecologyRouteArgs {
  const OnboardingGynecologyRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i57.Sex sex;
}

class GynecologyAchievementRoute extends _i1.PageRouteInfo<void> {
  const GynecologyAchievementRoute()
      : super(name, path: 'gynecology-achievement');

  static const String name = 'GynecologyAchievementRoute';
}

class GynecologyDateRoute extends _i1.PageRouteInfo<void> {
  const GynecologyDateRoute() : super(name, path: 'doctor/gynecology-date');

  static const String name = 'GynecologyDateRoute';
}

class OnboardingDentistRoute
    extends _i1.PageRouteInfo<OnboardingDentistRouteArgs> {
  OnboardingDentistRoute({_i2.Key? key, required _i57.Sex sex})
      : super(name,
            path: 'doctor/dentist',
            args: OnboardingDentistRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingDentistRoute';
}

class OnboardingDentistRouteArgs {
  const OnboardingDentistRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i57.Sex sex;
}

class DentistAchievementRoute extends _i1.PageRouteInfo<void> {
  const DentistAchievementRoute() : super(name, path: 'dentist-achievement');

  static const String name = 'DentistAchievementRoute';
}

class DentistDateRoute extends _i1.PageRouteInfo<void> {
  const DentistDateRoute() : super(name, path: 'doctor/dentist-date');

  static const String name = 'DentistDateRoute';
}

class MainRoute extends _i1.PageRouteInfo<void> {
  const MainRoute() : super(name, path: '');

  static const String name = 'MainRoute';
}

class OpenSettingsRoute extends _i1.PageRouteInfo<OpenSettingsRouteArgs> {
  OpenSettingsRoute({_i2.Key? key})
      : super(name, path: 'settings', args: OpenSettingsRouteArgs(key: key));

  static const String name = 'OpenSettingsRoute';
}

class OpenSettingsRouteArgs {
  const OpenSettingsRouteArgs({this.key});

  final _i2.Key? key;
}

class UpdateProfileRoute extends _i1.PageRouteInfo<UpdateProfileRouteArgs> {
  UpdateProfileRoute({_i2.Key? key})
      : super(name,
            path: 'settings/update-profile',
            args: UpdateProfileRouteArgs(key: key));

  static const String name = 'UpdateProfileRoute';
}

class UpdateProfileRouteArgs {
  const UpdateProfileRouteArgs({this.key});

  final _i2.Key? key;
}

class EditNicknameRoute extends _i1.PageRouteInfo<EditNicknameRouteArgs> {
  EditNicknameRoute({_i2.Key? key, required _i58.User? user})
      : super(name,
            path: 'settings/update-profile/nickname',
            args: EditNicknameRouteArgs(key: key, user: user));

  static const String name = 'EditNicknameRoute';
}

class EditNicknameRouteArgs {
  const EditNicknameRouteArgs({this.key, required this.user});

  final _i2.Key? key;

  final _i58.User? user;
}

class EditEmailRoute extends _i1.PageRouteInfo<EditEmailRouteArgs> {
  EditEmailRoute({_i2.Key? key, required _i58.User? user})
      : super(name,
            path: 'settings/update-profile/email',
            args: EditEmailRouteArgs(key: key, user: user));

  static const String name = 'EditEmailRoute';
}

class EditEmailRouteArgs {
  const EditEmailRouteArgs({this.key, required this.user});

  final _i2.Key? key;

  final _i58.User? user;
}

class EditPhotoRoute extends _i1.PageRouteInfo<EditPhotoRouteArgs> {
  EditPhotoRoute({_i2.Key? key, _i59.Uint8List? imageBytes})
      : super(name,
            path: 'settings/update-profile/photo',
            args: EditPhotoRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'EditPhotoRoute';
}

class EditPhotoRouteArgs {
  const EditPhotoRouteArgs({this.key, this.imageBytes});

  final _i2.Key? key;

  final _i59.Uint8List? imageBytes;
}

class DeleteAccountRoute extends _i1.PageRouteInfo<void> {
  const DeleteAccountRoute()
      : super(name, path: 'settings/update-profile/delete');

  static const String name = 'DeleteAccountRoute';
}

class CameraPhotoTakenRoute
    extends _i1.PageRouteInfo<CameraPhotoTakenRouteArgs> {
  CameraPhotoTakenRoute({_i2.Key? key, required _i59.Uint8List imageBytes})
      : super(name,
            path: 'settings/update-profile/photo/camera-taken',
            args: CameraPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'CameraPhotoTakenRoute';
}

class CameraPhotoTakenRouteArgs {
  const CameraPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i2.Key? key;

  final _i59.Uint8List imageBytes;
}

class GalleryPhotoTakenRoute
    extends _i1.PageRouteInfo<GalleryPhotoTakenRouteArgs> {
  GalleryPhotoTakenRoute({_i2.Key? key, required _i59.Uint8List imageBytes})
      : super(name,
            path: 'settings/update-profile/photo/gallery-taken',
            args: GalleryPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'GalleryPhotoTakenRoute';
}

class GalleryPhotoTakenRouteArgs {
  const GalleryPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i2.Key? key;

  final _i59.Uint8List imageBytes;
}

class PhotoCroppedResultRoute
    extends _i1.PageRouteInfo<PhotoCroppedResultRouteArgs> {
  PhotoCroppedResultRoute({_i2.Key? key, required _i59.Uint8List imageBytes})
      : super(name,
            path: 'settings/update-profile/photo/photo-cropped-result',
            args:
                PhotoCroppedResultRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'PhotoCroppedResultRoute';
}

class PhotoCroppedResultRouteArgs {
  const PhotoCroppedResultRouteArgs({this.key, required this.imageBytes});

  final _i2.Key? key;

  final _i59.Uint8List imageBytes;
}

class LeaderboardRoute extends _i1.PageRouteInfo<void> {
  const LeaderboardRoute() : super(name, path: 'settings/leaderboard');

  static const String name = 'LeaderboardRoute';
}

class PointsHelpRoute extends _i1.PageRouteInfo<void> {
  const PointsHelpRoute() : super(name, path: 'settings/points-help');

  static const String name = 'PointsHelpRoute';
}

class ExaminationDetailRoute
    extends _i1.PageRouteInfo<ExaminationDetailRouteArgs> {
  ExaminationDetailRoute(
      {_i2.Key? key,
      required _i60.CategorizedExamination categorizedExamination})
      : super(name,
            path: 'prevention-detail',
            args: ExaminationDetailRouteArgs(
                key: key, categorizedExamination: categorizedExamination));

  static const String name = 'ExaminationDetailRoute';
}

class ExaminationDetailRouteArgs {
  const ExaminationDetailRouteArgs(
      {this.key, required this.categorizedExamination});

  final _i2.Key? key;

  final _i60.CategorizedExamination categorizedExamination;
}

class AchievementRoute extends _i1.PageRouteInfo<AchievementRouteArgs> {
  AchievementRoute(
      {_i2.Key? key,
      required String header,
      required List<String> textLines,
      required int numberOfPoints,
      required String itemPath,
      required void Function()? onButtonTap})
      : super(name,
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

  final _i2.Key? key;

  final String header;

  final List<String> textLines;

  final int numberOfPoints;

  final String itemPath;

  final void Function()? onButtonTap;
}

class DatePickerRoute extends _i1.PageRouteInfo<DatePickerRouteArgs> {
  DatePickerRoute(
      {_i2.Key? key,
      required String assetPath,
      required String title,
      required void Function(DateTime)? onContinueButtonPress,
      void Function(DateTime)? onSkipButtonPress})
      : super(name,
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

  final _i2.Key? key;

  final String assetPath;

  final String title;

  final void Function(DateTime)? onContinueButtonPress;

  final void Function(DateTime)? onSkipButtonPress;
}

class CalendarPermissionInfoRoute
    extends _i1.PageRouteInfo<CalendarPermissionInfoRouteArgs> {
  CalendarPermissionInfoRoute(
      {_i2.Key? key, required _i57.PreventionStatus examinationRecord})
      : super(name,
            path: 'calendar/permission',
            args: CalendarPermissionInfoRouteArgs(
                key: key, examinationRecord: examinationRecord));

  static const String name = 'CalendarPermissionInfoRoute';
}

class CalendarPermissionInfoRouteArgs {
  const CalendarPermissionInfoRouteArgs(
      {this.key, required this.examinationRecord});

  final _i2.Key? key;

  final _i57.PreventionStatus examinationRecord;
}

class CalendarListRoute extends _i1.PageRouteInfo<CalendarListRouteArgs> {
  CalendarListRoute(
      {_i2.Key? key, required _i57.PreventionStatus examinationRecord})
      : super(name,
            path: 'calendar/list',
            args: CalendarListRouteArgs(
                key: key, examinationRecord: examinationRecord));

  static const String name = 'CalendarListRoute';
}

class CalendarListRouteArgs {
  const CalendarListRouteArgs({this.key, required this.examinationRecord});

  final _i2.Key? key;

  final _i57.PreventionStatus examinationRecord;
}

class ChangeLastVisitRoute extends _i1.PageRouteInfo<ChangeLastVisitRouteArgs> {
  ChangeLastVisitRoute(
      {_i2.Key? key,
      required DateTime originalDate,
      required String title,
      required _i57.ExaminationTypeEnum examinationType,
      required String? uuid,
      required _i61.ExaminationCategory status})
      : super(name,
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

  final _i2.Key? key;

  final DateTime originalDate;

  final String title;

  final _i57.ExaminationTypeEnum examinationType;

  final String? uuid;

  final _i61.ExaminationCategory status;
}

class NewDateRoute extends _i1.PageRouteInfo<NewDateRouteArgs> {
  NewDateRoute(
      {_i2.Key? key,
      required _i60.CategorizedExamination categorizedExamination,
      bool showCancelIcon = true})
      : super(name,
            path: 'checkup/set-date',
            args: NewDateRouteArgs(
                key: key,
                categorizedExamination: categorizedExamination,
                showCancelIcon: showCancelIcon));

  static const String name = 'NewDateRoute';
}

class NewDateRouteArgs {
  const NewDateRouteArgs(
      {this.key,
      required this.categorizedExamination,
      this.showCancelIcon = true});

  final _i2.Key? key;

  final _i60.CategorizedExamination categorizedExamination;

  final bool showCancelIcon;
}

class NewTimeRoute extends _i1.PageRouteInfo<NewTimeRouteArgs> {
  NewTimeRoute(
      {_i2.Key? key,
      required _i60.CategorizedExamination categorizedExamination,
      required DateTime newDate})
      : super(name,
            path: 'checkup/set-time',
            args: NewTimeRouteArgs(
                key: key,
                categorizedExamination: categorizedExamination,
                newDate: newDate));

  static const String name = 'NewTimeRoute';
}

class NewTimeRouteArgs {
  const NewTimeRouteArgs(
      {this.key, required this.categorizedExamination, required this.newDate});

  final _i2.Key? key;

  final _i60.CategorizedExamination categorizedExamination;

  final DateTime newDate;
}

class ChangeDateRoute extends _i1.PageRouteInfo<ChangeDateRouteArgs> {
  ChangeDateRoute(
      {_i2.Key? key,
      required _i60.CategorizedExamination categorizedExamination})
      : super(name,
            path: 'checkup/change-date',
            args: ChangeDateRouteArgs(
                key: key, categorizedExamination: categorizedExamination));

  static const String name = 'ChangeDateRoute';
}

class ChangeDateRouteArgs {
  const ChangeDateRouteArgs({this.key, required this.categorizedExamination});

  final _i2.Key? key;

  final _i60.CategorizedExamination categorizedExamination;
}

class ChangeTimeRoute extends _i1.PageRouteInfo<ChangeTimeRouteArgs> {
  ChangeTimeRoute(
      {_i2.Key? key,
      required _i60.CategorizedExamination categorizedExamination,
      required DateTime newDate,
      required String? uuid})
      : super(name,
            path: 'checkup/change-time',
            args: ChangeTimeRouteArgs(
                key: key,
                categorizedExamination: categorizedExamination,
                newDate: newDate,
                uuid: uuid));

  static const String name = 'ChangeTimeRoute';
}

class ChangeTimeRouteArgs {
  const ChangeTimeRouteArgs(
      {this.key,
      required this.categorizedExamination,
      required this.newDate,
      required this.uuid});

  final _i2.Key? key;

  final _i60.CategorizedExamination categorizedExamination;

  final DateTime newDate;

  final String? uuid;
}
