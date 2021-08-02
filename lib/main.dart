import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loono/ui/screens/achievement.dart';
import 'package:loono/ui/screens/onboarding/allow_notifications.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/email.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/nickname.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/welcome': (_) => const WelcomeScreen(),
        '/onboarding/carousel': (_) => const OnboardingCarouselScreen(),
        '/onboarding/gender': (_) => const OnboardingGenderScreen(),
        '/onboarding/birthdate': (_) => OnBoardingBirthdateScreen(),
        '/onboarding/doctor/general-practicioner': (_) => OnboardingGeneralPracticionerScreen(),
        '/onboarding/doctor/gynecology': (_) => OnboardingGynecologyScreen(),
        '/achievement': (_) => AchievementScreen(),
        '/onboarding/allow_notifications': (_) => const AllowNotificationsScreen(),
        '/fallback_account/name': (_) => const NicknameScreen(),
        '/fallback_account/email': (_) => const EmailScreen(),
      },
    );
  }
}
