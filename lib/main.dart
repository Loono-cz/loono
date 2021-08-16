import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loono/ui/screens/achievement.dart';
import 'package:loono/ui/screens/create_account.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel.dart';
import 'package:loono/ui/screens/onboarding/onboarding_doctor_screen.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/email.dart';
import 'package:loono/ui/screens/onboarding/fallback_account/nickname.dart';
import 'package:loono/ui/screens/onboarding/gender.dart';
import 'package:loono/ui/screens/welcome.dart';
import 'package:loono/ui/widgets/universal_doctor_widget.dart';
import 'package:loono/loono.dart';
import 'package:loono/utils/app_config.dart';
import 'package:loono/utils/registry.dart';

Future<void> main() async {
  await setup(AppFlavors.dev);
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
        '/onboarding/doctor/general-practicioner': (_) =>
            const OnboardingDoctorScreen(doctorType: DoctorType.practitioner),
        '/onboarding/doctor/gynecology': (_) =>
            const OnboardingDoctorScreen(doctorType: DoctorType.gynecologist),
        '/onboarding/doctor/dentist': (_) =>
            const OnboardingDoctorScreen(doctorType: DoctorType.dentist),
        '/achievement': (_) => AchievementScreen(),
        '/create-account': (_) => const CreateAccountScreen(),
        '/fallback_account/name': (_) => const NicknameScreen(),
        '/fallback_account/email': (_) => const EmailScreen(),
      },
    );
  }
}
