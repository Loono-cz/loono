import 'package:flutter/material.dart';
import 'package:loono/ui/screens/onboarding.dart';
import 'package:loono/ui/screens/onboarding_carousel.dart';
import 'package:loono/ui/screens/welcome.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono/ui/screens/dashboard.dart';
import 'package:loono/ui/screens/intro_video.dart';

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
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (_) => OnboardingCarouselScreen(),
        '/carousel2': (_) => CarouselScreen(),
        '/carousel3': (_) => CarouselScreenSecond(),
        '/carousel4': (_) => CarouselScreenThird(),
        '/dashboard': (_) => DashboardScreen(),
        '/welcome': (_) => const WelcomeScreen(),
        '/dashboard': (_) => OnBoardingPage(),
      },
    );
  }
}
