// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'dart:typed_data' as _i64;

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i59;
import 'package:loono_api/loono_api.dart' as _i62;

import '../helpers/examination_category.dart' as _i66;
import '../models/categorized_examination.dart' as _i65;
import '../models/firebase_user.dart' as _i61;
import '../services/db/database.dart' as _i63;
import '../ui/screens/about_health/about_health.dart' as _i16;
import '../ui/screens/dentist_achievement.dart' as _i30;
import '../ui/screens/find_doctor/find_doctor.dart' as _i15;
import '../ui/screens/general_practicioner_achievement.dart' as _i23;
import '../ui/screens/gynecology_achievement.dart' as _i27;
import '../ui/screens/logout.dart' as _i10;
import '../ui/screens/main/main_screen.dart' as _i32;
import '../ui/screens/main/pre_auth/continue_onboarding_form.dart' as _i18;
import '../ui/screens/main/pre_auth/login.dart' as _i9;
import '../ui/screens/main/pre_auth/onboarding_form_done.dart' as _i19;
import '../ui/screens/main/pre_auth/pre_auth_main_screen.dart' as _i2;
import '../ui/screens/main/pre_auth/start_new_questionnaire.dart' as _i17;
import '../ui/screens/onboarding/allow_notifications.dart' as _i25;
import '../ui/screens/onboarding/birthdate.dart' as _i21;
import '../ui/screens/onboarding/carousel/carousel.dart' as _i3;
import '../ui/screens/onboarding/doctors/dentist.dart' as _i29;
import '../ui/screens/onboarding/doctors/dentist_date.dart' as _i31;
import '../ui/screens/onboarding/doctors/general_practicioner.dart' as _i22;
import '../ui/screens/onboarding/doctors/general_practitioner_date.dart'
    as _i24;
import '../ui/screens/onboarding/doctors/gynecology.dart' as _i26;
import '../ui/screens/onboarding/doctors/gynecology_date.dart' as _i28;
import '../ui/screens/onboarding/fallback_account/email.dart' as _i8;
import '../ui/screens/onboarding/fallback_account/nickname.dart' as _i7;
import '../ui/screens/onboarding/fill_form_later.dart' as _i5;
import '../ui/screens/onboarding/gamification_introduction.dart' as _i6;
import '../ui/screens/onboarding/gender.dart' as _i20;
import '../ui/screens/prevention/calendar/calendar_list.dart' as _i48;
import '../ui/screens/prevention/calendar/permission_info.dart' as _i47;
import '../ui/screens/prevention/examination_detail/change_date_screen.dart'
    as _i52;
import '../ui/screens/prevention/examination_detail/change_last_visit_screen.dart'
    as _i49;
import '../ui/screens/prevention/examination_detail/change_time_screen.dart'
    as _i53;
import '../ui/screens/prevention/examination_detail/examination_screen.dart'
    as _i44;
import '../ui/screens/prevention/examination_detail/new_date_screen.dart'
    as _i50;
import '../ui/screens/prevention/examination_detail/new_time_screen.dart'
    as _i51;
import '../ui/screens/prevention/questionnaire/date_picker_screen.dart' as _i46;
import '../ui/screens/prevention/self_examination/detail_screen.dart' as _i54;
import '../ui/screens/prevention/self_examination/educational_screen.dart'
    as _i55;
import '../ui/screens/prevention/self_examination/has_finding_screen.dart'
    as _i56;
import '../ui/screens/prevention/self_examination/no_finding_screen.dart'
    as _i57;
import '../ui/screens/prevention/self_examination/progress_screen.dart' as _i58;
import '../ui/screens/settings/camera_photo_taken.dart' as _i39;
import '../ui/screens/settings/delete_account.dart' as _i38;
import '../ui/screens/settings/edit_email.dart' as _i36;
import '../ui/screens/settings/edit_nickname.dart' as _i35;
import '../ui/screens/settings/edit_photo.dart' as _i37;
import '../ui/screens/settings/gallery_photo_taken.dart' as _i40;
import '../ui/screens/settings/leaderboard.dart' as _i42;
import '../ui/screens/settings/open_settings.dart' as _i33;
import '../ui/screens/settings/photo_cropped_result.dart' as _i41;
import '../ui/screens/settings/points_help.dart' as _i43;
import '../ui/screens/settings/update_profile.dart' as _i34;
import '../ui/screens/splash_screen.dart' as _i12;
import '../ui/screens/welcome.dart' as _i13;
import '../ui/widgets/achievement_screen.dart' as _i45;
import 'guards/check_is_logged_in.dart' as _i60;
import 'sub_routers/app_startup_wrapper_screen.dart' as _i1;
import 'sub_routers/onboarding_wrapper_screen.dart' as _i4;
import 'sub_routers/pre_auth_prevention_wrapper_screen.dart' as _i14;

class AppRouter extends _i11.RootStackRouter {
  AppRouter(
      {_i59.GlobalKey<_i59.NavigatorState>? navigatorKey,
      required this.checkIsLoggedIn})
      : super(navigatorKey);

