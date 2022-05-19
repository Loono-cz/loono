import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/welcome-logo.svg',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      context.l10n.carousel_welcome_dialog,
                      textAlign: TextAlign.center,
                      style: LoonoFonts.headerFontStyle,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.incubated,
                          textAlign: TextAlign.center,
                          style: LoonoFonts.paragraphSmallFontStyle,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Image.asset(
                          'assets/sponsors/cd.png',
                          width: 105,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.l10n.with_support,
                          textAlign: TextAlign.center,
                          style: LoonoFonts.paragraphSmallFontStyle,
                        ),
                        Image.asset(
                          'assets/sponsors/ppf.png',
                          height: 78,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    LoonoButton(
                      text: context.l10n.carousel_start,
                      onTap: () async {
                        await _userRepository.createUserIfNotExists();
                        await AutoRouter.of(context).push(const IntroCarouselRoute());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () async {
                        await _userRepository.createUserIfNotExists();

                        // ignore: unawaited_futures
                        AutoRouter.of(context).replaceAll([
                          LoginRoute(),
                          PreAuthMainRoute(overridenPreventionRoute: LoginRoute()),
                        ]);
                      },
                      child: Text(
                        context.l10n.carousel_have_account,
                        style: LoonoFonts.fontStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
