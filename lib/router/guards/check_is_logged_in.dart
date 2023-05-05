import 'package:auto_route/auto_route.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/utils/my_logger.dart';
import 'package:loono/utils/registry.dart';

class CheckIsLoggedIn extends AutoRouteGuard {
  final _authService = registry.get<AuthService>();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    await MyLogger().writeToFile('check_is_logged_in.dart -> onNavigation(): Checking for currAuthUser...');
    final currAuthUser = await _authService.getCurrentUser();
    await MyLogger().writeToFile('check_is_logged_in.dart -> onNavigation(): ${currAuthUser.toString()}');
    if (currAuthUser != null) {
      await MyLogger().writeToFile('check_is_logged_in.dart -> onNavigation(): User found... Removing splash...');
      FlutterNativeSplash.remove();
      resolver.next();
    } else {
      await MyLogger().writeToFile('check_is_logged_in.dart -> onNavigation(): User is null... Routing to AppStartUpWrapperRoute()');
      await router.push(const AppStartUpWrapperRoute());
    }
  }
}
