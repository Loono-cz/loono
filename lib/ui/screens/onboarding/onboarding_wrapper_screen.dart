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
import 'package:loono/ui/screens/onboarding/doctors/dentist_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/general_practitioner_date.dart';
import 'package:loono/ui/screens/onboarding/doctors/gynecology_date.dart';
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
      onWillPop: () async => false,
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
                  if (onboardingState.hasWelcomeStatus) return [const WelcomeRoute()];
                  if (onboardingState.hasIntroStatus) {
                    return const [
                      WelcomeRoute(),
                      OnboardingCarouselRoute(),
                    ];
                  }

                  final flows = <PageRouteInfo<dynamic>?>[];
                  if (onboardingState.hasQuestionnaireStatus) {
                    flows.add(const OnboardingGenderRoute());
                  }

                  final sex = user?.sex;
                  if (user != null && sex != null) {
                    flows.add(OnBoardingBirthdateRoute(sex: sex));

                    if (user.dateOfBirthRaw != null) {
                      /// GeneralPractitioner Route
                      flows.addAll(
                        [
                          OnboardingGeneralPracticionerRoute(sex: sex),
                          _dateOrAchievementOrNextDoctorRoute(
                            onboardingState: onboardingState,
                            currDoctorCcaVisit: user.generalPracticionerCcaVisit,
                            currDoctorAchievementId: GeneralPracticionerAchievementScreen.id,
                            currDoctorDateId: GeneralPractitionerDateScreen.id,
                            achievementRoute: const GeneralPracticionerAchievementRoute(),
                            dateRoute: const GeneralPractitionerDateRoute(),
                            nextDoctorRoute: sex == Sex.female
                                ? OnboardingGynecologyRoute(sex: sex) as PageRouteInfo<dynamic>
                                : OnboardingDentistRoute(sex: sex),
                          ),
                        ],
                      );

                      /// Gynecology Route (female only)
                      if (sex == Sex.female) {
                        flows.addAll(
                          [
                            _nextDoctorOnlyRoute(
                              onboardingState: onboardingState,
                              prevDoctorCcaVisit: user.generalPracticionerCcaVisit,
                              prevDoctorDateVisit: user.generalPracticionerVisitDate,
                              nextDoctorRoute: OnboardingGynecologyRoute(sex: sex),
                            ),
                            _dateOrAchievementOrNextDoctorRoute(
                              onboardingState: onboardingState,
                              currDoctorCcaVisit: user.gynecologyCcaVisit,
                              currDoctorAchievementId: GynecologyAchievementScreen.id,
                              currDoctorDateId: GynecologyDateScreen.id,
                              achievementRoute: const GynecologyAchievementRoute(),
                              dateRoute: const GynecologyDateRoute(),
                              nextDoctorRoute: OnboardingDentistRoute(sex: sex),
                            ),
                          ],
                        );
                      }

                      /// Dentist Route
                      flows.addAll(
                        [
                          _nextDoctorOnlyRoute(
                            onboardingState: onboardingState,
                            prevDoctorCcaVisit: sex == Sex.male
                                ? user.generalPracticionerCcaVisit
                                : user.gynecologyCcaVisit,
                            prevDoctorDateVisit: sex == Sex.male
                                ? user.generalPracticionerVisitDate
                                : user.gynecologyVisitDate,
                            nextDoctorRoute: OnboardingDentistRoute(sex: sex),
                          ),
                          _dateOrAchievementOrNextDoctorRoute(
                            onboardingState: onboardingState,
                            currDoctorCcaVisit: user.dentistCcaVisit,
                            currDoctorAchievementId: DentistAchievementScreen.id,
                            currDoctorDateId: DentistDateScreen.id,
                            achievementRoute: const DentistAchievementRoute(),
                            dateRoute: const DentistDateRoute(),
                            nextDoctorRoute: OnboardingDentistRoute(sex: sex),
                          ),
                        ],
                      );
                    }
                  }

                  return [flows.lastWhere((route) => route != null) ?? const WelcomeRoute()];
                },
              );
            },
          );
        },
      ),
    );
  }
}

PageRouteInfo<dynamic>? _nextDoctorOnlyRoute({
  required OnboardingStateService onboardingState,
  required CcaDoctorVisit? prevDoctorCcaVisit,
  required DateWithoutDay? prevDoctorDateVisit,
  PageRouteInfo<dynamic> allowNotificationsRoute = const AllowNotificationsRoute(),
  required PageRouteInfo<dynamic> nextDoctorRoute,
}) {
  if (prevDoctorCcaVisit != null && prevDoctorDateVisit != null) {
    if (onboardingState.hasNotRequestedNotificationsPermission) {
      return allowNotificationsRoute;
    }
    return nextDoctorRoute;
  }
}

PageRouteInfo<dynamic>? _dateOrAchievementOrNextDoctorRoute({
  required OnboardingStateService onboardingState,
  required CcaDoctorVisit? currDoctorCcaVisit,
  required String currDoctorAchievementId,
  required String currDoctorDateId,
  required PageRouteInfo<dynamic> achievementRoute,
  required PageRouteInfo<dynamic> dateRoute,
  PageRouteInfo<dynamic> allowNotificationsRoute = const AllowNotificationsRoute(),
  required PageRouteInfo<dynamic> nextDoctorRoute,
}) {
  if (currDoctorCcaVisit != null) {
    if (currDoctorCcaVisit == CcaDoctorVisit.inLastTwoYears) {
      if (!onboardingState.containsAchievement(currDoctorAchievementId)) {
        return achievementRoute;
      } else {
        if (onboardingState.isUniversalDoctorDateSkipped(currDoctorDateId)) {
          if (onboardingState.hasNotRequestedNotificationsPermission) {
            return allowNotificationsRoute;
          }
          return nextDoctorRoute;
        }
        return dateRoute;
      }
    } else {
      return nextDoctorRoute;
    }
  }
}
