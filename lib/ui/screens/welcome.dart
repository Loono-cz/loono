import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/routers/auth_router.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/welcome-logo.png',
                  width: 172,
                  height: 213,
                ),
                const SizedBox(height: 50),
                Text(
                  context.l10n.carousel_welcome_dialog,
                  textAlign: TextAlign.center,
                  style: LoonoFonts.headerFontStyle,
                ),
                const SizedBox(height: 70),
                LoonoButton(
                  text: context.l10n.carousel_start,
                  onTap: () => context.read<OnboardingStateService>().startIntro(),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    AutoRouter.of(context).push(LoginRoute());
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
    );
  }
}
