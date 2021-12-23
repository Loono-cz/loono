// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'dart:typed_data' as _i39;

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../helpers/sex_extensions.dart' as _i40;
import '../models/categorized_examination.dart' as _i37;
import '../models/firebase_user.dart' as _i36;
import '../services/db/database.dart' as _i38;
import '../ui/screens/create_account.dart' as _i5;
import '../ui/screens/dentist_achievement.dart' as _i34;
import '../ui/screens/general_practicioner_achievement.dart' as _i27;
import '../ui/screens/gynecology_achievement.dart' as _i31;
import '../ui/screens/login.dart' as _i8;
import '../ui/screens/logout.dart' as _i9;
import '../ui/screens/main/main_screen.dart' as _i10;
import '../ui/screens/onboarding/allow_notifications.dart' as _i29;
import '../ui/screens/onboarding/birthdate.dart' as _i25;
import '../ui/screens/onboarding/carousel/carousel.dart' as _i23;
import '../ui/screens/onboarding/doctors/dentist.dart' as _i33;
import '../ui/screens/onboarding/doctors/dentist_date.dart' as _i35;
import '../ui/screens/onboarding/doctors/general_practicioner.dart' as _i26;
import '../ui/screens/onboarding/doctors/general_practitioner_date.dart'
    as _i28;
import '../ui/screens/onboarding/doctors/gynecology.dart' as _i30;
import '../ui/screens/onboarding/doctors/gynecology_date.dart' as _i32;
import '../ui/screens/onboarding/fallback_account/email.dart' as _i7;
import '../ui/screens/onboarding/fallback_account/nickname.dart' as _i6;
import '../ui/screens/onboarding/gender.dart' as _i24;
import '../ui/screens/onboarding/onboarding_wrapper_screen.dart' as _i4;
import '../ui/screens/prevention/examination_detail/examination_screen.dart'
    as _i11;
