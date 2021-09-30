import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/utils/registry.dart';

class MainWrapperScreen extends StatelessWidget {
  MainWrapperScreen({Key? key}) : super(key: key);

  final _authService = registry.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthUser?>(
      stream: _authService.onAuthStateChanged,
      builder: (context, snapshot) {
        final authUser = snapshot.data;

        return AutoRouter.declarative(
          routes: (context) {
            if (authUser == null) {
              return [const OnboardingWrapperRoute()];
            } else {
              return [const MainRoute()];
            }
          },
        );
      },
    );
  }
}
