import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/models/user.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/ui/screens/dentist_achievement.dart';
import 'package:loono/ui/screens/general_practicioner_achievement.dart';
import 'package:loono/ui/screens/gynecology_achievement.dart';
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
    return ChangeNotifierProvider<OnboardingStateService>(
      create: (_) => OnboardingStateService(),
      builder: (context, _) {
        final onboardingState = context.watch<OnboardingStateService>();

        return StreamBuilder<User?>(
          stream: _usersDao.watchUser(),
          builder: (context, snapshot) {
            return AutoRouter.declarative(
              routes: (context) {
                final user = snapshot.data;
                if (user == null) return [const OnboardingGenderRoute()];

                return [
                  if (user.sexRaw == null) const OnboardingGenderRoute(),
                  if (user.sexRaw == 0 || user.sexRaw == 1)
                    ...[
                      OnBoardingBirthdateRoute(sex: Sex.values.elementAt(user.sexRaw!)),

                      /// GeneralPractitioner Route
                      if (user.dateOfBirthRaw != null)
                        OnboardingGeneralPracticionerRoute(sex: Sex.values.elementAt(user.sexRaw!)),

                      if (user.generalPracticionerCcaVisitRaw != null)
                        if (user.generalPracticionerCcaVisitRaw ==
                            CcaDoctorVisit.inLastTwoYears.index) ...[
                          if (!onboardingState
                              .containsAchievement(GeneralPracticionerAchievementScreen.id))
                            const GeneralPracticionerAchievementRoute()
                          else
                            const GeneralPractitionerDateRoute(),
                        ] else ...[
                          if (user.sexRaw == 1)
                            OnboardingGynecologyRoute(sex: Sex.values.elementAt(user.sexRaw!))
                          else
                            OnboardingDentistRoute(sex: Sex.values.elementAt(user.sexRaw!)),
                        ],

                      /// Gynecology Route (female)
                      if (user.generalPracticionerVisitDate != null &&
                          user.generalPracticionerVisitDateRaw != null)
                        if (user.sexRaw == 1)
                          OnboardingGynecologyRoute(sex: Sex.values.elementAt(user.sexRaw!))
                        else
                          OnboardingDentistRoute(sex: Sex.values.elementAt(user.sexRaw!)),

                      if (user.sexRaw == 1)
                        if (user.gynecologyCcaVisitRaw != null)
                          if (user.gynecologyCcaVisitRaw ==
                              CcaDoctorVisit.inLastTwoYears.index) ...[
                            if (!onboardingState
                                .containsAchievement(GynecologyAchievementScreen.id))
                              const GynecologyAchievementRoute()
                            else
                              const GynecologyDateRoute(),
                          ] else ...[
                            OnboardingDentistRoute(sex: Sex.values.elementAt(user.sexRaw!)),
                          ],

                      /// Dentist Route
                      if (user.dentistVisitDate != null && user.dentistVisitDateRaw != null)
                        OnboardingDentistRoute(sex: Sex.values.elementAt(user.sexRaw!)),

                      if (user.dentistCcaVisitRaw != null)
                        if (user.dentistCcaVisitRaw == CcaDoctorVisit.inLastTwoYears.index) ...[
                          if (!onboardingState.containsAchievement(DentistAchievementScreen.id))
                            const DentistAchievementRoute()
                          else
                            const DentistDateRoute(),
                        ] else ...[
                          OnboardingDentistRoute(sex: Sex.values.elementAt(user.sexRaw!)),
                        ],
                    ]..last,
                ];
              },
            );
          },
        );
      },
    );
  }
}
