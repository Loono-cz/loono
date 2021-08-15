import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loono/ui/screens/achievement.dart';
import 'package:loono/ui/screens/create_account.dart';
import 'package:loono/ui/screens/onboarding/allow_notifications.dart';
import 'package:loono/ui/screens/onboarding/birthdate.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_fourth.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_second.dart';
import 'package:loono/ui/screens/onboarding/carousel/carousel_third.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practicioner.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology.dart';
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
      onGenerateRoute: (settings) {
        final routeName = settings.name;

        switch (routeName) {
          case '/welcome':
            return MaterialPageRoute(builder: (_) => const WelcomeScreen());
          case '/onboarding/carousel':
            // to not keep the page in memory when the page is inactive
            return _swipeTransition(const OnboardingCarouselScreen(), maintainState: false);
          case '/onboarding/carousel2':
            return _swipeTransition(const OnboardingSecondCarouselScreen());
          case '/onboarding/carousel3':
            return _swipeTransition(const OnboardingThirdCarouselScreen());
          case '/onboarding/carousel4':
            return _swipeTransition(const OnboardFourthCarouselScreen());
          case '/onboarding/gender':
            return _swipeTransition(const OnboardingGenderScreen());
          case '/onboarding/birthdate':
            return MaterialPageRoute(builder: (_) => OnBoardingBirthdateScreen());
          case '/onboarding/doctor/general-practicioner':
            return MaterialPageRoute(builder: (_) => OnboardingGeneralPracticionerScreen());
          case '/onboarding/allow_notifications':
            return MaterialPageRoute(builder: (_) => const AllowNotificationsScreen());
          case '/onboarding/doctor/gynecology':
            return MaterialPageRoute(builder: (_) => OnboardingGynecologyScreen());
          case '/achievement':
            return MaterialPageRoute(builder: (_) => AchievementScreen());
          case '/create-account':
            return MaterialPageRoute(builder: (_) => const CreateAccountScreen());
          case '/fallback_account/name':
            return MaterialPageRoute(builder: (_) => const NicknameScreen());
          case '/fallback_account/email':
            return MaterialPageRoute(builder: (_) => const EmailScreen());
        }
      },
    );
  }
}

Route _swipeTransition(Widget widget, {bool maintainState = true}) =>
    CupertinoPageRoute(builder: (_) => widget, maintainState: maintainState);
