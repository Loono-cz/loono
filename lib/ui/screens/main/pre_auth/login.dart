import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as s;
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/onboarding_state_helpers.dart';
import 'package:loono/helpers/size_helpers.dart';
import 'package:loono/helpers/social_login_helpers.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/firebase_user.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/social_login_button.dart';
import 'package:loono/ui/widgets/space.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:yaml/yaml.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _authService = registry.get<AuthService>();
  final _examinationQuestionnairesDao =
      registry.get<DatabaseService>().examinationQuestionnaires;
  final _userRepository = registry.get<UserRepository>();

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
          progressIndicator: const CircularProgressIndicator(
            color: LoonoColors.primaryEnabled,
          ),
          opacity: 0.5,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const CustomSpacer.vertical(30),
                              if (!isScreenSmall &&
                                  registry.get<AppConfig>().flavor ==
                                      AppFlavors.dev) ...[
                                TextButton(
                                  onPressed: () async {
                                    final data = await s.rootBundle.loadString(
                                      'assets/supported_apis.yaml',
                                    );
                                    final apis = loadYaml(data) as YamlList;

                                    await showDialog<void>(
                                      context: context,
                                      barrierDismissible: false,
                                      // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Select API'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: apis.nodes
                                                  .map(
                                                    (dynamic api) =>
                                                        ElevatedButton(
                                                      onPressed: () async {
                                                        final autoRouter =
                                                            AutoRouter.of(
                                                          context,
                                                        );
                                                        await registry
                                                            .get<AuthService>()
                                                            .switchApi(
                                                              api['url']
                                                                  .toString(),
                                                            );
                                                        await autoRouter.pop();
                                                      },
                                                      child: Text(
                                                        api['url'].toString(),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    'switch api (dev flavour only)',
                                  ),
                                ),
                                const CustomSpacer.vertical(10),
                              ],
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      context.mediaQuery.compactSizeOf(18.0),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    context.l10n.login_header,
                                    textAlign: TextAlign.left,
                                    style: LoonoSizes.responsiveStyleScale(
                                      context,
                                      LoonoFonts.headerFontStyle,
                                    ),
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                LoonoAssets.carouselDoctor,
                                width: context.mediaQuery.size.width * 0.9,
                              ),
                            ],
                          ),
                          if (isScreenSmall) const CustomSpacer.vertical(10),
                        ],
                      ),
                    ),
                  ),
                  _buildLoginButtons(context, isScreenSmall),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginButtons(BuildContext context, bool isScreenSmall) {
    return Column(
      children: [
        if (Platform.isIOS) ...[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.mediaQuery.compactSizeOf(18.0),
            ),
            child: SocialLoginButton.apple(
              onPressed: () async => _processSocialLogin(
                context,
                socialLoginMethod: SocialLoginMethod.apple,
              ),
            ),
          ),
          const CustomSpacer.vertical(20.0),
        ],
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.mediaQuery.compactSizeOf(18.0),
          ),
          child: SocialLoginButton.google(
            onPressed: () async => _processSocialLogin(
              context,
              socialLoginMethod: SocialLoginMethod.google,
            ),
          ),
        ),
        if (!isScreenSmall) const CustomSpacer.vertical(10),
        TextButton(
          onPressed: () async {
            final autoRouter = AutoRouter.of(context);
            final questionnaires = await _examinationQuestionnairesDao.getAll();
            if (questionnaires.isOnboardingDone) {
              await autoRouter.push(PreAuthMainRoute());
            } else {
              await autoRouter.push(const OnboardingWrapperRoute());
            }
          },
          child: Text(
            context.l10n.login_create_new_account,
            style: LoonoFonts.paragraphFontStyle,
          ),
        ),
        if (!isScreenSmall) const CustomSpacer.vertical(10),
      ],
    );
  }

  Future<void> _processSocialLogin(
    BuildContext context, {
    required SocialLoginMethod socialLoginMethod,
  }) async {
    final Either<AuthFailure, AuthUser> accountExistsResult;
    switch (socialLoginMethod) {
      case SocialLoginMethod.apple:
        accountExistsResult =
            await _authService.checkAppleAccountExistsAndSignIn();
        break;
      case SocialLoginMethod.google:
        accountExistsResult =
            await _authService.checkGoogleAccountExistsAndSignIn();
        break;
    }
    accountExistsResult.fold(
      (failure) => showFlushBarError(context, failure.getMessage(context)),
      (authUser) async {
        _setLoadingState(true);
        await context.read<ExaminationsProvider>().fetchExaminations().then(
              (res) async => res.when(
                success: (data) async {
                  final autoRouter = AutoRouter.of(context);
                  // An account with this email already exists, proceed through the login.
                  await _userRepository.createUser();
                  await autoRouter.replaceAll([const MainScreenRouter()]);
                },
                failure: (_) async {
                  showFlushBarError(
                    context,
                    context.l10n.login_server_down_message,
                  );
                  await _authService.signOut();
                },
              ),
            );
        _setLoadingState(false);
      },
    );
  }
}
