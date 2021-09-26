// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../helpers/sex_extensions.dart' as _i24;
import '../ui/screens/create_account.dart' as _i7;
import '../ui/screens/dentist_achievement.dart' as _i22;
import '../ui/screens/general_practicioner_achievement.dart' as _i15;
import '../ui/screens/gynecology_achievement.dart' as _i19;
import '../ui/screens/login.dart' as _i10;
import '../ui/screens/main/main_screen.dart' as _i11;
import '../ui/screens/onboarding/allow_notifications.dart' as _i17;
import '../ui/screens/onboarding/birthdate.dart' as _i13;
import '../ui/screens/onboarding/carousel/carousel.dart' as _i5;
import '../ui/screens/onboarding/doctors/dentist.dart' as _i21;
import '../ui/screens/onboarding/doctors/dentist_date.dart' as _i23;
import '../ui/screens/onboarding/doctors/general_practicioner.dart' as _i14;
import '../ui/screens/onboarding/doctors/general_practitioner_date.dart'
    as _i16;
import '../ui/screens/onboarding/doctors/gynecology.dart' as _i18;
import '../ui/screens/onboarding/doctors/gynecology_date.dart' as _i20;
import '../ui/screens/onboarding/fallback_account/email.dart' as _i9;
import '../ui/screens/onboarding/fallback_account/nickname.dart' as _i8;
import '../ui/screens/onboarding/gender.dart' as _i12;
import '../ui/screens/onboarding/onboarding_wrapper_screen.dart' as _i6;
import '../ui/screens/welcome.dart' as _i4;
import 'guards/check_is_logged_in.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i2.GlobalKey<_i2.NavigatorState>? navigatorKey,
      required this.checkIsLoggedIn})
      : super(navigatorKey);

  final _i3.CheckIsLoggedIn checkIsLoggedIn;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    WelcomeRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.WelcomeScreen());
    },
    OnboardingCarouselRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.OnboardingCarouselScreen());
    },
    OnboardingWrapperRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i6.OnboardingWrapperScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    CreateAccountRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.CreateAccountScreen());
    },
    NicknameRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.NicknameScreen());
    },
    EmailRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.EmailScreen());
    },
    LoginRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.LoginScreen());
    },
    MainRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.MainScreen());
    },
    OnboardingGenderRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i12.OnboardingGenderScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnBoardingBirthdateRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingBirthdateRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i13.OnBoardingBirthdateScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGeneralPracticionerRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGeneralPracticionerRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i14.OnboardingGeneralPracticionerScreen(
              key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPracticionerAchievementRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i15.GeneralPracticionerAchievementScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPractitionerDateRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i16.GeneralPractitionerDateScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AllowNotificationsRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i17.AllowNotificationsScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGynecologyRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGynecologyRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i18.OnboardingGynecologyScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyAchievementRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i19.GynecologyAchievementScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyDateRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i20.GynecologyDateScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingDentistRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingDentistRouteArgs>();
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: _i21.OnboardingDentistScreen(key: args.key, sex: args.sex),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistAchievementRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i22.DentistAchievementScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistDateRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i23.DentistDateScreen(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: 'main', fullMatch: true),
        _i1.RouteConfig(WelcomeRoute.name, path: 'welcome'),
        _i1.RouteConfig(OnboardingCarouselRoute.name,
            path: 'onboarding/carousel'),
        _i1.RouteConfig(OnboardingWrapperRoute.name,
            path: 'onboarding',
            children: [
              _i1.RouteConfig(OnboardingGenderRoute.name,
                  path: 'onboarding/gender'),
              _i1.RouteConfig(OnBoardingBirthdateRoute.name,
                  path: 'onboarding/birthdate'),
              _i1.RouteConfig(OnboardingGeneralPracticionerRoute.name,
                  path: 'onboarding/doctor/general-practicioner'),
              _i1.RouteConfig(GeneralPracticionerAchievementRoute.name,
                  path: 'general-practicioner-achievement'),
              _i1.RouteConfig(GeneralPractitionerDateRoute.name,
                  path: 'onboarding/doctor/general-practitioner-date'),
              _i1.RouteConfig(AllowNotificationsRoute.name,
                  path: 'onboarding/allow_notifications'),
              _i1.RouteConfig(OnboardingGynecologyRoute.name,
                  path: 'onboarding/doctor/gynecology'),
              _i1.RouteConfig(GynecologyAchievementRoute.name,
                  path: 'gynecology_achievement'),
              _i1.RouteConfig(GynecologyDateRoute.name,
                  path: 'onboarding/doctor/gynecology-date'),
              _i1.RouteConfig(OnboardingDentistRoute.name,
                  path: 'onboarding/doctor/dentist'),
              _i1.RouteConfig(DentistAchievementRoute.name,
                  path: 'dentist_achievement'),
              _i1.RouteConfig(DentistDateRoute.name,
                  path: 'onboarding/doctor/dentist-date')
            ]),
        _i1.RouteConfig(CreateAccountRoute.name, path: 'create-account'),
        _i1.RouteConfig(NicknameRoute.name, path: 'fallback_account/name'),
        _i1.RouteConfig(EmailRoute.name, path: 'fallback_account/email'),
        _i1.RouteConfig(LoginRoute.name, path: 'login'),
        _i1.RouteConfig(MainRoute.name, path: 'main', guards: [checkIsLoggedIn])
      ];
}

