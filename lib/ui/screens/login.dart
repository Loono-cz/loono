import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/ui/widgets/social_login_button.dart';
import 'package:loono/utils/registry.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _authService = registry.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.login_header,
                  textAlign: TextAlign.left,
                  style: LoonoFonts.headerFontStyle,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/carousel_doctors.svg',
              width: MediaQuery.of(context).size.width,
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SocialLoginButton.apple(
                onPressed: () async {
                  final authUserResult = await _authService.signInWithApple();
                  authUserResult.fold(
                    (failure) => showSnackBarError(context, message: failure.getMessage(context)),
                    (authUser) => AutoRouter.of(context).push(const MainWrapperRoute()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SocialLoginButton.google(
                onPressed: () async {
                  final authUserResult = await _authService.signInWithGoogle();
                  authUserResult.fold(
                    (failure) => showSnackBarError(context, message: failure.getMessage(context)),
                    (authUser) => AutoRouter.of(context).push(const MainWrapperRoute()),
                  );
                },
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => AutoRouter.of(context).push(const OnboardingWrapperRoute()),
              child: Text(
                context.l10n.login_start_over_button,
                style: LoonoFonts.paragraphFontStyle,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
