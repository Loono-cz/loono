import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/helpers/achievement_helpers.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/universal_doctor.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class ScheduleExamination extends StatelessWidget {
  ScheduleExamination({
    Key? key,
    required this.examinationRecord,
  }) : super(key: key);

  final ExaminationPreventionStatus examinationRecord;

  final _appRouter = registry.get<AppRouter>();

  ExaminationType get _examinationType => examinationRecord.examinationType;

  int get _interval => examinationRecord.intervalYears;

  Sex get _sex {
    final user = registry.get<DatabaseService>().users.user;
    return user?.sex ?? Sex.MALE;
  }

  void _navigateToDetail(BuildContext context, ExaminationsProvider provider) {
    final exam = provider.examinations?.examinations.firstWhereOrNull(
      (item) => item.examinationType == _examinationType,
    );
    if (exam != null) {
      _appRouter
        ..popUntilRouteWithName(const MainScreenRouter().routeName)
        ..navigate(
          ExaminationDetailRoute(
            categorizedExamination: CategorizedExamination(
              examination: exam,
              category: exam.calculateStatus(),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _examinationsProvider = Provider.of<ExaminationsProvider>(context, listen: false);
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
              examinationType: _examinationType,
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
                        header: getAchievementTitle(context, _examinationType),
                        textLines: [context.l10n.achievement_description_subtitle],
                        numberOfPoints: examinationRecord.points,
                        itemPath: getAchievementAssetPath(_examinationType),
                        onButtonTap: () {
                          _appRouter.navigate(
                            MainScreenRouter(
                              children: [
                                DatePickerRoute(
                                  assetPath: _examinationType.assetPath,
                                  title: _examinationType.l10n_name,
                                  onSkipButtonPress: (date) async {
                                    /// code anchor: #postFirstNewExaminationUnknownDate
                                    final response =
                                        await registry.get<ExaminationRepository>().postExamination(
                                              _examinationType,
                                              uuid: examinationRecord.uuid,
                                              firstExam: true,
                                              status: ExaminationStatus.UNKNOWN,
                                              newDate: DateTime.now(),
                                            );
                                    response.map(
                                      success: (res) {
                                        _examinationsProvider.updateExaminationsRecord(res.data);
                                        registry.get<UserRepository>().sync();
                                        _navigateToDetail(context, _examinationsProvider);
                                      },
                                      failure: (err) {
                                        _appRouter.popUntilRouteWithName(
                                          const MainScreenRouter().routeName,
                                        );
                                        showSnackBarError(
                                          context,
                                          message: context.l10n.something_went_wrong,
                                        );
                                      },
                                    );
                                  },
                                  onContinueButtonPress: (pickedDate) async {
                                    /// code anchor: #postFirstNewExaminationKnownDate
                                    final response =
                                        await registry.get<ExaminationRepository>().postExamination(
                                              _examinationType,
                                              uuid: examinationRecord.uuid,
                                              firstExam: true,
                                              newDate: pickedDate,
                                              status: ExaminationStatus.CONFIRMED,
                                            );
                                    response.map(
                                      success: (res) {
                                        Provider.of<ExaminationsProvider>(context, listen: false)
                                            .updateExaminationsRecord(res.data);
                                        registry.get<UserRepository>().sync();
                                        _navigateToDetail(context, _examinationsProvider);
                                        showSnackBarSuccess(
                                          context,
                                          message: context.l10n.checkup_reminder_toast,
                                        );
                                      },
                                      failure: (err) {
                                        _appRouter.popUntilRouteWithName(
                                          const MainScreenRouter().routeName,
                                        );
                                        showSnackBarError(
                                          context,
                                          message: context.l10n.something_went_wrong,
                                        );
                                      },
                                    );
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
              nextCallback2: () async {
                /// code anchor: #postFirstNewExaminationMore
                final response = await registry.get<ExaminationRepository>().postExamination(
                      examinationRecord.examinationType,
                      uuid: examinationRecord.uuid,
                      firstExam: true,
                      status: ExaminationStatus.UNKNOWN,
                    );
                await response.map(
                  success: (res) async {
                    Provider.of<ExaminationsProvider>(context, listen: false)
                        .updateExaminationsRecord(res.data);
                    _navigateToDetail(context, _examinationsProvider);
                    await registry.get<UserRepository>().sync();
                  },
                  failure: (err) async {
                    await _appRouter.pop();
                    showSnackBarError(context, message: context.l10n.something_went_wrong);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
