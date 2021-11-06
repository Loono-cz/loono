// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

part of 'auth_router.dart';

class _$AuthRouter extends RootStackRouter {
  _$AuthRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: LoginScreen(key: args.key));
    },
    CreateAccountRoute.name: (routeData) {
      final args = routeData.argsAs<CreateAccountRouteArgs>(
          orElse: () => const CreateAccountRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: CreateAccountScreen(key: args.key));
    },
    NicknameRoute.name: (routeData) {
      final args = routeData.argsAs<NicknameRouteArgs>(
          orElse: () => const NicknameRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: NicknameScreen(key: args.key, authUser: args.authUser));
    },
    EmailRoute.name: (routeData) {
      final args = routeData.argsAs<EmailRouteArgs>(
          orElse: () => const EmailRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: EmailScreen(key: args.key, authUser: args.authUser));
    },
    LogoutRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const LogoutScreen());
    },
    LoggedInRoute.name: (routeData) {
      final args = routeData.argsAs<LoggedInRouteArgs>(
          orElse: () => const LoggedInRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: LoggedInScreen(key: args.key));
    },
    OnboardingWrapperRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const OnboardingWrapperScreen());
    },
    WelcomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const WelcomeScreen());
    },
    OnboardingCarouselRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const OnboardingCarouselScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGenderRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const OnboardingGenderScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnBoardingBirthdateRoute.name: (routeData) {
      final args = routeData.argsAs<OnBoardingBirthdateRouteArgs>();
      return CustomPage<dynamic>(
          routeData: routeData,
          child: OnBoardingBirthdateScreen(key: args.key, sex: args.sex),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGeneralPracticionerRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGeneralPracticionerRouteArgs>();
      return CustomPage<dynamic>(
          routeData: routeData,
          child:
              OnboardingGeneralPracticionerScreen(key: args.key, sex: args.sex),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPracticionerAchievementRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const GeneralPracticionerAchievementScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GeneralPractitionerDateRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const GeneralPractitionerDateScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    AllowNotificationsRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const AllowNotificationsScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingGynecologyRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGynecologyRouteArgs>();
      return CustomPage<dynamic>(
          routeData: routeData,
          child: OnboardingGynecologyScreen(key: args.key, sex: args.sex),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyAchievementRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const GynecologyAchievementScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    GynecologyDateRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const GynecologyDateScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingDentistRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingDentistRouteArgs>();
      return CustomPage<dynamic>(
          routeData: routeData,
          child: OnboardingDentistScreen(key: args.key, sex: args.sex),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistAchievementRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const DentistAchievementScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    DentistDateRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const DentistDateScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(LoginRoute.name, path: 'login'),
        RouteConfig(CreateAccountRoute.name, path: 'create-account'),
        RouteConfig(NicknameRoute.name, path: 'fallback_account/name'),
        RouteConfig(EmailRoute.name, path: 'fallback_account/email'),
        RouteConfig(LogoutRoute.name, path: 'logout'),
        RouteConfig(LoggedInRoute.name, path: 'logged-in'),
        RouteConfig(OnboardingWrapperRoute.name, path: 'onboarding', children: [
          RouteConfig(WelcomeRoute.name,
              path: 'welcome', parent: OnboardingWrapperRoute.name),
          RouteConfig(OnboardingCarouselRoute.name,
              path: 'carousel', parent: OnboardingWrapperRoute.name),
          RouteConfig(OnboardingGenderRoute.name,
              path: 'gender', parent: OnboardingWrapperRoute.name),
          RouteConfig(OnBoardingBirthdateRoute.name,
              path: 'birthdate', parent: OnboardingWrapperRoute.name),
          RouteConfig(OnboardingGeneralPracticionerRoute.name,
              path: 'doctor/general-practicioner',
              parent: OnboardingWrapperRoute.name),
          RouteConfig(GeneralPracticionerAchievementRoute.name,
              path: 'general-practicioner-achievement',
              parent: OnboardingWrapperRoute.name),
          RouteConfig(GeneralPractitionerDateRoute.name,
              path: 'doctor/general-practitioner-date',
              parent: OnboardingWrapperRoute.name),
          RouteConfig(AllowNotificationsRoute.name,
              path: 'allow_notifications', parent: OnboardingWrapperRoute.name),
          RouteConfig(OnboardingGynecologyRoute.name,
              path: 'doctor/gynecology', parent: OnboardingWrapperRoute.name),
          RouteConfig(GynecologyAchievementRoute.name,
              path: 'gynecology_achievement',
              parent: OnboardingWrapperRoute.name),
          RouteConfig(GynecologyDateRoute.name,
              path: 'doctor/gynecology-date',
              parent: OnboardingWrapperRoute.name),
          RouteConfig(OnboardingDentistRoute.name,
              path: 'doctor/dentist', parent: OnboardingWrapperRoute.name),
          RouteConfig(DentistAchievementRoute.name,
              path: 'dentist_achievement', parent: OnboardingWrapperRoute.name),
          RouteConfig(DentistDateRoute.name,
              path: 'doctor/dentist-date', parent: OnboardingWrapperRoute.name)
        ])
      ];
}

/// generated route for [LoginScreen]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({Key? key})
      : super(name, path: 'login', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;
}

/// generated route for [CreateAccountScreen]
class CreateAccountRoute extends PageRouteInfo<CreateAccountRouteArgs> {
  CreateAccountRoute({Key? key})
      : super(name,
            path: 'create-account', args: CreateAccountRouteArgs(key: key));

  static const String name = 'CreateAccountRoute';
}

class CreateAccountRouteArgs {
  const CreateAccountRouteArgs({this.key});

  final Key? key;
}

/// generated route for [NicknameScreen]
class NicknameRoute extends PageRouteInfo<NicknameRouteArgs> {
  NicknameRoute({Key? key, AuthUser? authUser})
      : super(name,
            path: 'fallback_account/name',
            args: NicknameRouteArgs(key: key, authUser: authUser));

  static const String name = 'NicknameRoute';
}

class NicknameRouteArgs {
  const NicknameRouteArgs({this.key, this.authUser});

  final Key? key;

  final AuthUser? authUser;
}

/// generated route for [EmailScreen]
class EmailRoute extends PageRouteInfo<EmailRouteArgs> {
  EmailRoute({Key? key, AuthUser? authUser})
      : super(name,
            path: 'fallback_account/email',
            args: EmailRouteArgs(key: key, authUser: authUser));

  static const String name = 'EmailRoute';
}

class EmailRouteArgs {
  const EmailRouteArgs({this.key, this.authUser});

  final Key? key;

  final AuthUser? authUser;
}

/// generated route for [LogoutScreen]
class LogoutRoute extends PageRouteInfo<void> {
  const LogoutRoute() : super(name, path: 'logout');

  static const String name = 'LogoutRoute';
}

/// generated route for [LoggedInScreen]
class LoggedInRoute extends PageRouteInfo<LoggedInRouteArgs> {
  LoggedInRoute({Key? key})
      : super(name, path: 'logged-in', args: LoggedInRouteArgs(key: key));

  static const String name = 'LoggedInRoute';
}

class LoggedInRouteArgs {
  const LoggedInRouteArgs({this.key});

  final Key? key;
}

/// generated route for [OnboardingWrapperScreen]
class OnboardingWrapperRoute extends PageRouteInfo<void> {
  const OnboardingWrapperRoute({List<PageRouteInfo>? children})
      : super(name, path: 'onboarding', initialChildren: children);

  static const String name = 'OnboardingWrapperRoute';
}

/// generated route for [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute() : super(name, path: 'welcome');

  static const String name = 'WelcomeRoute';
}

/// generated route for [OnboardingCarouselScreen]
class OnboardingCarouselRoute extends PageRouteInfo<void> {
  const OnboardingCarouselRoute() : super(name, path: 'carousel');

  static const String name = 'OnboardingCarouselRoute';
}

/// generated route for [OnboardingGenderScreen]
class OnboardingGenderRoute extends PageRouteInfo<void> {
  const OnboardingGenderRoute() : super(name, path: 'gender');

  static const String name = 'OnboardingGenderRoute';
}

/// generated route for [OnBoardingBirthdateScreen]
class OnBoardingBirthdateRoute
    extends PageRouteInfo<OnBoardingBirthdateRouteArgs> {
  OnBoardingBirthdateRoute({Key? key, required Sex sex})
      : super(name,
            path: 'birthdate',
            args: OnBoardingBirthdateRouteArgs(key: key, sex: sex));

  static const String name = 'OnBoardingBirthdateRoute';
}

class OnBoardingBirthdateRouteArgs {
  const OnBoardingBirthdateRouteArgs({this.key, required this.sex});

  final Key? key;

  final Sex sex;
}

/// generated route for [OnboardingGeneralPracticionerScreen]
class OnboardingGeneralPracticionerRoute
    extends PageRouteInfo<OnboardingGeneralPracticionerRouteArgs> {
  OnboardingGeneralPracticionerRoute({Key? key, required Sex sex})
      : super(name,
            path: 'doctor/general-practicioner',
            args: OnboardingGeneralPracticionerRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGeneralPracticionerRoute';
}

class OnboardingGeneralPracticionerRouteArgs {
  const OnboardingGeneralPracticionerRouteArgs({this.key, required this.sex});

  final Key? key;

  final Sex sex;
}

/// generated route for [GeneralPracticionerAchievementScreen]
class GeneralPracticionerAchievementRoute extends PageRouteInfo<void> {
  const GeneralPracticionerAchievementRoute()
      : super(name, path: 'general-practicioner-achievement');

  static const String name = 'GeneralPracticionerAchievementRoute';
}

/// generated route for [GeneralPractitionerDateScreen]
class GeneralPractitionerDateRoute extends PageRouteInfo<void> {
  const GeneralPractitionerDateRoute()
      : super(name, path: 'doctor/general-practitioner-date');

  static const String name = 'GeneralPractitionerDateRoute';
}

/// generated route for [AllowNotificationsScreen]
class AllowNotificationsRoute extends PageRouteInfo<void> {
  const AllowNotificationsRoute() : super(name, path: 'allow_notifications');

  static const String name = 'AllowNotificationsRoute';
}

/// generated route for [OnboardingGynecologyScreen]
class OnboardingGynecologyRoute
    extends PageRouteInfo<OnboardingGynecologyRouteArgs> {
  OnboardingGynecologyRoute({Key? key, required Sex sex})
      : super(name,
            path: 'doctor/gynecology',
            args: OnboardingGynecologyRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingGynecologyRoute';
}

class OnboardingGynecologyRouteArgs {
  const OnboardingGynecologyRouteArgs({this.key, required this.sex});

  final Key? key;

  final Sex sex;
}

/// generated route for [GynecologyAchievementScreen]
class GynecologyAchievementRoute extends PageRouteInfo<void> {
  const GynecologyAchievementRoute()
      : super(name, path: 'gynecology_achievement');

  static const String name = 'GynecologyAchievementRoute';
}

/// generated route for [GynecologyDateScreen]
class GynecologyDateRoute extends PageRouteInfo<void> {
  const GynecologyDateRoute() : super(name, path: 'doctor/gynecology-date');

  static const String name = 'GynecologyDateRoute';
}

/// generated route for [OnboardingDentistScreen]
class OnboardingDentistRoute extends PageRouteInfo<OnboardingDentistRouteArgs> {
  OnboardingDentistRoute({Key? key, required Sex sex})
      : super(name,
            path: 'doctor/dentist',
            args: OnboardingDentistRouteArgs(key: key, sex: sex));

  static const String name = 'OnboardingDentistRoute';
}

class OnboardingDentistRouteArgs {
  const OnboardingDentistRouteArgs({this.key, required this.sex});

  final Key? key;

  final Sex sex;
}

/// generated route for [DentistAchievementScreen]
class DentistAchievementRoute extends PageRouteInfo<void> {
  const DentistAchievementRoute() : super(name, path: 'dentist_achievement');

  static const String name = 'DentistAchievementRoute';
}

/// generated route for [DentistDateScreen]
class DentistDateRoute extends PageRouteInfo<void> {
  const DentistDateRoute() : super(name, path: 'doctor/dentist-date');

  static const String name = 'DentistDateRoute';
}