import '../ui/screens/settings/camera_photo_taken.dart' as _i17;
import '../ui/screens/settings/edit_email.dart' as _i15;
import '../ui/screens/settings/edit_nickname.dart' as _i14;
import '../ui/screens/settings/edit_photo.dart' as _i16;
import '../ui/screens/settings/gallery_photo_taken.dart' as _i18;
import '../ui/screens/settings/leaderboard.dart' as _i20;
import '../ui/screens/settings/open_settings.dart' as _i12;
import '../ui/screens/settings/photo_cropped_result.dart' as _i19;
import '../ui/screens/settings/points_help.dart' as _i21;
import '../ui/screens/settings/update_profile.dart' as _i13;
import '../ui/screens/welcome.dart' as _i22;
import 'guards/check_is_logged_in.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i2.GlobalKey<_i2.NavigatorState>? navigatorKey,
      required this.checkIsLoggedIn})
      : super(navigatorKey);

  final _i3.CheckIsLoggedIn checkIsLoggedIn;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MainScreenRouter.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterScreen());
    },
    OnboardingWrapperRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.OnboardingWrapperScreen());
    },
    CreateAccountRoute.name: (routeData) {
      final args = routeData.argsAs<CreateAccountRouteArgs>(
          orElse: () => const CreateAccountRouteArgs());
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.CreateAccountScreen(key: args.key));
    },
    NicknameRoute.name: (routeData) {
      final args = routeData.argsAs<NicknameRouteArgs>(
          orElse: () => const NicknameRouteArgs());
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.NicknameScreen(key: args.key, authUser: args.authUser));
    },
    EmailRoute.name: (routeData) {
      final args = routeData.argsAs<EmailRouteArgs>(
          orElse: () => const EmailRouteArgs());
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.EmailScreen(key: args.key, authUser: args.authUser));
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.LoginScreen(key: args.key));
    },
    LogoutRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.LogoutScreen());
    },
    MainRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.MainScreen());
    },
    ExaminationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ExaminationDetailRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i11.ExaminationDetailScreen(
              key: args.key,
              categorizedExamination: args.categorizedExamination),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OpenSettingsRoute.name: (routeData) {
      final args = routeData.argsAs<OpenSettingsRouteArgs>(
          orElse: () => const OpenSettingsRouteArgs());
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i12.OpenSettingsScreen(key: args.key),
          transitionsBuilder: _i1.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    UpdateProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateProfileRouteArgs>(
          orElse: () => const UpdateProfileRouteArgs());
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i13.UpdateProfileScreen(key: args.key),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditNicknameRoute.name: (routeData) {
      final args = routeData.argsAs<EditNicknameRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i14.EditNicknameScreen(key: args.key, user: args.user),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditEmailRoute.name: (routeData) {
      final args = routeData.argsAs<EditEmailRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i15.EditEmailScreen(key: args.key, user: args.user),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditPhotoRoute.name: (routeData) {
      final args = routeData.argsAs<EditPhotoRouteArgs>(
          orElse: () => const EditPhotoRouteArgs());
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child:
              _i16.EditPhotoScreen(key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CameraPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<CameraPhotoTakenRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i17.CameraPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GalleryPhotoTakenRoute.name: (routeData) {
      final args = routeData.argsAs<GalleryPhotoTakenRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i18.GalleryPhotoTakenScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    PhotoCroppedResultRoute.name: (routeData) {
      final args = routeData.argsAs<PhotoCroppedResultRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i19.PhotoCroppedResultScreen(
              key: args.key, imageBytes: args.imageBytes),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    LeaderboardRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i20.LeaderboardScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    PointsHelpRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i21.PointsHelpScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    WelcomeRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i22.WelcomeScreen());
    },
    OnboardingCarouselRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i23.OnboardingCarouselScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGenderRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i24.OnboardingGenderScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnBoardingBirthdateRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingBirthdateRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i25.OnBoardingBirthdateScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGeneralPracticionerRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGeneralPracticionerRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i26.OnboardingGeneralPracticionerScreen(
              key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPracticionerAchievementRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i27.GeneralPracticionerAchievementScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPractitionerDateRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i28.GeneralPractitionerDateScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AllowNotificationsRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i29.AllowNotificationsScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGynecologyRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGynecologyRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i30.OnboardingGynecologyScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyAchievementRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i31.GynecologyAchievementScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyDateRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i32.GynecologyDateScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingDentistRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingDentistRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i33.OnboardingDentistScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistAchievementRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i34.DentistAchievementScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistDateRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i35.DentistDateScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: 'main', fullMatch: true),
        _i1.RouteConfig(MainScreenRouter.name, path: 'main', guards: [
          checkIsLoggedIn
        ], children: [
          _i1.RouteConfig(MainRoute.name, path: ''),
          _i1.RouteConfig(ExaminationDetailRoute.name,
              path: 'prevention-detail'),
          _i1.RouteConfig(OpenSettingsRoute.name, path: 'settings'),
          _i1.RouteConfig(UpdateProfileRoute.name,
              path: 'settings/update-profile'),
          _i1.RouteConfig(EditNicknameRoute.name,
              path: 'settings/update-profile/nickname'),
          _i1.RouteConfig(EditEmailRoute.name,
              path: 'settings/update-profile/email'),
          _i1.RouteConfig(EditPhotoRoute.name,
              path: 'settings/update-profile/photo'),
          _i1.RouteConfig(CameraPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/camera-taken'),
          _i1.RouteConfig(GalleryPhotoTakenRoute.name,
              path: 'settings/update-profile/photo/gallery-taken'),
          _i1.RouteConfig(PhotoCroppedResultRoute.name,
              path: 'settings/update-profile/photo/photo-cropped-result'),
          _i1.RouteConfig(LeaderboardRoute.name, path: 'settings/leaderboard'),
          _i1.RouteConfig(PointsHelpRoute.name, path: 'settings/points-help')
        ]),
        _i1.RouteConfig(OnboardingWrapperRoute.name,
            path: 'onboarding',
            children: [
              _i1.RouteConfig(WelcomeRoute.name, path: 'welcome'),
              _i1.RouteConfig(OnboardingCarouselRoute.name, path: 'carousel'),
              _i1.RouteConfig(OnboardingGenderRoute.name, path: 'gender'),
              _i1.RouteConfig(OnBoardingBirthdateRoute.name, path: 'birthdate'),
              _i1.RouteConfig(OnboardingGeneralPracticionerRoute.name,
                  path: 'doctor/general-practicioner'),
              _i1.RouteConfig(GeneralPracticionerAchievementRoute.name,
                  path: 'general-practicioner-achievement'),
              _i1.RouteConfig(GeneralPractitionerDateRoute.name,
                  path: 'doctor/general-practitioner-date'),
              _i1.RouteConfig(AllowNotificationsRoute.name,
                  path: 'allow_notifications'),
              _i1.RouteConfig(OnboardingGynecologyRoute.name,
                  path: 'doctor/gynecology'),
              _i1.RouteConfig(GynecologyAchievementRoute.name,
                  path: 'gynecology_achievement'),
              _i1.RouteConfig(GynecologyDateRoute.name,
                  path: 'doctor/gynecology-date'),
              _i1.RouteConfig(OnboardingDentistRoute.name,
                  path: 'doctor/dentist'),
              _i1.RouteConfig(DentistAchievementRoute.name,
                  path: 'dentist_achievement'),
              _i1.RouteConfig(DentistDateRoute.name,
                  path: 'doctor/dentist-date')
            ]),
        _i1.RouteConfig(CreateAccountRoute.name, path: 'create-account'),
        _i1.RouteConfig(NicknameRoute.name, path: 'fallback_account/name'),
        _i1.RouteConfig(EmailRoute.name, path: 'fallback_account/email'),
        _i1.RouteConfig(LoginRoute.name, path: 'login'),
        _i1.RouteConfig(LogoutRoute.name, path: 'logout')
      ];
}

class MainScreenRouter extends _i1.PageRouteInfo<void> {
  const MainScreenRouter({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'main', initialChildren: children);

  static const String name = 'MainScreenRouter';
}

class OnboardingWrapperRoute extends _i1.PageRouteInfo<void> {
  const OnboardingWrapperRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'onboarding', initialChildren: children);

  static const String name = 'OnboardingWrapperRoute';
}

class CreateAccountRoute extends _i1.PageRouteInfo<CreateAccountRouteArgs> {
  CreateAccountRoute({_i2.Key? key})
      : super(name,
            path: 'create-account', args: CreateAccountRouteArgs(key: key));

  static const String name = 'CreateAccountRoute';
}

class CreateAccountRouteArgs {
  const CreateAccountRouteArgs({this.key});

  final _i2.Key? key;
}

class NicknameRoute extends _i1.PageRouteInfo<NicknameRouteArgs> {
  NicknameRoute({_i2.Key? key, _i36.AuthUser? authUser})
      : super(name,
            path: 'fallback_account/name',
            args: NicknameRouteArgs(key: key, authUser: authUser));

  static const String name = 'NicknameRoute';
}

class NicknameRouteArgs {
  const NicknameRouteArgs({this.key, this.authUser});

  final _i2.Key? key;

  final _i36.AuthUser? authUser;
}

class EmailRoute extends _i1.PageRouteInfo<EmailRouteArgs> {
  EmailRoute({_i2.Key? key, _i36.AuthUser? authUser})
      : super(name,
            path: 'fallback_account/email',
            args: EmailRouteArgs(key: key, authUser: authUser));

  static const String name = 'EmailRoute';
}

class EmailRouteArgs {
  const EmailRouteArgs({this.key, this.authUser});

  final _i2.Key? key;

  final _i36.AuthUser? authUser;
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

class MainRoute extends _i1.PageRouteInfo<void> {
  const MainRoute() : super(name, path: '');

  static const String name = 'MainRoute';
}

class ExaminationDetailRoute
    extends _i1.PageRouteInfo<ExaminationDetailRouteArgs> {
  ExaminationDetailRoute(
      {_i2.Key? key,
      required _i37.CategorizedExamination categorizedExamination})
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

  final _i37.CategorizedExamination categorizedExamination;
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
  EditNicknameRoute({_i2.Key? key, required _i38.User? user})
      : super(name,
            path: 'settings/update-profile/nickname',
            args: EditNicknameRouteArgs(key: key, user: user));

  static const String name = 'EditNicknameRoute';
}

class EditNicknameRouteArgs {
  const EditNicknameRouteArgs({this.key, required this.user});

  final _i2.Key? key;

  final _i38.User? user;
}

class EditEmailRoute extends _i1.PageRouteInfo<EditEmailRouteArgs> {
  EditEmailRoute({_i2.Key? key, required _i38.User? user})
      : super(name,
            path: 'settings/update-profile/email',
            args: EditEmailRouteArgs(key: key, user: user));

  static const String name = 'EditEmailRoute';
}

class EditEmailRouteArgs {
  const EditEmailRouteArgs({this.key, required this.user});

  final _i2.Key? key;

  final _i38.User? user;
}

class EditPhotoRoute extends _i1.PageRouteInfo<EditPhotoRouteArgs> {
  EditPhotoRoute({_i2.Key? key, _i39.Uint8List? imageBytes})
      : super(name,
            path: 'settings/update-profile/photo',
            args: EditPhotoRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'EditPhotoRoute';
}

class EditPhotoRouteArgs {
  const EditPhotoRouteArgs({this.key, this.imageBytes});

  final _i2.Key? key;

  final _i39.Uint8List? imageBytes;
}

class CameraPhotoTakenRoute
    extends _i1.PageRouteInfo<CameraPhotoTakenRouteArgs> {
  CameraPhotoTakenRoute({_i2.Key? key, required _i39.Uint8List imageBytes})
      : super(name,
            path: 'settings/update-profile/photo/camera-taken',
            args: CameraPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'CameraPhotoTakenRoute';
}

class CameraPhotoTakenRouteArgs {
  const CameraPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i2.Key? key;

  final _i39.Uint8List imageBytes;
}

class GalleryPhotoTakenRoute
    extends _i1.PageRouteInfo<GalleryPhotoTakenRouteArgs> {
  GalleryPhotoTakenRoute({_i2.Key? key, required _i39.Uint8List imageBytes})
      : super(name,
            path: 'settings/update-profile/photo/gallery-taken',
            args: GalleryPhotoTakenRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'GalleryPhotoTakenRoute';
}

class GalleryPhotoTakenRouteArgs {
  const GalleryPhotoTakenRouteArgs({this.key, required this.imageBytes});

  final _i2.Key? key;

  final _i39.Uint8List imageBytes;
}

class PhotoCroppedResultRoute
    extends _i1.PageRouteInfo<PhotoCroppedResultRouteArgs> {
  PhotoCroppedResultRoute({_i2.Key? key, required _i39.Uint8List imageBytes})
      : super(name,
            path: 'settings/update-profile/photo/photo-cropped-result',
            args:
                PhotoCroppedResultRouteArgs(key: key, imageBytes: imageBytes));

  static const String name = 'PhotoCroppedResultRoute';
}

class PhotoCroppedResultRouteArgs {
  const PhotoCroppedResultRouteArgs({this.key, required this.imageBytes});

  final _i2.Key? key;

  final _i39.Uint8List imageBytes;
}

class LeaderboardRoute extends _i1.PageRouteInfo<void> {
  const LeaderboardRoute() : super(name, path: 'settings/leaderboard');

  static const String name = 'LeaderboardRoute';
}

class PointsHelpRoute extends _i1.PageRouteInfo<void> {
  const PointsHelpRoute() : super(name, path: 'settings/points-help');

  static const String name = 'PointsHelpRoute';
}

class WelcomeRoute extends _i1.PageRouteInfo<void> {
  const WelcomeRoute() : super(name, path: 'welcome');

  static const String name = 'WelcomeRoute';
}

class OnboardingCarouselRoute extends _i1.PageRouteInfo<void> {
  const OnboardingCarouselRoute() : super(name, path: 'carousel');

  static const String name = 'OnboardingCarouselRoute';
}

class OnboardingGenderRoute extends _i1.PageRouteInfo<void> {
  const OnboardingGenderRoute() : super(name, path: 'gender');

  static const String name = 'OnboardingGenderRoute';
}

class OnBoardingBirthdateRoute
    extends _i1.PageRouteInfo<OnBoardingBirthdateRouteArgs> {
  OnBoardingBirthdateRoute({_i2.Key? key, required _i40.Sex sex})
      : super(name,
            path: 'birthdate',
            args: OnBoardingBirthdateRouteArgs(key: key, sex: sex));

  static const String name = 'OnBoardingBirthdateRoute';
}

class OnBoardingBirthdateRouteArgs {
  const OnBoardingBirthdateRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i40.Sex sex;
}

class OnboardingGeneralPracticionerRoute
    extends _i1.PageRouteInfo<OnboardingGeneralPracticionerRouteArgs> {
  OnboardingGeneralPracticionerRoute({_i2.Key? key, required _i40.Sex sex})
      : super(name,
            path: 'doctor/general-practicioner',
            args: OnboardingGeneralPracticionerRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGeneralPracticionerRoute';
}

class OnboardingGeneralPracticionerRouteArgs {
  const OnboardingGeneralPracticionerRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i40.Sex sex;
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
  const AllowNotificationsRoute() : super(name, path: 'allow_notifications');

  static const String name = 'AllowNotificationsRoute';
}

class OnboardingGynecologyRoute
    extends _i1.PageRouteInfo<OnboardingGynecologyRouteArgs> {
  OnboardingGynecologyRoute({_i2.Key? key, required _i40.Sex sex})
      : super(name,
            path: 'doctor/gynecology',
            args: OnboardingGynecologyRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGynecologyRoute';
}

class OnboardingGynecologyRouteArgs {
  const OnboardingGynecologyRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i40.Sex sex;
}

class GynecologyAchievementRoute extends _i1.PageRouteInfo<void> {
  const GynecologyAchievementRoute()
      : super(name, path: 'gynecology_achievement');

  static const String name = 'GynecologyAchievementRoute';
}

class GynecologyDateRoute extends _i1.PageRouteInfo<void> {
  const GynecologyDateRoute() : super(name, path: 'doctor/gynecology-date');

  static const String name = 'GynecologyDateRoute';
}

class OnboardingDentistRoute
    extends _i1.PageRouteInfo<OnboardingDentistRouteArgs> {
  OnboardingDentistRoute({_i2.Key? key, required _i40.Sex sex})
      : super(name,
            path: 'doctor/dentist',
            args: OnboardingDentistRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingDentistRoute';
}

class OnboardingDentistRouteArgs {
  const OnboardingDentistRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i40.Sex sex;
}

class DentistAchievementRoute extends _i1.PageRouteInfo<void> {
  const DentistAchievementRoute() : super(name, path: 'dentist_achievement');

  static const String name = 'DentistAchievementRoute';
}

class DentistDateRoute extends _i1.PageRouteInfo<void> {
  const DentistDateRoute() : super(name, path: 'doctor/dentist-date');

  static const String name = 'DentistDateRoute';
}
