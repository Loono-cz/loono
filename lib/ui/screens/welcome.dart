import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: LoonoColors.primaryLight,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/welcome-logo.png',
                  width: 172,
                  height: 213,
                ),
                const SizedBox(height: 50),
                const Text(
                  'Chraň své zdraví\nvčasnou prevencí',
                  textAlign: TextAlign.center,
                  style: LoonoFonts.headerFontStyle,
                ),
                const SizedBox(height: 70),
                LoonoButton(
                  text: 'Začít cestu za zdravím',
                  onTap: () => context.read<OnboardingStateService>().startIntro(),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    AutoRouter.of(context).push(const LoginRoute());
                  },
                  child: const Text(
                    'Už mám účet',
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
