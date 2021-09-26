import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/date_without_day.dart';
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
    return WillPopScope(
      // TODO: set to false (for https://cesko-digital.atlassian.net/browse/LOON-202)
      onWillPop: () async => true,
      child: ChangeNotifierProvider<OnboardingStateService>(
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

                  final flows = <PageRouteInfo<dynamic>?>[];
                  if (user.sex == null) flows.add(const OnboardingGenderRoute());
                  if (user.sex == Sex.male || user.sex == Sex.female) {
                    flows.add(OnBoardingBirthdateRoute(sex: user.sex!));

                    if (user.dateOfBirthRaw != null) {
                      /// GeneralPractitioner Route
                      flows.add(OnboardingGeneralPracticionerRoute(sex: user.sex!));
                      flows.add(
                        dateOrAchievementOrNextDoctorRoute(
                          onboardingState: onboardingState,
                          currDoctorCcaVisit: user.generalPracticionerCcaVisit,
                          currDoctorAchievementId: GeneralPracticionerAchievementScreen.id,
                          achievementRoute: const GeneralPracticionerAchievementRoute(),
                          dateRoute: const GeneralPractitionerDateRoute(),
                          nextDoctorRoute: user.sex == Sex.female
                              ? OnboardingGynecologyRoute(sex: user.sex!) as PageRouteInfo<dynamic>
                              : OnboardingDentistRoute(sex: user.sex!),
                        ),
                      );

                      /// Gynecology Route (female only)
                      if (user.sex == Sex.female) {
                        flows.add(
                          nextDoctorOnlyRoute(
                            prevDoctorCcaVisit: user.generalPracticionerCcaVisit,
                            prevDoctorDateVisit: user.generalPracticionerVisitDate,
                            nextDoctorRoute: OnboardingGynecologyRoute(sex: user.sex!),
                          ),
                        );
                        flows.add(
                          dateOrAchievementOrNextDoctorRoute(
                            onboardingState: onboardingState,
                            currDoctorCcaVisit: user.gynecologyCcaVisit,
                            currDoctorAchievementId: GynecologyAchievementScreen.id,
                            achievementRoute: const GynecologyAchievementRoute(),
                            dateRoute: const GynecologyDateRoute(),
                            nextDoctorRoute: OnboardingDentistRoute(sex: user.sex!),
                          ),
                        );
                      }

                      /// Dentist Route
                      flows.add(
                        nextDoctorOnlyRoute(
                          prevDoctorCcaVisit: user.sex == Sex.male
                              ? user.generalPracticionerCcaVisit
                              : user.gynecologyCcaVisit,
                          prevDoctorDateVisit: user.sex == Sex.male
                              ? user.generalPracticionerVisitDate
                              : user.gynecologyVisitDate,
                          nextDoctorRoute: OnboardingDentistRoute(sex: user.sex!),
                        ),
                      );
                      flows.add(
                        dateOrAchievementOrNextDoctorRoute(
                          onboardingState: onboardingState,
                          currDoctorCcaVisit: user.dentistCcaVisit,
                          currDoctorAchievementId: DentistAchievementScreen.id,
                          achievementRoute: const DentistAchievementRoute(),
                          dateRoute: const DentistDateRoute(),
                          nextDoctorRoute: OnboardingDentistRoute(sex: user.sex!),
                        ),
                      );
                    }
                  }

                  return [flows.lastWhere((e) => e != null)!];
                },
              );
            },
          );
        },
      ),
    );
  }
}

PageRouteInfo<dynamic>? nextDoctorOnlyRoute({
  required CcaDoctorVisit? prevDoctorCcaVisit,
  required DateWithoutDay? prevDoctorDateVisit,
  required PageRouteInfo<dynamic> nextDoctorRoute,
}) {
  if (prevDoctorCcaVisit != null && prevDoctorDateVisit != null) {
    return nextDoctorRoute;
  }
}

PageRouteInfo<dynamic>? dateOrAchievementOrNextDoctorRoute({
  required OnboardingStateService onboardingState,
  required CcaDoctorVisit? currDoctorCcaVisit,
  required String currDoctorAchievementId,
  required PageRouteInfo<dynamic> achievementRoute,
  required PageRouteInfo<dynamic> dateRoute,
  required PageRouteInfo<dynamic> nextDoctorRoute,
}) {
  if (currDoctorCcaVisit != null) {
    if (currDoctorCcaVisit == CcaDoctorVisit.inLastTwoYears) {
      if (!onboardingState.containsAchievement(currDoctorAchievementId)) {
        return achievementRoute;
      } else {
        return dateRoute;
      }
    } else {
      return nextDoctorRoute;
    }
  }
}
