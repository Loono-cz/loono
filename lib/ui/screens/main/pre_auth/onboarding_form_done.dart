import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/social_login_helpers.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/social_login_button.dart';
import 'package:loono/utils/registry.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingFormDoneScreen extends StatelessWidget {
  OnboardingFormDoneScreen({Key? key}) : super(key: key);

  final _authService = registry.get<AuthService>();
  final _userRepository = registry.get<UserRepository>();

  final termsUrl = 'https://www.loono.cz/podminky-uzivani-mobilni-aplikace';
  final privacyUrl = 'https://www.loono.cz/zasady-ochrany-osobnich-udaju-mobilni-aplikace';

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  void _setLoadingState(bool value) => _isLoading.value = value;

  @override
  Widget build(BuildContext context) {
    final isScreenSmall = LoonoSizes.isScreenSmall(context);
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoading,
      builder: (context, isLoadingValue, _) {
        return ModalProgressHUD(
          inAsyncCall: isLoadingValue,
          progressIndicator: const CircularProgressIndicator(color: LoonoColors.primaryEnabled),
          opacity: 0.5,
          child: Scaffold(
            body: SafeArea(
              child: ListView(
                children: [
                  Container(
                    color: const Color.fromRGBO(237, 248, 253, 1),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, left: 18, right: 18),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          SkipButton(
                            text: context.l10n.already_have_an_account_skip_button,
                            onPressed: () {
                              if (AutoRouter.of(context).isRouteActive(PreAuthMainRoute.name)) {
                                AutoRouter.of(context).popUntilRoot();
                              }
                              AutoRouter.of(context).replaceAll([
                                const OnboardingWrapperRoute(),
                                LoginRoute(),
                                PreAuthMainRoute(overridenPreventionRoute: LoginRoute()),
                              ]);
                            },
                          ),
                          SizedBox(height: isScreenSmall ? 6 : 24),
                          Text(
                            context.l10n.onboarding_form_done_header,
                            textAlign: TextAlign.start,
                            style: LoonoSizes.responsiveStyleScale(
                              context,
                              LoonoFonts.headerFontStyle,
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
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
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/doctor_finish_questionnaire.svg',
                                    width: isScreenSmall ? 90 : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: isScreenSmall ? 5 : 30),
                  if (Platform.isIOS)
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: SocialLoginButton.apple(
                        onPressed: () async => _processSocialAuth(
                          context,
                          socialLoginMethod: SocialLoginMethod.apple,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: SocialLoginButton.google(
                      key: const Key('onboardingFormDonePage_btn_googleSignUp'),
                      onPressed: () async => _processSocialAuth(
                        context,
                        socialLoginMethod: SocialLoginMethod.google,
                      ),
                    ),
                  ),
                  SizedBox(height: isScreenSmall ? 5 : 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: TextButton(
                      onPressed: () => debugPrint('open'),
                      child: Text.rich(
                        TextSpan(
                          text: context.l10n.by_logging_in_you_agree_to_the_terms_of_privacy,
                          children: [
                            TextSpan(
                              text: context.l10n.by_logging_in_you_agree_to_the_terms_highlight,
                              style: LoonoFonts.fontStyle
                                  .copyWith(decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (await canLaunch(termsUrl)) {
                                    await launch(
                                      termsUrl,
                                    );
                                  }
                                },
                            ),
                            TextSpan(
                              text: ' ${context.l10n.examination_detail_rewards_get_badge_2} ',
                            ),
                            TextSpan(
                              text: context.l10n.by_logging_in_you_agree_to_the_privacy_highlight,
                              style: LoonoFonts.fontStyle
                                  .copyWith(decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (await canLaunch(privacyUrl)) {
                                    await launch(
                                      privacyUrl,
                                    );
                                  }
                                },
                            ),
                          ],
                        ),
                        style: LoonoFonts.fontStyle.copyWith(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _processSocialAuth(
    BuildContext context, {
    required SocialLoginMethod socialLoginMethod,
  }) async {
    if (socialLoginMethod == SocialLoginMethod.google &&
        _authService.isInBackendIntegrationTestingMode) {
      await AutoRouter.of(context).push(NicknameRoute(socialLoginAccount: null));
      return;
    }

    final Either<AuthFailure, AuthUser> accountExistsResult;
    switch (socialLoginMethod) {
      case SocialLoginMethod.apple:
        accountExistsResult = await _authService.checkAppleAccountExistsAndSignIn();
        break;
      case SocialLoginMethod.google:
        accountExistsResult = await _authService.checkGoogleAccountExistsAndSignIn();
        break;
    }
    await accountExistsResult.fold(
      (failure) {
        failure.maybeWhen(
          accountNotExists: (socialAccount) =>
              AutoRouter.of(context).push(NicknameRoute(socialLoginAccount: socialAccount)),
          orElse: () => showFlushBarError(context, failure.getMessage(context)),
        );
      },
      (authUser) async {
        _setLoadingState(true);
        await context.read<ExaminationsProvider>().fetchExaminations().then(
              (res) async => res.when(
                success: (data) async {
                  // An account with this email already exists, proceed through the login.
                  await _userRepository.createUser();
                  await AutoRouter.of(context).replaceAll([const MainScreenRouter()]);
                },
                failure: (_) async {
                  showFlushBarError(context, context.l10n.login_server_down_message);
                  await _authService.signOut();
                },
              ),
            );
        _setLoadingState(false);
      },
    );
  }
}
