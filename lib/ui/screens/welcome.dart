import 'package:flutter/material.dart';
import 'package:loono/ui/widgets/onboarding/onboarding_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
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
              OnboardingButton(label: 'Začít cestu za zdravím', onClick: () => print('Redirect to next page')),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => print('Redirect to login'),
                child: const Text('Už mám účet', style: TextStyle(color: Color(0xFF1A1919))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
