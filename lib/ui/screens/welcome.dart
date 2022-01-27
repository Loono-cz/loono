import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
                      onTap: () => context.read<OnboardingStateService>().startIntro(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {
                        AutoRouter.of(context).push(LoginRoute());
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
