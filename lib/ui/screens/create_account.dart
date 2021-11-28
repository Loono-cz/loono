import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/ui/widgets/confirmation_dialog.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/social_login_button.dart';
import 'package:loono/utils/registry.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key}) : super(key: key);

  final _authService = registry.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              color: const Color(0xFFEDF8FD),
              child: SafeArea(
                child: Column(
                  children: [
                    SkipButton(
                      text: context.l10n.skip_without_account,
                      onPressed: () async {
                        final authUserResult = await _authService.signInAnonymously();
                        authUserResult.leftMap(
                          (failure) {
                            failure.maybeWhen(
                              network: (_) => showConfirmationDialog(
                                context,
                                onConfirm: () => AutoRouter.of(context).pop(),
                                confirmationButtonLabel: context.l10n.ok_action,
                                content:
                                    context.l10n.create_account_anonymous_login_connection_error,
                              ),
                              orElse: () =>
                                  showSnackBarError(context, message: failure.getMessage(context)),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        context.l10n.only_a_small_step_remains_and_you_have,
                        style: LoonoFonts.headerFontStyle,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: -12,
                          top: -5,
                          child: SvgPicture.asset('assets/icons/create-account-ellipse.svg',
                              width: 290),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            context.l10n.prevention_in_your_hands,
                            style: LoonoFonts.headerFontStyle,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: SvgPicture.asset('assets/icons/create-account-arrow.svg'))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: Column(
                  children: [
                    Text(
                      context.l10n.create_an_account_so_you_can_track_your_progress,
                      style: LoonoFonts.paragraphFontStyle,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialLoginButton.apple(
                              onPressed: () async {
                                final authUserResult = await _authService.signInWithApple();
                                authUserResult.leftMap(
                                  (failure) => showSnackBarError(context,
                                      message: failure.getMessage(context)),
                                );
                              },
                            ),
                            const SizedBox(height: 15),
                            SocialLoginButton.google(
                              onPressed: () async {
                                final authUserResult = await _authService.signInWithGoogle();
                                authUserResult.leftMap(
                                  (failure) => showSnackBarError(context,
                                      message: failure.getMessage(context)),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      // TODO: Terms of privacy page
                      onPressed: () => debugPrint('click'),
                      child: Text(
                        context.l10n.by_logging_in_you_agree_to_the_terms_of_privacy,
                        style: LoonoFonts.paragraphSmallFontStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
