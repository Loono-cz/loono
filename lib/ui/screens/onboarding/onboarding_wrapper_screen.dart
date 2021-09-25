import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/models/user.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

class OnboardingWrapperScreen extends StatefulWidget {
  const OnboardingWrapperScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingWrapperScreen> createState() => _OnboardingWrapperScreenState();
}

class _OnboardingWrapperScreenState extends State<OnboardingWrapperScreen> {
  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    final onboardingState = context.watch<OnboardingStateService>();

    return WillPopScope(
      onWillPop: () async => false,
      child: StreamBuilder<User?>(
        stream: _usersDao.watchUser(),
        builder: (context, snapshot) {
          return AutoRouter.declarative(
            routes: (context) {
              final user = snapshot.data;
              if (user == null) return [const OnboardingGenderRoute()];

              return [
                if (user.sexRaw == null) const OnboardingGenderRoute(),

                /// male flow
                if (user.sexRaw == 0) ...[
                  if (user.dateOfBirthRaw == null) OnBoardingBirthdateRoute(sex: Sex.male),
                  if (user.generalPracticionerCcaVisitRaw == null)
                    const OnboardingGeneralPracticionerRoute(),
                  if (user.generalPracticionerCcaVisitRaw == null)
                    const OnboardingGeneralPracticionerRoute(),
                  if (user.generalPracticionerCcaVisitRaw == null)
                    const OnboardingGeneralPracticionerRoute(),
                ],

                /// female flow
                if (user.sexRaw == 1) ...[
                  if (user.dateOfBirthRaw == null) OnBoardingBirthdateRoute(sex: Sex.female),
                  // if (user.generalPracticionerCcaVisitRaw == null)
                  //   const OnboardingGeneralPracticionerRoute(),
                  // if (user.generalPracticionerCcaVisitRaw == null)
                  //   const OnboardingGeneralPracticionerRoute(),
                  // if (user.generalPracticionerCcaVisitRaw == null)
                  //   const OnboardingGeneralPracticionerRoute(),
                ],
              ];
            },
          );
        },
      ),
    );
  }
}