  final _i60.CheckIsLoggedIn checkIsLoggedIn;

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    AppStartUpWrapperRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i1.AppStartUpWrapperScreen());
    },
    PreAuthMainRoute.name: (routeData) {
      final args = routeData.argsAs<PreAuthMainRouteArgs>(
          orElse: () => const PreAuthMainRouteArgs());
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i2.PreAuthMainScreen(
              key: args.key,
              overridenPreventionRoute: args.overridenPreventionRoute));
    },
    IntroCarouselRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i3.IntroCarouselScreen());
    },
    OnboardingWrapperRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i4.OnboardingWrapperScreen());
    },
    FillOnboardingFormLaterRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: const _i5.FillOnboardingFormLaterScreen());
    },
    GamificationIntroductionRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: const _i6.GamificationIntroductionScreen());
    },
    NicknameRoute.name: (routeData) {
      final args = routeData.argsAs<NicknameRouteArgs>(
          orElse: () => const NicknameRouteArgs());
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i7.NicknameScreen(key: args.key, authUser: args.authUser));
    },
    EmailRoute.name: (routeData) {
      final args = routeData.argsAs<EmailRouteArgs>(
          orElse: () => const EmailRouteArgs());
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i8.EmailScreen(key: args.key, authUser: args.authUser));
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: _i9.LoginScreen(key: args.key));
    },
    LogoutRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i10.LogoutScreen());
    },
    MainScreenRouter.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i11.EmptyRouterScreen());
    },
    SplashRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i12.SplashScreen());
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: _i13.WelcomeScreen(key: args.key));
    },
    PreAuthPreventionWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<PreAuthPreventionWrapperRouteArgs>(
          orElse: () => const PreAuthPreventionWrapperRouteArgs());
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i14.PreAuthPreventionWrapperScreen(
              key: args.key, forceRoute: args.forceRoute));
    },
    FindDoctorRoute.name: (routeData) {
      final args = routeData.argsAs<FindDoctorRouteArgs>(
          orElse: () => const FindDoctorRouteArgs());
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i15.FindDoctorScreen(
              key: args.key, cancelRouteName: args.cancelRouteName));
    },
    AboutHealthRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i16.AboutHealthScreen());
    },
    StartNewQuestionnaireRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: const _i17.StartNewQuestionnaireScreen());
    },
    ContinueOnboardingFormRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: const _i18.ContinueOnboardingFormScreen());
    },
    OnboardingFormDoneRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingFormDoneRouteArgs>(
          orElse: () => const OnboardingFormDoneRouteArgs());
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i19.OnboardingFormDoneScreen(key: args.key));
    },
    OnboardingGenderRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i20.OnboardingGenderScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnBoardingBirthdateRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingBirthdateRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i21.OnBoardingBirthdateScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGeneralPracticionerRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGeneralPracticionerRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i22.OnboardingGeneralPracticionerScreen(
              key: args.key, sex: args.sex),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPracticionerAchievementRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i23.GeneralPracticionerAchievementScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPractitionerDateRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i24.GeneralPractitionerDateScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AllowNotificationsRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i25.AllowNotificationsScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGynecologyRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGynecologyRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i26.OnboardingGynecologyScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyAchievementRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i27.GynecologyAchievementScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyDateRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i28.GynecologyDateScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingDentistRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingDentistRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i29.OnboardingDentistScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistAchievementRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i30.DentistAchievementScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistDateRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i31.DentistDateScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    MainRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i32.MainScreen());
    },
    OpenSettingsRoute.name: (routeData) {
      final args = routeData.argsAs<OpenSettingsRouteArgs>(
          orElse: () => const OpenSettingsRouteArgs());
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i33.OpenSettingsScreen(key: args.key),
          transitionsBuilder: _i11.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    UpdateProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateProfileRouteArgs>(
          orElse: () => const UpdateProfileRouteArgs());
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i34.UpdateProfileScreen(key: args.key),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditNicknameRoute.name: (routeData) {
      final args = routeData.argsAs<EditNicknameRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i35.EditNicknameScreen(key: args.key, user: args.user),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditEmailRoute.name: (routeData) {
      final args = routeData.argsAs<EditEmailRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i36.EditEmailScreen(key: args.key, user: args.user),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditPhotoRoute.name: (routeData) {
      final args = routeData.argsAs<EditPhotoRouteArgs>(
          orElse: () => const EditPhotoRouteArgs());
      return _i11.CustomPage<void>(
          routeData: routeData,
          child:
              _i37.EditPhotoScreen(key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DeleteAccountRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i38.DeleteAccountScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CameraPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<CameraPhotoTakenRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i39.CameraPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GalleryPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<GalleryPhotoTakenRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i40.GalleryPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    PhotoCroppedResultRoute.name: (routeData) {
      final args = routeData.argsAs<PhotoCroppedResultRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i41.PhotoCroppedResultScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    LeaderboardRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i42.LeaderboardScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    PointsHelpRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i43.PointsHelpScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ExaminationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ExaminationDetailRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i44.ExaminationDetailScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AchievementRoute.name: (routeData) {
      final args = routeData.argsAs<AchievementRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i45.AchievementScreen(
              key: args.key,
              header: args.header,
              textLines: args.textLines,
              numberOfPoints: args.numberOfPoints,
              itemPath: args.itemPath,
              onButtonTap: args.onButtonTap),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DatePickerRoute.name: (routeData) {
      final args = routeData.argsAs<DatePickerRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i46.DatePickerScreen(
              key: args.key,
              assetPath: args.assetPath,
              title: args.title,
              onContinueButtonPress: args.onContinueButtonPress,
              onSkipButtonPress: args.onSkipButtonPress),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CalendarPermissionInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarPermissionInfoRouteArgs>();
      return _i11.CustomPage<bool>(
          routeData: routeData,
          child: _i47.CalendarPermissionInfoScreen(
              key: args.key, examinationRecord: args.examinationRecord),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CalendarListRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarListRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i48.CalendarListScreen(
              key: args.key, examinationRecord: args.examinationRecord),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ChangeLastVisitRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeLastVisitRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i49.ChangeLastVisitScreen(
              key: args.key,
              originalDate: args.originalDate,
              title: args.title,
              examinationType: args.examinationType,
              uuid: args.uuid,
              status: args.status),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    NewDateRoute.name: (routeData) {
      final args = routeData.argsAs<NewDateRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i50.NewDateScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination,
              showCancelIcon: args.showCancelIcon),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    NewTimeRoute.name: (routeData) {
      final args = routeData.argsAs<NewTimeRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i51.NewTimeScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination,
              newDate: args.newDate),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ChangeDateRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeDateRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i52.ChangeDateScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ChangeTimeRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeTimeRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i53.ChangeTimeScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination,
              newDate: args.newDate,
              uuid: args.uuid),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    SelfExaminationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SelfExaminationDetailRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i54.SelfExaminationDetailScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EducationalVideoRoute.name: (routeData) {
      final args = routeData.argsAs<EducationalVideoRouteArgs>();
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: _i55.EducationalVideoScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    HasFindingRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i56.HasFindingScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    NoFindingRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i57.NoFindingScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    ProgressRewardRoute.name: (routeData) {
      return _i11.CustomPage<void>(
          routeData: routeData,
          child: const _i58.ProgressRewardScreen(),
          transitionsBuilder: _i11.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig('/#redirect',
            path: '/', redirectTo: 'main', fullMatch: true),
        _i11.RouteConfig(AppStartUpWrapperRoute.name,
            path: 'app-start-up',
            children: [
              _i11.RouteConfig(SplashRoute.name,
                  path: 'splash-screen', parent: AppStartUpWrapperRoute.name),
              _i11.RouteConfig(WelcomeRoute.name,
                  path: 'welcome', parent: AppStartUpWrapperRoute.name),
              _i11.RouteConfig(PreAuthMainRoute.name,
                  path: 'pre-auth-main',
                  parent: AppStartUpWrapperRoute.name,
                  children: [
                    _i11.RouteConfig(PreAuthPreventionWrapperRoute.name,
                        path: 'pre-auth-prevention',
                        parent: PreAuthMainRoute.name,
                        children: [
                          _i11.RouteConfig(LoginRoute.name,
                              path: 'login',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i11.RouteConfig(StartNewQuestionnaireRoute.name,
                              path: 'start-new-questionnaire',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i11.RouteConfig(ContinueOnboardingFormRoute.name,
                              path: 'continue-onboarding-form',
                              parent: PreAuthPreventionWrapperRoute.name),
                          _i11.RouteConfig(OnboardingFormDoneRoute.name,
                              path: 'onboarding-form-done',
                              parent: PreAuthPreventionWrapperRoute.name)
                        ]),
                    _i11.RouteConfig(FindDoctorRoute.name,
                        path: 'find-doctor', parent: PreAuthMainRoute.name),
                    _i11.RouteConfig(AboutHealthRoute.name,
                        path: 'about-health', parent: PreAuthMainRoute.name)
                  ])
            ]),
        _i11.RouteConfig(PreAuthMainRoute.name,
            path: 'pre-auth-main',
            children: [
              _i11.RouteConfig(PreAuthPreventionWrapperRoute.name,
                  path: 'pre-auth-prevention',
                  parent: PreAuthMainRoute.name,
                  children: [
                    _i11.RouteConfig(LoginRoute.name,
                        path: 'login',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i11.RouteConfig(StartNewQuestionnaireRoute.name,
                        path: 'start-new-questionnaire',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i11.RouteConfig(ContinueOnboardingFormRoute.name,
                        path: 'continue-onboarding-form',
                        parent: PreAuthPreventionWrapperRoute.name),
                    _i11.RouteConfig(OnboardingFormDoneRoute.name,
                        path: 'onboarding-form-done',
                        parent: PreAuthPreventionWrapperRoute.name)
                  ]),
              _i11.RouteConfig(FindDoctorRoute.name,
                  path: 'find-doctor', parent: PreAuthMainRoute.name),
              _i11.RouteConfig(AboutHealthRoute.name,
                  path: 'about-health', parent: PreAuthMainRoute.name)
            ]),
        _i11.RouteConfig(IntroCarouselRoute.name, path: 'intro-carousel'),
        _i11.RouteConfig(OnboardingWrapperRoute.name,
            path: 'onboarding',
            children: [
              _i11.RouteConfig(OnboardingGenderRoute.name,
                  path: 'gender', parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(OnBoardingBirthdateRoute.name,
                  path: 'birthdate', parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(OnboardingGeneralPracticionerRoute.name,
                  path: 'doctor/general-practicioner',
                  parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(GeneralPracticionerAchievementRoute.name,
                  path: 'general-practicioner-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(GeneralPractitionerDateRoute.name,
                  path: 'doctor/general-practitioner-date',
                  parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(AllowNotificationsRoute.name,
                  path: 'allow-notifications',
                  parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(OnboardingGynecologyRoute.name,
                  path: 'doctor/gynecology',
                  parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(GynecologyAchievementRoute.name,
                  path: 'gynecology-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(GynecologyDateRoute.name,
                  path: 'doctor/gynecology-date',
                  parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(OnboardingDentistRoute.name,
                  path: 'doctor/dentist', parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(DentistAchievementRoute.name,
                  path: 'dentist-achievement',
                  parent: OnboardingWrapperRoute.name),
              _i11.RouteConfig(DentistDateRoute.name,
                  path: 'doctor/dentist-date',
                  parent: OnboardingWrapperRoute.name)
            ]),
        _i11.RouteConfig(FillOnboardingFormLaterRoute.name,
            path: 'fill-form-later'),
        _i11.RouteConfig(GamificationIntroductionRoute.name,
            path: 'gamification-introduction'),
        _i11.RouteConfig(NicknameRoute.name, path: 'fallback-account/name'),
        _i11.RouteConfig(EmailRoute.name, path: 'fallback-account/email'),
        _i11.RouteConfig(LoginRoute.name, path: 'login'),
        _i11.RouteConfig(LogoutRoute.name, path: 'logout'),
        _i11.RouteConfig(MainScreenRouter.name, path: 'main', guards: [
          checkIsLoggedIn
        ], children: [
          _i11.RouteConfig(MainRoute.name,
              path: '', parent: MainScreenRouter.name),
          _i11.RouteConfig(OpenSettingsRoute.name,
              path: 'settings', parent: MainScreenRouter.name),
          _i11.RouteConfig(UpdateProfileRoute.name,
              path: 'settings/update-profile', parent: MainScreenRouter.name),
          _i11.RouteConfig(EditNicknameRoute.name,
              path: 'settings/update-profile/nickname',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(EditEmailRoute.name,
              path: 'settings/update-profile/email',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(EditPhotoRoute.name,
              path: 'settings/update-profile/photo',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(DeleteAccountRoute.name,
              path: 'settings/update-profile/delete',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(CameraPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/camera-taken',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(GalleryPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/gallery-taken',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(PhotoCroppedResultRoute.name,
              path: 'settings/update-profile/photo/photo-cropped-result',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(LeaderboardRoute.name,
              path: 'settings/leaderboard', parent: MainScreenRouter.name),
          _i11.RouteConfig(PointsHelpRoute.name,
              path: 'settings/points-help', parent: MainScreenRouter.name),
          _i11.RouteConfig(ExaminationDetailRoute.name,
              path: 'prevention-detail', parent: MainScreenRouter.name),
          _i11.RouteConfig(AchievementRoute.name,
              path: 'questionnaire/reward', parent: MainScreenRouter.name),
          _i11.RouteConfig(DatePickerRoute.name,
              path: 'questionnaire/date-picker', parent: MainScreenRouter.name),
          _i11.RouteConfig(CalendarPermissionInfoRoute.name,
              path: 'calendar/permission', parent: MainScreenRouter.name),
          _i11.RouteConfig(CalendarListRoute.name,
              path: 'calendar/list', parent: MainScreenRouter.name),
          _i11.RouteConfig(ChangeLastVisitRoute.name,
              path: 'checkup/last-visit-update', parent: MainScreenRouter.name),
          _i11.RouteConfig(NewDateRoute.name,
              path: 'checkup/set-date', parent: MainScreenRouter.name),
          _i11.RouteConfig(NewTimeRoute.name,
              path: 'checkup/set-time', parent: MainScreenRouter.name),
          _i11.RouteConfig(ChangeDateRoute.name,
              path: 'checkup/change-date', parent: MainScreenRouter.name),
          _i11.RouteConfig(ChangeTimeRoute.name,
              path: 'checkup/change-time', parent: MainScreenRouter.name),
          _i11.RouteConfig(SelfExaminationDetailRoute.name,
              path: 'self-examination/detail', parent: MainScreenRouter.name),
          _i11.RouteConfig(EducationalVideoRoute.name,
              path: 'self-examination/detail/educational-video',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(HasFindingRoute.name,
              path: 'self-examination/detail/has-finding',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(NoFindingRoute.name,
              path: 'self-examination/detail/no-finding',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(ProgressRewardRoute.name,
              path: 'self-examination/detail/progress-reward',
              parent: MainScreenRouter.name),
          _i11.RouteConfig(FindDoctorRoute.name,
              path: 'find-doctor', parent: MainScreenRouter.name)
        ])
      ];
}

/// generated route for
/// [_i1.AppStartUpWrapperScreen]
class AppStartUpWrapperRoute extends _i11.PageRouteInfo<void> {
  const AppStartUpWrapperRoute({List<_i11.PageRouteInfo>? children})
      : super(AppStartUpWrapperRoute.name,
            path: 'app-start-up', initialChildren: children);

  static const String name = 'AppStartUpWrapperRoute';
}

/// generated route for
/// [_i2.PreAuthMainScreen]
class PreAuthMainRoute extends _i11.PageRouteInfo<PreAuthMainRouteArgs> {
  PreAuthMainRoute(
      {_i59.Key? key,
      _i11.PageRouteInfo<dynamic>? overridenPreventionRoute,
      List<_i11.PageRouteInfo>? children})
      : super(PreAuthMainRoute.name,
            path: 'pre-auth-main',
            args: PreAuthMainRouteArgs(
                key: key, overridenPreventionRoute: overridenPreventionRoute),
            initialChildren: children);

  static const String name = 'PreAuthMainRoute';
}

class PreAuthMainRouteArgs {
  const PreAuthMainRouteArgs({this.key, this.overridenPreventionRoute});

  final _i59.Key? key;

  final _i11.PageRouteInfo<dynamic>? overridenPreventionRoute;

  @override
  String toString() {
    return 'PreAuthMainRouteArgs{key: $key, overridenPreventionRoute: $overridenPreventionRoute}';
  }
}

/// generated route for
/// [_i3.IntroCarouselScreen]
class IntroCarouselRoute extends _i11.PageRouteInfo<void> {
  const IntroCarouselRoute()
      : super(IntroCarouselRoute.name, path: 'intro-carousel');

  static const String name = 'IntroCarouselRoute';
}

/// generated route for
/// [_i4.OnboardingWrapperScreen]
class OnboardingWrapperRoute extends _i11.PageRouteInfo<void> {
  const OnboardingWrapperRoute({List<_i11.PageRouteInfo>? children})
      : super(OnboardingWrapperRoute.name,
            path: 'onboarding', initialChildren: children);

  static const String name = 'OnboardingWrapperRoute';
}

/// generated route for
/// [_i5.FillOnboardingFormLaterScreen]
class FillOnboardingFormLaterRoute extends _i11.PageRouteInfo<void> {
  const FillOnboardingFormLaterRoute()
      : super(FillOnboardingFormLaterRoute.name, path: 'fill-form-later');

  static const String name = 'FillOnboardingFormLaterRoute';
}

/// generated route for
/// [_i6.GamificationIntroductionScreen]
class GamificationIntroductionRoute extends _i11.PageRouteInfo<void> {
  const GamificationIntroductionRoute()
      : super(GamificationIntroductionRoute.name,
            path: 'gamification-introduction');

  static const String name = 'GamificationIntroductionRoute';
}

/// generated route for
/// [_i7.NicknameScreen]
class NicknameRoute extends _i11.PageRouteInfo<NicknameRouteArgs> {
  NicknameRoute({_i59.Key? key, _i61.AuthUser? authUser})
      : super(NicknameRoute.name,
            path: 'fallback-account/name',
            args: NicknameRouteArgs(key: key, authUser: authUser));

  static const String name = 'NicknameRoute';
}

class NicknameRouteArgs {
  const NicknameRouteArgs({this.key, this.authUser});

  final _i59.Key? key;

  final _i61.AuthUser? authUser;

  @override
  String toString() {
    return 'NicknameRouteArgs{key: $key, authUser: $authUser}';
  }
}

/// generated route for
/// [_i8.EmailScreen]
class EmailRoute extends _i11.PageRouteInfo<EmailRouteArgs> {
  EmailRoute({_i59.Key? key, _i61.AuthUser? authUser})
      : super(EmailRoute.name,
            path: 'fallback-account/email',
            args: EmailRouteArgs(key: key, authUser: authUser));

  static const String name = 'EmailRoute';
}

class EmailRouteArgs {
  const EmailRouteArgs({this.key, this.authUser});

  final _i59.Key? key;

  final _i61.AuthUser? authUser;

  @override
  String toString() {
    return 'EmailRouteArgs{key: $key, authUser: $authUser}';
  }
}

/// generated route for
/// [_i9.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i59.Key? key})
      : super(LoginRoute.name, path: 'login', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i59.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.LogoutScreen]
class LogoutRoute extends _i11.PageRouteInfo<void> {
  const LogoutRoute() : super(LogoutRoute.name, path: 'logout');

  static const String name = 'LogoutRoute';
}

/// generated route for
/// [_i11.EmptyRouterScreen]
class MainScreenRouter extends _i11.PageRouteInfo<void> {
  const MainScreenRouter({List<_i11.PageRouteInfo>? children})
      : super(MainScreenRouter.name, path: 'main', initialChildren: children);

  static const String name = 'MainScreenRouter';
}

/// generated route for
/// [_i12.SplashScreen]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: 'splash-screen');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i13.WelcomeScreen]
class WelcomeRoute extends _i11.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({_i59.Key? key})
      : super(WelcomeRoute.name,
            path: 'welcome', args: WelcomeRouteArgs(key: key));

  static const String name = 'WelcomeRoute';
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i59.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.PreAuthPreventionWrapperScreen]
class PreAuthPreventionWrapperRoute
    extends _i11.PageRouteInfo<PreAuthPreventionWrapperRouteArgs> {
  PreAuthPreventionWrapperRoute(
      {_i59.Key? key,
      _i11.PageRouteInfo<dynamic>? forceRoute,
      List<_i11.PageRouteInfo>? children})
      : super(PreAuthPreventionWrapperRoute.name,
            path: 'pre-auth-prevention',
            args: PreAuthPreventionWrapperRouteArgs(
                key: key, forceRoute: forceRoute),
            initialChildren: children);

  static const String name = 'PreAuthPreventionWrapperRoute';
}

class PreAuthPreventionWrapperRouteArgs {
  const PreAuthPreventionWrapperRouteArgs({this.key, this.forceRoute});

  final _i59.Key? key;

  final _i11.PageRouteInfo<dynamic>? forceRoute;

  @override
  String toString() {
    return 'PreAuthPreventionWrapperRouteArgs{key: $key, forceRoute: $forceRoute}';
  }
}

/// generated route for
/// [_i15.FindDoctorScreen]
class FindDoctorRoute extends _i11.PageRouteInfo<FindDoctorRouteArgs> {
  FindDoctorRoute({_i59.Key? key, _i11.PageRouteInfo<dynamic>? cancelRouteName})
      : super(FindDoctorRoute.name,
            path: 'find-doctor',
            args: FindDoctorRouteArgs(
                key: key, cancelRouteName: cancelRouteName));

  static const String name = 'FindDoctorRoute';
}

class FindDoctorRouteArgs {
  const FindDoctorRouteArgs({this.key, this.cancelRouteName});

  final _i59.Key? key;

  final _i11.PageRouteInfo<dynamic>? cancelRouteName;

  @override
  String toString() {
    return 'FindDoctorRouteArgs{key: $key, cancelRouteName: $cancelRouteName}';
  }
}

/// generated route for
/// [_i16.AboutHealthScreen]
class AboutHealthRoute extends _i11.PageRouteInfo<void> {
  const AboutHealthRoute() : super(AboutHealthRoute.name, path: 'about-health');

  static const String name = 'AboutHealthRoute';
}

/// generated route for
/// [_i17.StartNewQuestionnaireScreen]
class StartNewQuestionnaireRoute extends _i11.PageRouteInfo<void> {
  const StartNewQuestionnaireRoute()
      : super(StartNewQuestionnaireRoute.name, path: 'start-new-questionnaire');

  static const String name = 'StartNewQuestionnaireRoute';
}

/// generated route for
/// [_i18.ContinueOnboardingFormScreen]
class ContinueOnboardingFormRoute extends _i11.PageRouteInfo<void> {
  const ContinueOnboardingFormRoute()
      : super(ContinueOnboardingFormRoute.name,
            path: 'continue-onboarding-form');

  static const String name = 'ContinueOnboardingFormRoute';
}

/// generated route for
/// [_i19.OnboardingFormDoneScreen]
class OnboardingFormDoneRoute
    extends _i11.PageRouteInfo<OnboardingFormDoneRouteArgs> {
  OnboardingFormDoneRoute({_i59.Key? key})
      : super(OnboardingFormDoneRoute.name,
            path: 'onboarding-form-done',
            args: OnboardingFormDoneRouteArgs(key: key));

  static const String name = 'OnboardingFormDoneRoute';
}

class OnboardingFormDoneRouteArgs {
  const OnboardingFormDoneRouteArgs({this.key});

  final _i59.Key? key;

  @override
  String toString() {
    return 'OnboardingFormDoneRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.OnboardingGenderScreen]
class OnboardingGenderRoute extends _i11.PageRouteInfo<void> {
  const OnboardingGenderRoute()
      : super(OnboardingGenderRoute.name, path: 'gender');

  static const String name = 'OnboardingGenderRoute';
}

/// generated route for
/// [_i21.OnBoardingBirthdateScreen]
class OnBoardingBirthdateRoute
    extends _i11.PageRouteInfo<OnBoardingBirthdateRouteArgs> {
  OnBoardingBirthdateRoute({_i59.Key? key, required _i62.Sex sex})
      : super(OnBoardingBirthdateRoute.name,
            path: 'birthdate',
            args: OnBoardingBirthdateRouteArgs(key: key, sex: sex));

  static const String name = 'OnBoardingBirthdateRoute';
}

class OnBoardingBirthdateRouteArgs {
  const OnBoardingBirthdateRouteArgs({this.key, required this.sex});

  final _i59.Key? key;

  final _i62.Sex sex;

  @override
  String toString() {
    return 'OnBoardingBirthdateRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i22.OnboardingGeneralPracticionerScreen]
class OnboardingGeneralPracticionerRoute
    extends _i11.PageRouteInfo<OnboardingGeneralPracticionerRouteArgs> {
  OnboardingGeneralPracticionerRoute({_i59.Key? key, required _i62.Sex sex})
      : super(OnboardingGeneralPracticionerRoute.name,
            path: 'doctor/general-practicioner',
            args: OnboardingGeneralPracticionerRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGeneralPracticionerRoute';
}

class OnboardingGeneralPracticionerRouteArgs {
  const OnboardingGeneralPracticionerRouteArgs({this.key, required this.sex});

  final _i59.Key? key;

  final _i62.Sex sex;

  @override
  String toString() {
    return 'OnboardingGeneralPracticionerRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i23.GeneralPracticionerAchievementScreen]
class GeneralPracticionerAchievementRoute extends _i11.PageRouteInfo<void> {
  const GeneralPracticionerAchievementRoute()
      : super(GeneralPracticionerAchievementRoute.name,
            path: 'general-practicioner-achievement');

  static const String name = 'GeneralPracticionerAchievementRoute';
}

/// generated route for
/// [_i24.GeneralPractitionerDateScreen]
class GeneralPractitionerDateRoute extends _i11.PageRouteInfo<void> {
  const GeneralPractitionerDateRoute()
      : super(GeneralPractitionerDateRoute.name,
            path: 'doctor/general-practitioner-date');

  static const String name = 'GeneralPractitionerDateRoute';
}

/// generated route for
/// [_i25.AllowNotificationsScreen]
class AllowNotificationsRoute extends _i11.PageRouteInfo<void> {
  const AllowNotificationsRoute()
      : super(AllowNotificationsRoute.name, path: 'allow-notifications');

  static const String name = 'AllowNotificationsRoute';
}

/// generated route for
/// [_i26.OnboardingGynecologyScreen]
class OnboardingGynecologyRoute
    extends _i11.PageRouteInfo<OnboardingGynecologyRouteArgs> {
  OnboardingGynecologyRoute({_i59.Key? key, required _i62.Sex sex})
      : super(OnboardingGynecologyRoute.name,
            path: 'doctor/gynecology',
            args: OnboardingGynecologyRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGynecologyRoute';
}

class OnboardingGynecologyRouteArgs {
  const OnboardingGynecologyRouteArgs({this.key, required this.sex});

  final _i59.Key? key;

  final _i62.Sex sex;

  @override
  String toString() {
    return 'OnboardingGynecologyRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i27.GynecologyAchievementScreen]
class GynecologyAchievementRoute extends _i11.PageRouteInfo<void> {
  const GynecologyAchievementRoute()
      : super(GynecologyAchievementRoute.name, path: 'gynecology-achievement');

  static const String name = 'GynecologyAchievementRoute';
}

/// generated route for
/// [_i28.GynecologyDateScreen]
class GynecologyDateRoute extends _i11.PageRouteInfo<void> {
  const GynecologyDateRoute()
      : super(GynecologyDateRoute.name, path: 'doctor/gynecology-date');

  static const String name = 'GynecologyDateRoute';
}

/// generated route for
/// [_i29.OnboardingDentistScreen]
class OnboardingDentistRoute
    extends _i11.PageRouteInfo<OnboardingDentistRouteArgs> {
  OnboardingDentistRoute({_i59.Key? key, required _i62.Sex sex})
      : super(OnboardingDentistRoute.name,
            path: 'doctor/dentist',
            args: OnboardingDentistRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingDentistRoute';
}

class OnboardingDentistRouteArgs {
  const OnboardingDentistRouteArgs({this.key, required this.sex});

  final _i59.Key? key;

  final _i62.Sex sex;

  @override
  String toString() {
    return 'OnboardingDentistRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i30.DentistAchievementScreen]
class DentistAchievementRoute extends _i11.PageRouteInfo<void> {
  const DentistAchievementRoute()
      : super(DentistAchievementRoute.name, path: 'dentist-achievement');

  static const String name = 'DentistAchievementRoute';
}

/// generated route for
/// [_i31.DentistDateScreen]
class DentistDateRoute extends _i11.PageRouteInfo<void> {
  const DentistDateRoute()
      : super(DentistDateRoute.name, path: 'doctor/dentist-date');

  static const String name = 'DentistDateRoute';
}

/// generated route for
/// [_i32.MainScreen]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute() : super(MainRoute.name, path: '');

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i33.OpenSettingsScreen]
class OpenSettingsRoute extends _i11.PageRouteInfo<OpenSettingsRouteArgs> {
  OpenSettingsRoute({_i59.Key? key})
      : super(OpenSettingsRoute.name,
            path: 'settings', args: OpenSettingsRouteArgs(key: key));

  static const String name = 'OpenSettingsRoute';
}

class OpenSettingsRouteArgs {
  const OpenSettingsRouteArgs({this.key});

  final _i59.Key? key;

  @override
  String toString() {
    return 'OpenSettingsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i34.UpdateProfileScreen]
class UpdateProfileRoute extends _i11.PageRouteInfo<UpdateProfileRouteArgs> {
  UpdateProfileRoute({_i59.Key? key})
      : super(UpdateProfileRoute.name,
            path: 'settings/update-profile',
            args: UpdateProfileRouteArgs(key: key));

  static const String name = 'UpdateProfileRoute';
}

class UpdateProfileRouteArgs {
  const UpdateProfileRouteArgs({this.key});

  final _i59.Key? key;

  @override
  String toString() {
    return 'UpdateProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i35.EditNicknameScreen]
class EditNicknameRoute extends _i11.PageRouteInfo<EditNicknameRouteArgs> {
  EditNicknameRoute({_i59.Key? key, required _i63.User? user})
      : super(EditNicknameRoute.name,
            path: 'settings/update-profile/nickname',
            args: EditNicknameRouteArgs(key: key, user: user));

  static const String name = 'EditNicknameRoute';
}

class EditNicknameRouteArgs {
  const EditNicknameRouteArgs({this.key, required this.user});

  final _i59.Key? key;

  final _i63.User? user;

  @override
  String toString() {
    return 'EditNicknameRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i36.EditEmailScreen]
class EditEmailRoute extends _i11.PageRouteInfo<EditEmailRouteArgs> {
  EditEmailRoute({_i59.Key? key, required _i63.User? user})
      : super(EditEmailRoute.name,
            path: 'settings/update-profile/email',
            args: EditEmailRouteArgs(key: key, user: user));

  static const String name = 'EditEmailRoute';
}

class EditEmailRouteArgs {
  const EditEmailRouteArgs({this.key, required this.user});

  final _i59.Key? key;

  final _i63.User? user;

  @override
  String toString() {
    return 'EditEmailRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i37.EditPhotoScreen]
class EditPhotoRoute extends _i11.PageRouteInfo<EditPhotoRouteArgs> {
  EditPhotoRoute({_i59.Key? key, _i64.Uint8List? imageBytes})
      : super(EditPhotoRoute.name,
            path: 'settings/update-profile/photo',
            args: EditPhotoRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'EditPhotoRoute';
}

class EditPhotoRouteArgs {
  const EditPhotoRouteArgs({this.key, this.imageBytes});

  final _i59.Key? key;

  final _i64.Uint8List? imageBytes;

  @override
  String toString() {
    return 'EditPhotoRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i38.DeleteAccountScreen]
class DeleteAccountRoute extends _i11.PageRouteInfo<void> {
  const DeleteAccountRoute()
      : super(DeleteAccountRoute.name, path: 'settings/update-profile/delete');

  static const String name = 'DeleteAccountRoute';
}

/// generated route for
/// [_i39.CameraPhotoTakenScreen]
class CameraPhotoTakenRoute
    extends _i11.PageRouteInfo<CameraPhotoTakenRouteArgs> {
  CameraPhotoTakenRoute({_i59.Key? key, required _i64.Uint8List imageBytes})
      : super(CameraPhotoTakenRoute.name,
            path: 'settings/update-profile/photo/camera-taken',
            args: CameraPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'CameraPhotoTakenRoute';
}

class CameraPhotoTakenRouteArgs {
  const CameraPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i59.Key? key;

  final _i64.Uint8List imageBytes;

  @override
  String toString() {
    return 'CameraPhotoTakenRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i40.GalleryPhotoTakenScreen]
class GalleryPhotoTakenRoute
    extends _i11.PageRouteInfo<GalleryPhotoTakenRouteArgs> {
  GalleryPhotoTakenRoute({_i59.Key? key, required _i64.Uint8List imageBytes})
      : super(GalleryPhotoTakenRoute.name,
            path: 'settings/update-profile/photo/gallery-taken',
            args: GalleryPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'GalleryPhotoTakenRoute';
}

class GalleryPhotoTakenRouteArgs {
  const GalleryPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i59.Key? key;

  final _i64.Uint8List imageBytes;

  @override
  String toString() {
    return 'GalleryPhotoTakenRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i41.PhotoCroppedResultScreen]
class PhotoCroppedResultRoute
    extends _i11.PageRouteInfo<PhotoCroppedResultRouteArgs> {
  PhotoCroppedResultRoute({_i59.Key? key, required _i64.Uint8List imageBytes})
      : super(PhotoCroppedResultRoute.name,
            path: 'settings/update-profile/photo/photo-cropped-result',
            args:
                PhotoCroppedResultRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'PhotoCroppedResultRoute';
}

class PhotoCroppedResultRouteArgs {
  const PhotoCroppedResultRouteArgs({this.key, required this.imageBytes});

  final _i59.Key? key;

  final _i64.Uint8List imageBytes;

  @override
  String toString() {
    return 'PhotoCroppedResultRouteArgs{key: $key, imageBytes: $imageBytes}';
  }
}

/// generated route for
/// [_i42.LeaderboardScreen]
class LeaderboardRoute extends _i11.PageRouteInfo<void> {
  const LeaderboardRoute()
      : super(LeaderboardRoute.name, path: 'settings/leaderboard');

  static const String name = 'LeaderboardRoute';
}

/// generated route for
/// [_i43.PointsHelpScreen]
class PointsHelpRoute extends _i11.PageRouteInfo<void> {
  const PointsHelpRoute()
      : super(PointsHelpRoute.name, path: 'settings/points-help');

  static const String name = 'PointsHelpRoute';
}

/// generated route for
/// [_i44.ExaminationDetailScreen]
class ExaminationDetailRoute
    extends _i11.PageRouteInfo<ExaminationDetailRouteArgs> {
  ExaminationDetailRoute(
      {_i59.Key? key,
      required _i65.CategorizedExamination categorizedExamination})
      : super(ExaminationDetailRoute.name,
            path: 'prevention-detail',
            args: ExaminationDetailRouteArgs(
                key: key, categorizedExamination: categorizedExamination));

  static const String name = 'ExaminationDetailRoute';
}

class ExaminationDetailRouteArgs {
  const ExaminationDetailRouteArgs(
      {this.key, required this.categorizedExamination});

  final _i59.Key? key;

  final _i65.CategorizedExamination categorizedExamination;

  @override
  String toString() {
    return 'ExaminationDetailRouteArgs{key: $key, categorizedExamination: $categorizedExamination}';
  }
}

/// generated route for
/// [_i45.AchievementScreen]
class AchievementRoute extends _i11.PageRouteInfo<AchievementRouteArgs> {
  AchievementRoute(
      {_i59.Key? key,
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

  final _i59.Key? key;

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
/// [_i46.DatePickerScreen]
class DatePickerRoute extends _i11.PageRouteInfo<DatePickerRouteArgs> {
  DatePickerRoute(
      {_i59.Key? key,
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

  final _i59.Key? key;

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
/// [_i47.CalendarPermissionInfoScreen]
class CalendarPermissionInfoRoute
    extends _i11.PageRouteInfo<CalendarPermissionInfoRouteArgs> {
  CalendarPermissionInfoRoute(
      {_i59.Key? key, required _i62.PreventionStatus examinationRecord})
      : super(CalendarPermissionInfoRoute.name,
            path: 'calendar/permission',
            args: CalendarPermissionInfoRouteArgs(
                key: key, examinationRecord: examinationRecord));

  static const String name = 'CalendarPermissionInfoRoute';
}

class CalendarPermissionInfoRouteArgs {
  const CalendarPermissionInfoRouteArgs(
      {this.key, required this.examinationRecord});

  final _i59.Key? key;

  final _i62.PreventionStatus examinationRecord;

  @override
  String toString() {
    return 'CalendarPermissionInfoRouteArgs{key: $key, examinationRecord: $examinationRecord}';
  }
}

/// generated route for
/// [_i48.CalendarListScreen]
class CalendarListRoute extends _i11.PageRouteInfo<CalendarListRouteArgs> {
  CalendarListRoute(
      {_i59.Key? key, required _i62.PreventionStatus examinationRecord})
      : super(CalendarListRoute.name,
            path: 'calendar/list',
            args: CalendarListRouteArgs(
                key: key, examinationRecord: examinationRecord));

  static const String name = 'CalendarListRoute';
}

class CalendarListRouteArgs {
  const CalendarListRouteArgs({this.key, required this.examinationRecord});

  final _i59.Key? key;

  final _i62.PreventionStatus examinationRecord;

  @override
  String toString() {
    return 'CalendarListRouteArgs{key: $key, examinationRecord: $examinationRecord}';
  }
}

/// generated route for
/// [_i49.ChangeLastVisitScreen]
class ChangeLastVisitRoute
    extends _i11.PageRouteInfo<ChangeLastVisitRouteArgs> {
  ChangeLastVisitRoute(
      {_i59.Key? key,
      required DateTime originalDate,
      required String title,
      required _i62.ExaminationTypeEnum examinationType,
      required String? uuid,
      required _i66.ExaminationCategory status})
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

  final _i59.Key? key;

  final DateTime originalDate;

  final String title;

  final _i62.ExaminationTypeEnum examinationType;

  final String? uuid;

  final _i66.ExaminationCategory status;

  @override
  String toString() {
    return 'ChangeLastVisitRouteArgs{key: $key, originalDate: $originalDate, title: $title, examinationType: $examinationType, uuid: $uuid, status: $status}';
  }
}

/// generated route for
/// [_i50.NewDateScreen]
class NewDateRoute extends _i11.PageRouteInfo<NewDateRouteArgs> {
  NewDateRoute(
      {_i59.Key? key,
      required _i65.CategorizedExamination categorizedExamination,
      bool showCancelIcon = true})
      : super(NewDateRoute.name,
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

  final _i59.Key? key;

  final _i65.CategorizedExamination categorizedExamination;

  final bool showCancelIcon;

  @override
  String toString() {
    return 'NewDateRouteArgs{key: $key, categorizedExamination: $categorizedExamination, showCancelIcon: $showCancelIcon}';
  }
}

/// generated route for
/// [_i51.NewTimeScreen]
class NewTimeRoute extends _i11.PageRouteInfo<NewTimeRouteArgs> {
  NewTimeRoute(
      {_i59.Key? key,
      required _i65.CategorizedExamination categorizedExamination,
      required DateTime newDate})
      : super(NewTimeRoute.name,
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

  final _i59.Key? key;

  final _i65.CategorizedExamination categorizedExamination;

  final DateTime newDate;

  @override
  String toString() {
    return 'NewTimeRouteArgs{key: $key, categorizedExamination: $categorizedExamination, newDate: $newDate}';
  }
}

/// generated route for
/// [_i52.ChangeDateScreen]
class ChangeDateRoute extends _i11.PageRouteInfo<ChangeDateRouteArgs> {
  ChangeDateRoute(
      {_i59.Key? key,
      required _i65.CategorizedExamination categorizedExamination})
      : super(ChangeDateRoute.name,
            path: 'checkup/change-date',
            args: ChangeDateRouteArgs(
                key: key, categorizedExamination: categorizedExamination));

  static const String name = 'ChangeDateRoute';
}

class ChangeDateRouteArgs {
  const ChangeDateRouteArgs({this.key, required this.categorizedExamination});

  final _i59.Key? key;

  final _i65.CategorizedExamination categorizedExamination;

  @override
  String toString() {
    return 'ChangeDateRouteArgs{key: $key, categorizedExamination: $categorizedExamination}';
  }
}

/// generated route for
/// [_i53.ChangeTimeScreen]
class ChangeTimeRoute extends _i11.PageRouteInfo<ChangeTimeRouteArgs> {
  ChangeTimeRoute(
      {_i59.Key? key,
      required _i65.CategorizedExamination categorizedExamination,
      required DateTime newDate,
      required String? uuid})
      : super(ChangeTimeRoute.name,
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

  final _i59.Key? key;

  final _i65.CategorizedExamination categorizedExamination;

  final DateTime newDate;

  final String? uuid;

  @override
  String toString() {
    return 'ChangeTimeRouteArgs{key: $key, categorizedExamination: $categorizedExamination, newDate: $newDate, uuid: $uuid}';
  }
}

/// generated route for
/// [_i54.SelfExaminationDetailScreen]
class SelfExaminationDetailRoute
    extends _i11.PageRouteInfo<SelfExaminationDetailRouteArgs> {
  SelfExaminationDetailRoute({_i59.Key? key, required _i62.Sex sex})
      : super(SelfExaminationDetailRoute.name,
            path: 'self-examination/detail',
            args: SelfExaminationDetailRouteArgs(key: key, sex: sex));

  static const String name = 'SelfExaminationDetailRoute';
}

class SelfExaminationDetailRouteArgs {
  const SelfExaminationDetailRouteArgs({this.key, required this.sex});

  final _i59.Key? key;

  final _i62.Sex sex;

  @override
  String toString() {
    return 'SelfExaminationDetailRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i55.EducationalVideoScreen]
class EducationalVideoRoute
    extends _i11.PageRouteInfo<EducationalVideoRouteArgs> {
  EducationalVideoRoute({_i59.Key? key, required _i62.Sex sex})
      : super(EducationalVideoRoute.name,
            path: 'self-examination/detail/educational-video',
            args: EducationalVideoRouteArgs(key: key, sex: sex));

  static const String name = 'EducationalVideoRoute';
}

class EducationalVideoRouteArgs {
  const EducationalVideoRouteArgs({this.key, required this.sex});

  final _i59.Key? key;

  final _i62.Sex sex;

  @override
  String toString() {
    return 'EducationalVideoRouteArgs{key: $key, sex: $sex}';
  }
}

/// generated route for
/// [_i56.HasFindingScreen]
class HasFindingRoute extends _i11.PageRouteInfo<void> {
  const HasFindingRoute()
      : super(HasFindingRoute.name,
            path: 'self-examination/detail/has-finding');

  static const String name = 'HasFindingRoute';
}

/// generated route for
/// [_i57.NoFindingScreen]
class NoFindingRoute extends _i11.PageRouteInfo<void> {
  const NoFindingRoute()
      : super(NoFindingRoute.name, path: 'self-examination/detail/no-finding');

  static const String name = 'NoFindingRoute';
}

/// generated route for
/// [_i58.ProgressRewardScreen]
class ProgressRewardRoute extends _i11.PageRouteInfo<void> {
  const ProgressRewardRoute()
      : super(ProgressRewardRoute.name,
            path: 'self-examination/detail/progress-reward');

  static const String name = 'ProgressRewardRoute';
}
