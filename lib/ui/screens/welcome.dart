import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/registry.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                const SizedBox(
                  height: 90,
                ),
                SvgPicture.asset(
                  'assets/icons/welcome-logo.svg',
                ),
                Text(
                  context.l10n.carousel_welcome_dialog,
                  textAlign: TextAlign.center,
                  style: LoonoFonts.headerFontStyle,
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
                        await AutoRouter.of(context)
                            .push(PreAuthMainRoute(overridenPreventionRoute: LoginRoute()));
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
