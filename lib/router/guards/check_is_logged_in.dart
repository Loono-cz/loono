import 'package:auto_route/auto_route.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/utils/registry.dart';

class CheckIsLoggedIn extends AutoRouteGuard {
  final _authService = registry.get<AuthService>();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final currAuthUser = await _authService.getCurrentUser();
    if (currAuthUser != null) {
      FlutterNativeSplash.remove();
      resolver.next();
    } else {
      await router.push(const AppStartUpWrapperRoute());
    }
  }
}
