import 'package:flutter/material.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/onboarding/carousel.dart';
import 'package:loono/ui/screens/welcome.dart';
import 'package:loono/ui/screens/achievement.dart';
import 'package:loono/utils/registry.dart';

Future<void> main() async {
  await setup();
  runApp(Loono());
}

class Loono extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loono',
      color: Colors.deepOrange,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (_) => const WelcomeScreen(),
        '/onboarding/carousel': (_) => const OnboardingCarouselScreen(),
        '/onboarding/gender': (_) => const OnboardingGenderScreen(),
        '/onboarding/doctor/general-practicioner': (_) => OnboardingGeneralPracticionerScreen(),
        '/onboarding/doctor/gynecology': (_) => OnboardingGynecologyScreen(),
        '/achievement': (_) => AchievementScreen(),
      },
    );
  }
}