class WelcomeRoute extends _i1.PageRouteInfo<void> {
  const WelcomeRoute() : super(name, path: 'welcome');

  static const String name = 'WelcomeRoute';
}

class OnboardingCarouselRoute extends _i1.PageRouteInfo<void> {
  const OnboardingCarouselRoute() : super(name, path: 'onboarding/carousel');

  static const String name = 'OnboardingCarouselRoute';
}

class OnboardingWrapperRoute extends _i1.PageRouteInfo<void> {
  const OnboardingWrapperRoute({List<_i1.PageRouteInfo>? children})
      : super(name, path: 'onboarding', initialChildren: children);

  static const String name = 'OnboardingWrapperRoute';
}

class CreateAccountRoute extends _i1.PageRouteInfo<void> {
  const CreateAccountRoute() : super(name, path: 'create-account');

  static const String name = 'CreateAccountRoute';
}

class NicknameRoute extends _i1.PageRouteInfo<void> {
  const NicknameRoute() : super(name, path: 'fallback_account/name');

  static const String name = 'NicknameRoute';
}

class EmailRoute extends _i1.PageRouteInfo<void> {
  const EmailRoute() : super(name, path: 'fallback_account/email');

  static const String name = 'EmailRoute';
}

class LoginRoute extends _i1.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: 'login');

  static const String name = 'LoginRoute';
}

class MainRoute extends _i1.PageRouteInfo<void> {
  const MainRoute() : super(name, path: 'main');

  static const String name = 'MainRoute';
}

class OnboardingGenderRoute extends _i1.PageRouteInfo<void> {
  const OnboardingGenderRoute() : super(name, path: 'onboarding/gender');

  static const String name = 'OnboardingGenderRoute';
}

class OnBoardingBirthdateRoute
    extends _i1.PageRouteInfo<OnBoardingBirthdateRouteArgs> {
  OnBoardingBirthdateRoute({_i2.Key? key, required _i24.Sex sex})
      : super(name,
            path: 'onboarding/birthdate',
            args: OnBoardingBirthdateRouteArgs(key: key, sex: sex));

  static const String name = 'OnBoardingBirthdateRoute';
}

class OnBoardingBirthdateRouteArgs {
  const OnBoardingBirthdateRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i24.Sex sex;
}

class OnboardingGeneralPracticionerRoute
    extends _i1.PageRouteInfo<OnboardingGeneralPracticionerRouteArgs> {
  OnboardingGeneralPracticionerRoute({_i2.Key? key, required _i24.Sex sex})
      : super(name,
            path: 'onboarding/doctor/general-practicioner',
            args: OnboardingGeneralPracticionerRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGeneralPracticionerRoute';
}

class OnboardingGeneralPracticionerRouteArgs {
  const OnboardingGeneralPracticionerRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i24.Sex sex;
}

class GeneralPracticionerAchievementRoute extends _i1.PageRouteInfo<void> {
  const GeneralPracticionerAchievementRoute()
      : super(name, path: 'general-practicioner-achievement');

  static const String name = 'GeneralPracticionerAchievementRoute';
}

class GeneralPractitionerDateRoute extends _i1.PageRouteInfo<void> {
  const GeneralPractitionerDateRoute()
      : super(name, path: 'onboarding/doctor/general-practitioner-date');

  static const String name = 'GeneralPractitionerDateRoute';
}

class AllowNotificationsRoute extends _i1.PageRouteInfo<void> {
  const AllowNotificationsRoute()
      : super(name, path: 'onboarding/allow_notifications');

  static const String name = 'AllowNotificationsRoute';
}

class OnboardingGynecologyRoute
    extends _i1.PageRouteInfo<OnboardingGynecologyRouteArgs> {
  OnboardingGynecologyRoute({_i2.Key? key, required _i24.Sex sex})
      : super(name,
            path: 'onboarding/doctor/gynecology',
            args: OnboardingGynecologyRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGynecologyRoute';
}

class OnboardingGynecologyRouteArgs {
  const OnboardingGynecologyRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i24.Sex sex;
}

class GynecologyAchievementRoute extends _i1.PageRouteInfo<void> {
  const GynecologyAchievementRoute()
      : super(name, path: 'gynecology_achievement');

  static const String name = 'GynecologyAchievementRoute';
}

class GynecologyDateRoute extends _i1.PageRouteInfo<void> {
  const GynecologyDateRoute()
      : super(name, path: 'onboarding/doctor/gynecology-date');

  static const String name = 'GynecologyDateRoute';
}

class OnboardingDentistRoute
    extends _i1.PageRouteInfo<OnboardingDentistRouteArgs> {
  OnboardingDentistRoute({_i2.Key? key, required _i24.Sex sex})
      : super(name,
            path: 'onboarding/doctor/dentist',
            args: OnboardingDentistRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingDentistRoute';
}

class OnboardingDentistRouteArgs {
  const OnboardingDentistRouteArgs({this.key, required this.sex});

  final _i2.Key? key;

  final _i24.Sex sex;
}

class DentistAchievementRoute extends _i1.PageRouteInfo<void> {
  const DentistAchievementRoute() : super(name, path: 'dentist_achievement');

  static const String name = 'DentistAchievementRoute';
}

class DentistDateRoute extends _i1.PageRouteInfo<void> {
  const DentistDateRoute()
      : super(name, path: 'onboarding/doctor/dentist-date');

  static const String name = 'DentistDateRoute';
}
