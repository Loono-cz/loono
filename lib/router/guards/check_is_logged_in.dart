import 'package:auto_route/auto_route.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/utils/registry.dart';

class CheckIsLoggedIn extends AutoRouteGuard {
  final _authService = registry.get<AuthService>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (_authService.isLoggedIn) {
      resolver.next();
    } else {
      router.push(const OnboardingWrapperRoute());
    }
  }
}
