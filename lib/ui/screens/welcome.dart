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
                const Text(
                  'Chraň své zdraví včasnou prevencí',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1A1919),
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 70),
                LoonoButton(
                  text: 'Začít cestu za zdravím',
                  onTap: () => context.read<OnboardingStateService>().startIntro(),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    AutoRouter.of(context).push(LoginRoute());
                  },
                  child: const Text(
                    'Už mám účet',
                    style: TextStyle(color: Color(0xFF1A1919)),
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
