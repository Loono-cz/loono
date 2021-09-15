import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loono/ui/screens/create_account.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/general_practicioner_achievement.dart';
import 'package:loono/ui/screens/gynecology_achievement.dart';
import 'package:loono/ui/screens/login.dart';
import 'package:loono/ui/screens/onboarding/allow_notifications.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel.dart';
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practitioner_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology_date.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/email.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/nickname.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/welcome.dart';

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
        '/onboarding/doctor/general-practitioner-date': (_) => const GeneralPractitionerDateScreen(),
        '/onboarding/allow_notifications': (_) => const AllowNotificationsScreen(),
        '/onboarding/doctor/gynecology': (_) => OnboardingGynecologyScreen(),
        '/gynecology_achievement': (_) => GynecologyAchievementScreen(),
        '/onboarding/doctor/gynecology-date': (_) => const GynecologyDateScreen(),
        '/dentist_achievement': (_) => DentistAchievementScreen(),
        '/onboarding/doctor/dentist-date': (_) => const DentistDateScreen(),
        '/create-account': (_) => const CreateAccountScreen(),
        '/fallback_account/name': (_) => const NicknameScreen(),
        '/fallback_account/email': (_) => const EmailScreen(),
        '/general-practicioner-achievement': (_) => GeneralPracticionerAchievementScreen(),
        '/login': (_) => const LoginScreen(),
      },
    );
  }
}