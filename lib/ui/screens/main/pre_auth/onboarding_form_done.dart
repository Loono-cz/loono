import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/ui/widgets/social_login_button.dart';
import 'package:loono/utils/registry.dart';

class OnboardingFormDoneScreen extends StatelessWidget {
  OnboardingFormDoneScreen({Key? key}) : super(key: key);

  final _authService = registry.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Přihlaš se a získej osobní seznam preventivních prohlídek\n\nTODO: screen UI',
                textAlign: TextAlign.center,
                style: LoonoFonts.bigFontStyle,
              ),
              const SizedBox(height: 24),
              const Text('✔ Vstupní dotazník máš úspěšně hotový'),
              const Spacer(),
              SocialLoginButton.apple(
                onPressed: () async {
                  final authUserResult = await _authService.signInWithApple();
                  authUserResult.fold(
                    (failure) => showSnackBarError(context, message: failure.getMessage(context)),
                    (authUser) => AutoRouter.of(context).push(NicknameRoute(authUser: authUser)),
                  );
                },
              ),
              const SizedBox(height: 15),
              SocialLoginButton.google(
                onPressed: () async {
                  final authUserResult = await _authService.signInWithGoogle();
                  authUserResult.fold(
                    (failure) => showSnackBarError(context, message: failure.getMessage(context)),
                    (authUser) => AutoRouter.of(context).push(NicknameRoute(authUser: authUser)),
                  );
                },
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
