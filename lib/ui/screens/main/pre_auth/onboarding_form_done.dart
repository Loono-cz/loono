import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/social_login_button.dart';
import 'package:loono/utils/registry.dart';

class OnboardingFormDoneScreen extends StatelessWidget {
  OnboardingFormDoneScreen({Key? key}) : super(key: key);

  final _authService = registry.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: const Color.fromRGBO(241, 249, 249, 1),
              child: Padding(
                padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SkipButton(
                      text: context.l10n.already_have_an_account_skip_button,
                      onPressed: () {
                        if (AutoRouter.of(context).isRouteActive(PreAuthMainRoute().routeName)) {
                          AutoRouter.of(context).popUntilRoot();
                        }
                        AutoRouter.of(context).replaceAll([
                          LoginRoute(),
                          PreAuthMainRoute(overridenPreventionRoute: LoginRoute()),
                        ]);
                      },
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        context.l10n.onboarding_form_done_header,
                        textAlign: TextAlign.start,
                        style: LoonoFonts.headerFontStyle,
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/prevention/success_checkmark.svg',
                                  width: 30,
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    context.l10n.onboarding_form_done_success_message,
                                    textAlign: TextAlign.start,
                                    style: LoonoFonts.subtitleFontStyle.copyWith(
                                      color: LoonoColors.greenSuccess,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset('assets/icons/doctor_finish_questionnaire.svg'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
              child: SocialLoginButton.apple(
                onPressed: () async {
                  final authUserResult = await _authService.signInWithApple();
                  authUserResult.fold(
                    (failure) => showSnackBarError(context, message: failure.getMessage(context)),
                    (authUser) => AutoRouter.of(context).push(NicknameRoute(authUser: authUser)),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: SocialLoginButton.google(
                onPressed: () async {
                  final authUserResult = await _authService.signInWithGoogle();
                  authUserResult.fold(
                    (failure) => showSnackBarError(context, message: failure.getMessage(context)),
                    (authUser) => AutoRouter.of(context).push(NicknameRoute(authUser: authUser)),
                  );
                },
              ),
            ),
            TextButton(
              // TODO: Terms of privacy page
              onPressed: () => debugPrint('open'),
              child: Text.rich(
                TextSpan(
                  text: context.l10n.by_logging_in_you_agree_to_the_terms_of_privacy,
                  children: [
                    TextSpan(
                      text:
                          ' ${context.l10n.by_logging_in_you_agree_to_the_terms_of_privacy_highlight}',
                      style: LoonoFonts.fontStyle.copyWith(decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                style: LoonoFonts.fontStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
