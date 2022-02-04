import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/universal_doctor.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class ScheduleExamination extends StatelessWidget {
  ScheduleExamination({
    Key? key,
    required this.examinationRecord,
  }) : super(key: key);

  final ExaminationRecordTemp examinationRecord;

  final _appRouter = registry.get<AppRouter>();

  ExaminationTypeEnum get _examinationType => examinationRecord.examinationType;

  int get _interval => examinationRecord.interval;

  Sex get _sex {
    final user = registry.get<DatabaseService>().users.user;
    return user?.sex ?? Sex.MALE;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: IconButton(
              onPressed: () => AutoRouter.of(context).pop(),
              icon: SvgPicture.asset('assets/icons/arrow_back.svg'),
            ),
          ),
          Expanded(
            child: UniversalDoctor(
              examinationType: examinationRecord.examinationType,
              question: _sex.getUniversalDoctorLabel(context),
              questionHeader: procedureQuestionTitle(context, examinationType: _examinationType),
              assetPath: examinationRecord.examinationType.assetPath,
              button1Text: getQuestionnaireFirstAnswer(context, interval: _interval),
              button2Text: getQuestionnaireSecondAnswer(context, interval: _interval),
              nextCallback1: () {
                _appRouter.navigate(
                  MainScreenRouter(
                    children: [
                      AchievementRoute(
                        header: 'TODO',
                        textLines: const [
                          'TODO',
                          'TODO',
                        ],
                        numberOfPoints: examinationRecord.worth,
                        itemPath: 'assets/icons/coat-practitioner.svg',
                        onButtonTap: () {
                          _appRouter.navigate(
                            MainScreenRouter(
                              children: [
                                DatePickerRoute(
                                  assetPath: _examinationType.assetPath,
                                  title: _examinationType.l10n_name,
                                  onSkipButtonPress: (date) {
                                    // TODO: save to api, navigate to updated ExaminationDetail
                                    showSnackBarError(context, message: 'TODO: save to API');
                                    _appRouter.navigate(const MainScreenRouter());
                                  },
                                  onContinueButtonPress: (pickedDate) {
                                    // TODO: save to api, navigate to updated ExaminationDetail
                                    showSnackBarError(context, message: 'TODO: save to API');
                                    _appRouter.navigate(const MainScreenRouter());
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
              nextCallback2: () {
                // TODO: save to api, navigate to updated ExaminationDetail
                showSnackBarError(context, message: 'TODO: save to API');
                _appRouter.navigate(const MainScreenRouter());
              },
            ),
          ),
        ],
      ),
    );
  }
}
