import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/onboarding/onboarding_button.dart';

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
                const SizedBox(height: 100),
                OnboardingButton(
                  label: 'Začít',
                  onClick: () {
                    Navigator.pushNamed(context, '/onboarding/carousel');
                  },
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/fallback_account/email');
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
