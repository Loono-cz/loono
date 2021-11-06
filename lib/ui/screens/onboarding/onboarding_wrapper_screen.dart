import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/models/user.dart';
import 'package:loono/routers/auth_router.dart';
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

                  final flows = <PageRouteInfo?>[];
                  if (onboardingState.hasQuestionnaireStatus) {
                    flows.add(const OnboardingGenderRoute());
                  }

                  final sex = user?.sex;
                  if (user != null && sex != null) {
                    flows.add(OnBoardingBirthdateRoute(sex: sex));

                    if (user.dateOfBirthRaw != null) {
                      // GeneralPractitioner Route
                      flows.addAll(
                        [
                          OnboardingGeneralPracticionerRoute(sex: sex),
                          _dateOrAchievementOrNextDoctorRoute(
                            onboardingState: onboardingState,
                            currDoctorCcaVisit: user.generalPracticionerCcaVisit,
                            examinationType: ExaminationType.GENERAL_PRACTITIONER,
                            achievementRoute: const GeneralPracticionerAchievementRoute(),
                            dateRoute: const GeneralPractitionerDateRoute(),
                            nextDoctorRoute: sex == Sex.female
                                ? OnboardingGynecologyRoute(sex: sex) as PageRouteInfo
                                : OnboardingDentistRoute(sex: sex),
                          ),
                        ],
                      );

                      // Gynecology Route (female only)
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
                              examinationType: ExaminationType.GYNECOLOGIST,
                              achievementRoute: const GynecologyAchievementRoute(),
                              dateRoute: const GynecologyDateRoute(),
                              nextDoctorRoute: OnboardingDentistRoute(sex: sex),
                            ),
                          ],
                        );
                      }

                      // Dentist Route
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
                            examinationType: ExaminationType.DENTIST,
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

PageRouteInfo? _nextDoctorOnlyRoute({
  required OnboardingStateService onboardingState,
  required CcaDoctorVisit? prevDoctorCcaVisit,
  required DateWithoutDay? prevDoctorDateVisit,
  PageRouteInfo allowNotificationsRoute = const AllowNotificationsRoute(),
  required PageRouteInfo nextDoctorRoute,
}) {
  if (prevDoctorCcaVisit != null && prevDoctorDateVisit != null) {
    if (onboardingState.hasNotRequestedNotificationsPermission) {
      return allowNotificationsRoute;
    }
    return nextDoctorRoute;
  }
}

PageRouteInfo? _dateOrAchievementOrNextDoctorRoute({
  required OnboardingStateService onboardingState,
  required CcaDoctorVisit? currDoctorCcaVisit,
  required ExaminationType examinationType,
  required PageRouteInfo achievementRoute,
  required PageRouteInfo dateRoute,
  PageRouteInfo allowNotificationsRoute = const AllowNotificationsRoute(),
  required PageRouteInfo nextDoctorRoute,
}) {
  if (currDoctorCcaVisit != null) {
    if (currDoctorCcaVisit == CcaDoctorVisit.inLastTwoYears) {
      if (!onboardingState.containsAchievement(examinationType)) {
        return achievementRoute;
      } else {
        if (onboardingState.isUniversalDoctorDateSkipped(examinationType)) {
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
