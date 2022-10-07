import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/onboarding_state_helpers.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class OnboardingWrapperScreen extends StatefulWidget {
  const OnboardingWrapperScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingWrapperScreen> createState() => _OnboardingWrapperScreenState();
}

class _OnboardingWrapperScreenState extends State<OnboardingWrapperScreen> {
  final _usersDao = registry.get<DatabaseService>().users;
  final _examinationQuestionnairesDao = registry.get<DatabaseService>().examinationQuestionnaires;

  Future<void> _createOnboardingExaminationQuestionnaires() async {
    final existingQuestionnaires = await _examinationQuestionnairesDao.getAll();
    if (existingQuestionnaires.isEmpty) {
      _shouldShowNotificationScreen = true;
      await _examinationQuestionnairesDao.createQuestionnaires([
        ExaminationType.GENERAL_PRACTITIONER,
        ExaminationType.GYNECOLOGY_AND_OBSTETRICS,
        ExaminationType.DENTIST,
      ]);
    }
  }

  @override
  void initState() {
    super.initState();
    _createOnboardingExaminationQuestionnaires();
  }

  // we want to show this screen only once and not again if the user decide to come back to
  // the questionnaire (OnboardingState Provider lives only during app lifecycle)
  bool _shouldShowNotificationScreen = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ChangeNotifierProvider<OnboardingStateService>(
        create: (_) => OnboardingStateService(
          notificationService: registry.get<NotificationService>(),
        ),
        builder: (context, _) {
          final onboardingState = context.watch<OnboardingStateService>();

          return StreamBuilder<User?>(
            stream: _usersDao.watchUser(),
            builder: (context, snapshot) {
              final user = snapshot.data;

              return StreamBuilder<List<ExaminationQuestionnaire>?>(
                stream: _examinationQuestionnairesDao.watchAll(),
                builder: (context, snapshot) {
                  final examinationQuestionnaires = snapshot.data;

                  return AutoRouter.declarative(
                    routes: (context) {
                      final onboardingFlow = <PageRouteInfo?>[const OnboardingGenderRoute()];

                      final sex = user?.sex;
                      if (user != null && sex != null) {
                        onboardingFlow.add(OnBoardingBirthdateRoute(sex: sex));

                        if (user.dateOfBirth != null && examinationQuestionnaires != null) {
                          // GeneralPractitioner Route
                          final generalPractitionerQuestionnaire =
                              examinationQuestionnaires.generalPractitionerQuestionnaire;
                          onboardingFlow.addAll(
                            [
                              OnboardingGeneralPracticionerRoute(sex: sex),
                              _dateOrAchievementOrNextDoctorRoute(
                                onboardingState: onboardingState,
                                shouldShowAllowNotificationScreen: _shouldShowNotificationScreen,
                                currDoctorCcaVisit:
                                    generalPractitionerQuestionnaire?.ccaDoctorVisit,
                                examinationType: ExaminationType.GENERAL_PRACTITIONER,
                                achievementRoute: const GeneralPracticionerAchievementRoute(),
                                dateRoute: const GeneralPractitionerDateRoute(),
                                isDatePickerFormFilled:
                                    generalPractitionerQuestionnaire?.isDatePickerFormFilled,
                                nextDoctorRoute: sex == Sex.FEMALE
                                    ? OnboardingGynecologyRoute(sex: sex) as PageRouteInfo
                                    : OnboardingDentistRoute(sex: sex),
                              ),
                            ],
                          );

                          // Gynecology Route (female only)
                          final gynecologistQuestionnaire =
                              examinationQuestionnaires.gynecologistQuestionnaire;
                          if (sex == Sex.FEMALE) {
                            onboardingFlow.addAll(
                              [
                                _nextDoctorOnlyRoute(
                                  onboardingState: onboardingState,
                                  shouldShowAllowNotificationScreen: _shouldShowNotificationScreen,
                                  prevDoctorCcaVisit:
                                      generalPractitionerQuestionnaire?.ccaDoctorVisit,
                                  isPrevDatePickerFormFilled:
                                      generalPractitionerQuestionnaire?.isDatePickerFormFilled,
                                  nextDoctorRoute: OnboardingGynecologyRoute(sex: sex),
                                ),
                                _dateOrAchievementOrNextDoctorRoute(
                                  onboardingState: onboardingState,
                                  shouldShowAllowNotificationScreen: _shouldShowNotificationScreen,
                                  currDoctorCcaVisit: gynecologistQuestionnaire?.ccaDoctorVisit,
                                  examinationType: ExaminationType.GYNECOLOGY_AND_OBSTETRICS,
                                  achievementRoute: const GynecologyAchievementRoute(),
                                  dateRoute: const GynecologyDateRoute(),
                                  isDatePickerFormFilled:
                                      gynecologistQuestionnaire?.isDatePickerFormFilled,
                                  nextDoctorRoute: OnboardingDentistRoute(sex: sex),
                                ),
                              ],
                            );
                          }

                          // Dentist Route
                          final dentistQuestionnaire =
                              examinationQuestionnaires.dentistQuestionnaire;
                          onboardingFlow.addAll(
                            [
                              _nextDoctorOnlyRoute(
                                onboardingState: onboardingState,
                                shouldShowAllowNotificationScreen: _shouldShowNotificationScreen,
                                prevDoctorCcaVisit: sex == Sex.MALE
                                    ? generalPractitionerQuestionnaire?.ccaDoctorVisit
                                    : gynecologistQuestionnaire?.ccaDoctorVisit,
                                isPrevDatePickerFormFilled: sex == Sex.MALE
                                    ? generalPractitionerQuestionnaire?.isDatePickerFormFilled
                                    : gynecologistQuestionnaire?.isDatePickerFormFilled,
                                nextDoctorRoute: OnboardingDentistRoute(sex: sex),
                              ),
                              _dateOrAchievementOrNextDoctorRoute(
                                onboardingState: onboardingState,
                                shouldShowAllowNotificationScreen: _shouldShowNotificationScreen,
                                currDoctorCcaVisit: dentistQuestionnaire?.ccaDoctorVisit,
                                examinationType: ExaminationType.DENTIST,
                                achievementRoute: const DentistAchievementRoute(),
                                dateRoute: const DentistDateRoute(),
                                isDatePickerFormFilled:
                                    dentistQuestionnaire?.isDatePickerFormFilled,
                                nextDoctorRoute: OnboardingDentistRoute(sex: sex),
                              ),
                            ],
                          );
                        }
                      }

                      return [
                        onboardingFlow.lastWhere((route) => route != null) ??
                            const OnboardingGenderRoute(),
                      ];
                    },
                  );
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
  required bool? isPrevDatePickerFormFilled,
  required bool shouldShowAllowNotificationScreen,
  required PageRouteInfo nextDoctorRoute,
}) {
  if (prevDoctorCcaVisit != null && isPrevDatePickerFormFilled == true) {
    if (onboardingState.hasNotRequestedNotificationsPermissionYet &&
        shouldShowAllowNotificationScreen) {
      return AllowNotificationsRoute();
    }
    return nextDoctorRoute;
  }
  return null;
}

PageRouteInfo? _dateOrAchievementOrNextDoctorRoute({
  required OnboardingStateService onboardingState,
  required CcaDoctorVisit? currDoctorCcaVisit,
  required ExaminationType examinationType,
  required PageRouteInfo achievementRoute,
  required PageRouteInfo dateRoute,
  required bool? isDatePickerFormFilled,
  required bool shouldShowAllowNotificationScreen,
  required PageRouteInfo nextDoctorRoute,
}) {
  if (currDoctorCcaVisit != null) {
    if (currDoctorCcaVisit == CcaDoctorVisit.inLastXYears) {
      if (!onboardingState.containsAchievement(examinationType)) {
        return achievementRoute;
      } else {
        if (isDatePickerFormFilled == true) {
          if (onboardingState.hasNotRequestedNotificationsPermissionYet &&
              shouldShowAllowNotificationScreen) {
            return AllowNotificationsRoute();
          }
          return nextDoctorRoute;
        }
        return dateRoute;
      }
    } else {
      return nextDoctorRoute;
    }
  }
  return null;
}
