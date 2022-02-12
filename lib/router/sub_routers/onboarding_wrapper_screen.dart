import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/onboarding_state_helpers.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono/services/onboarding_state_service.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart' hide User;
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
      await _examinationQuestionnairesDao
          .createQuestionnaire(ExaminationTypeEnum.GENERAL_PRACTITIONER);
      await _examinationQuestionnairesDao.createQuestionnaire(ExaminationTypeEnum.GYNECOLOGIST);
      await _examinationQuestionnairesDao.createQuestionnaire(ExaminationTypeEnum.DENTIST);
    }
  }

  @override
  void initState() {
    super.initState();
    _createOnboardingExaminationQuestionnaires();
  }

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

                        if (user.dateOfBirthRaw != null && examinationQuestionnaires != null) {
                          // GeneralPractitioner Route
                          final generalPractitionerQuestionnaire =
                              examinationQuestionnaires.generalPractitionerQuestionnaire;
                          onboardingFlow.addAll(
                            [
                              OnboardingGeneralPracticionerRoute(sex: sex),
                              _dateOrAchievementOrNextDoctorRoute(
                                onboardingState: onboardingState,
                                currDoctorCcaVisit:
                                    generalPractitionerQuestionnaire?.ccaDoctorVisit,
                                examinationType: ExaminationTypeEnum.GENERAL_PRACTITIONER,
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
                                  prevDoctorCcaVisit:
                                      generalPractitionerQuestionnaire?.ccaDoctorVisit,
                                  isPrevDatePickerFormFilled:
                                      generalPractitionerQuestionnaire?.isDatePickerFormFilled,
                                  nextDoctorRoute: OnboardingGynecologyRoute(sex: sex),
                                ),
                                _dateOrAchievementOrNextDoctorRoute(
                                  onboardingState: onboardingState,
                                  currDoctorCcaVisit: gynecologistQuestionnaire?.ccaDoctorVisit,
                                  examinationType: ExaminationTypeEnum.GYNECOLOGIST,
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
                                currDoctorCcaVisit: dentistQuestionnaire?.ccaDoctorVisit,
                                examinationType: ExaminationTypeEnum.DENTIST,
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
  PageRouteInfo allowNotificationsRoute = const AllowNotificationsRoute(),
  required PageRouteInfo nextDoctorRoute,
}) {
  if (prevDoctorCcaVisit != null && isPrevDatePickerFormFilled == true) {
    if (onboardingState.hasNotRequestedNotificationsPermission) {
      return allowNotificationsRoute;
    }
    return nextDoctorRoute;
  }
  return null;
}

PageRouteInfo? _dateOrAchievementOrNextDoctorRoute({
  required OnboardingStateService onboardingState,
  required CcaDoctorVisit? currDoctorCcaVisit,
  required ExaminationTypeEnum examinationType,
  required PageRouteInfo achievementRoute,
  required PageRouteInfo dateRoute,
  required bool? isDatePickerFormFilled,
  PageRouteInfo allowNotificationsRoute = const AllowNotificationsRoute(),
  required PageRouteInfo nextDoctorRoute,
}) {
  if (currDoctorCcaVisit != null) {
    if (currDoctorCcaVisit == CcaDoctorVisit.inLastXYears) {
      if (!onboardingState.containsAchievement(examinationType)) {
        return achievementRoute;
      } else {
        if (isDatePickerFormFilled == true) {
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
  return null;
}
