import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/loono_sponsors.dart';
import 'package:loono/ui/widgets/space.dart';
import 'package:loono/utils/registry.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final _userRepository = registry.get<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoonoColors.primaryLight,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                LoonoAssets.welcomeLogo,
                              ),
                              const CustomSpacer.vertical(24),
                              Text(
                                context.l10n.carousel_welcome_dialog,
                                textAlign: TextAlign.center,
                                style: LoonoFonts.headerLightFontStyle,
                              ),
                            ],
                          ),
                          const CustomSpacer.vertical(60),
                          LoonoButton(
                            text: context.l10n.carousel_start,
                            onTap: () async {
                              final autoRouter = AutoRouter.of(context);
                              await _userRepository.createUserIfNotExists();
                              await autoRouter.push(const IntroCarouselRoute());
                            },
                          ),
                          const CustomSpacer.vertical(15),
                          TextButton(
                            onPressed: () async {
                              final autoRouter = AutoRouter.of(context);
                              await _userRepository.createUserIfNotExists();

                              // ignore: unawaited_futures
                              autoRouter.replaceAll([
                                LoginRoute(),
                                PreAuthMainRoute(
                                  overridenPreventionRoute: LoginRoute(),
                                ),
                              ]);
                            },
                            child: Text(
                              context.l10n.carousel_have_account,
                              style: LoonoFonts.fontStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const LoonoSponsors(),
            ],
          ),
        ),
      ),
    );
  }
}
