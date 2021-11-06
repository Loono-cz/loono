// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MainScreenRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterScreen());
    },
    MainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MainScreen());
    },
    SettingsRouter.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const EmptyRouterScreen(),
          transitionsBuilder: TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    OpenSettingsRoute.name: (routeData) {
      final args = routeData.argsAs<OpenSettingsRouteArgs>(
          orElse: () => const OpenSettingsRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: OpenSettingsScreen(key: args.key));
    },
    UpdateProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateProfileRouteArgs>(
          orElse: () => const UpdateProfileRouteArgs());
      return CustomPage<dynamic>(
          routeData: routeData,
          child: UpdateProfileScreen(key: args.key),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditNicknameRoute.name: (routeData) {
      final args = routeData.argsAs<EditNicknameRouteArgs>();
      return CustomPage<dynamic>(
          routeData: routeData,
          child: EditNicknameScreen(key: args.key, user: args.user),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditEmailRoute.name: (routeData) {
      final args = routeData.argsAs<EditEmailRouteArgs>();
      return CustomPage<dynamic>(
          routeData: routeData,
          child: EditEmailScreen(key: args.key, user: args.user),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditSexRoute.name: (routeData) {
      final args = routeData.argsAs<EditSexRouteArgs>();
      return CustomPage<dynamic>(
          routeData: routeData,
          child: EditSexScreen(key: args.key, sex: args.sex),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    EditBirthdateRoute.name: (routeData) {
      final args = routeData.argsAs<EditBirthdateRouteArgs>();
      return CustomPage<dynamic>(
          routeData: routeData,
          child: EditBirthdateScreen(
              key: args.key, dateWithoutDay: args.dateWithoutDay),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    LeaderboardRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const LeaderboardScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    PointsHelpRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const PointsHelpScreen(),
          transitionsBuilder: TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(MainScreenRouter.name, path: 'main-screen', children: [
          RouteConfig(MainRoute.name, path: '', parent: MainScreenRouter.name),
          RouteConfig(SettingsRouter.name,
              path: 'settings',
              parent: MainScreenRouter.name,
              children: [
                RouteConfig(OpenSettingsRoute.name,
                    path: '', parent: SettingsRouter.name),
                RouteConfig(UpdateProfileRoute.name,
                    path: 'update-profile', parent: SettingsRouter.name),
                RouteConfig(EditNicknameRoute.name,
                    path: 'update-profile/nickname',
                    parent: SettingsRouter.name),
                RouteConfig(EditEmailRoute.name,
                    path: 'update-profile/email', parent: SettingsRouter.name),
                RouteConfig(EditSexRoute.name,
                    path: 'update-profile/sex', parent: SettingsRouter.name),
                RouteConfig(EditBirthdateRoute.name,
                    path: 'update-profile/birthdate',
                    parent: SettingsRouter.name),
                RouteConfig(LeaderboardRoute.name,
                    path: 'leaderboard', parent: SettingsRouter.name),
                RouteConfig(PointsHelpRoute.name,
                    path: 'points-help', parent: SettingsRouter.name)
              ])
        ])
      ];
}

/// generated route for [EmptyRouterScreen]
class MainScreenRouter extends PageRouteInfo<void> {
  const MainScreenRouter({List<PageRouteInfo>? children})
      : super(name, path: 'main-screen', initialChildren: children);

  static const String name = 'MainScreenRouter';
}

/// generated route for [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute() : super(name, path: '');

  static const String name = 'MainRoute';
}

/// generated route for [EmptyRouterScreen]
class SettingsRouter extends PageRouteInfo<void> {
  const SettingsRouter({List<PageRouteInfo>? children})
      : super(name, path: 'settings', initialChildren: children);

  static const String name = 'SettingsRouter';
}

/// generated route for [OpenSettingsScreen]
class OpenSettingsRoute extends PageRouteInfo<OpenSettingsRouteArgs> {
  OpenSettingsRoute({Key? key})
      : super(name, path: '', args: OpenSettingsRouteArgs(key: key));

  static const String name = 'OpenSettingsRoute';
}

class OpenSettingsRouteArgs {
  const OpenSettingsRouteArgs({this.key});

  final Key? key;
}

/// generated route for [UpdateProfileScreen]
class UpdateProfileRoute extends PageRouteInfo<UpdateProfileRouteArgs> {
  UpdateProfileRoute({Key? key})
      : super(name,
            path: 'update-profile', args: UpdateProfileRouteArgs(key: key));

  static const String name = 'UpdateProfileRoute';
}

class UpdateProfileRouteArgs {
  const UpdateProfileRouteArgs({this.key});

  final Key? key;
}

/// generated route for [EditNicknameScreen]
class EditNicknameRoute extends PageRouteInfo<EditNicknameRouteArgs> {
  EditNicknameRoute({Key? key, required User? user})
      : super(name,
            path: 'update-profile/nickname',
            args: EditNicknameRouteArgs(key: key, user: user));

  static const String name = 'EditNicknameRoute';
}

class EditNicknameRouteArgs {
  const EditNicknameRouteArgs({this.key, required this.user});

  final Key? key;

  final User? user;
}

/// generated route for [EditEmailScreen]
class EditEmailRoute extends PageRouteInfo<EditEmailRouteArgs> {
  EditEmailRoute({Key? key, required User? user})
      : super(name,
            path: 'update-profile/email',
            args: EditEmailRouteArgs(key: key, user: user));

  static const String name = 'EditEmailRoute';
}

class EditEmailRouteArgs {
  const EditEmailRouteArgs({this.key, required this.user});

  final Key? key;

  final User? user;
}

/// generated route for [EditSexScreen]
class EditSexRoute extends PageRouteInfo<EditSexRouteArgs> {
  EditSexRoute({Key? key, required Sex? sex})
      : super(name,
            path: 'update-profile/sex',
            args: EditSexRouteArgs(key: key, sex: sex));

  static const String name = 'EditSexRoute';
}

class EditSexRouteArgs {
  const EditSexRouteArgs({this.key, required this.sex});

  final Key? key;

  final Sex? sex;
}

/// generated route for [EditBirthdateScreen]
class EditBirthdateRoute extends PageRouteInfo<EditBirthdateRouteArgs> {
  EditBirthdateRoute({Key? key, required DateWithoutDay? dateWithoutDay})
      : super(name,
            path: 'update-profile/birthdate',
            args: EditBirthdateRouteArgs(
                key: key, dateWithoutDay: dateWithoutDay));

  static const String name = 'EditBirthdateRoute';
}

class EditBirthdateRouteArgs {
  const EditBirthdateRouteArgs({this.key, required this.dateWithoutDay});

  final Key? key;

  final DateWithoutDay? dateWithoutDay;
}

/// generated route for [LeaderboardScreen]
class LeaderboardRoute extends PageRouteInfo<void> {
  const LeaderboardRoute() : super(name, path: 'leaderboard');

  static const String name = 'LeaderboardRoute';
}

/// generated route for [PointsHelpScreen]
class PointsHelpRoute extends PageRouteInfo<void> {
  const PointsHelpRoute() : super(name, path: 'points-help');

  static const String name = 'PointsHelpRoute';
}
