import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as s;
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/onboarding_state_helpers.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/social_login_button.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';
import 'package:yaml/yaml.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _authService = registry.get<AuthService>();
  final _examinationQuestionnairesDao = registry.get<DatabaseService>().examinationQuestionnaires;
  final _userRepository = registry.get<UserRepository>();

  @override
  Widget build(BuildContext context) {
    final isScreenSmall = LoonoSizes.isScreenSmall(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    if (!isScreenSmall && registry.get<AppConfig>().flavor == AppFlavors.dev) ...[
                      TextButton(
                        onPressed: () async {
                          final data = await s.rootBundle.loadString('assets/supported_apis.yaml');
                          final apis = loadYaml(data) as YamlList;

                          await showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select API'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: apis.nodes
                                        .map(
                                          (dynamic api) => ElevatedButton(
                                            onPressed: () async {
                                              await registry
                                                  .get<AuthService>()
                                                  .switchApi(api['url'].toString());
                                              await AutoRouter.of(context).pop();
                                            },
                                            child: Text(api['url'].toString()),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text('switch api (dev flavour only)'),
                      ),
                      const SizedBox(height: 10),
                    ],
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                    Expanded(child: SvgPicture.asset('assets/icons/carousel_doctors.svg')),
                  ],
                ),
              ),
            ),
            if (isScreenSmall) const SizedBox(height: 10),
            if (Platform.isIOS) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SocialLoginButton.apple(
                  onPressed: () async {
                    final accountExistsResult =
                        await _authService.checkAppleAccountExistsAndSignIn();
                    accountExistsResult.fold(
                      (failure) => showFlushBarError(context, failure.getMessage(context)),
                      (authUser) async {
                        await _userRepository.createUserIfNotExists();
                        await AutoRouter.of(context).replaceAll([const MainScreenRouter()]);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SocialLoginButton.google(
                onPressed: () async {
                  final accountExistsResult =
                      await _authService.checkGoogleAccountExistsAndSignIn();
                  accountExistsResult.fold(
                    (failure) => showFlushBarError(context, failure.getMessage(context)),
                    (authUser) async {
                      await _userRepository.createUserIfNotExists();
                      await AutoRouter.of(context).replaceAll([const MainScreenRouter()]);
                    },
                  );
                },
              ),
            ),
            if (!isScreenSmall) const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                final questionnaires = await _examinationQuestionnairesDao.getAll();
                if (questionnaires.isOnboardingDone) {
                  await AutoRouter.of(context).push(PreAuthMainRoute());
                } else {
                  await AutoRouter.of(context).push(const OnboardingWrapperRoute());
                }
              },
              child: Text(
                context.l10n.login_create_new_account,
                style: LoonoFonts.paragraphFontStyle,
              ),
            ),
            if (!isScreenSmall) const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
