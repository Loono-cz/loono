import 'package:flutter/material.dart';
import 'package:loono/ui/screens/onboarding.dart';
import 'package:loono/ui/screens/welcome.dart';
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
        '/dashboard': (_) => OnBoardingPage(),
      },
    );
  }
}
