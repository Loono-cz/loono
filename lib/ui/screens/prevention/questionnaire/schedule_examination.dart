import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/achievement_helpers.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/helpers/sex_extensions.dart';
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

  void _navigateToDetail(
    BuildContext context,
    ExaminationsProvider provider, {
    String? message,
  }) {
    /// TODO: this whole post-auth navigation needs refactor as part of https://cesko-digital.atlassian.net/browse/LOON-571
    /// to get rid of initialMessage and stateful widget from exam detail
    final exam = provider.examinations?.examinations.firstWhereOrNull(
      (item) => item.examinationType == _examinationType,
    );
    if (exam != null) {
      _appRouter
        ..popUntilRouteWithName(const MainScreenRouter().routeName)
        ..navigate(
          ExaminationDetailRoute(
            uuid: exam.uuid!,
            categorizedExamination: CategorizedExamination(
              examination: exam,
              category: exam.calculateStatus(),
            ),
            initialMessage: message,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final examinationsProvider = Provider.of<ExaminationsProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: UniversalDoctor(
              examinationType: _examinationType,
              question: _sex.getUniversalDoctorLabel(context),
              questionHeader: procedureQuestionTitle(context, examinationType: _examinationType),
              assetPath: examinationRecord.examinationType.assetPath,
              button1Text: getQuestionnaireFirstAnswer(context, interval: _interval),
              button2Text: getQuestionnaireSecondAnswer(context, interval: _interval),
              isAsync: true,
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
                                              newDate: Date.now().toDateTime(),
                                            );
                                    response.map(
                                      success: (res) {
                                        examinationsProvider.updateExaminationsRecord(res.data);
                                        registry.get<UserRepository>().sync();
                                        _navigateToDetail(
                                          context,
                                          examinationsProvider,
                                          message: context.l10n.checkup_reminder_toast,
                                        );
                                      },
                                      failure: (err) {
                                        _appRouter.popUntilRouteWithName(
                                          const MainScreenRouter().routeName,
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
                                        _navigateToDetail(
                                          context,
                                          examinationsProvider,
                                          message: context.l10n.checkup_reminder_toast,
                                        );
                                      },
                                      failure: (err) {
                                        _appRouter.popUntilRouteWithName(
                                          const MainScreenRouter().routeName,
                                        );
                                        showFlushBarError(
                                          context,
                                          context.l10n.something_went_wrong,
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
                    _navigateToDetail(context, examinationsProvider);
                    await registry.get<UserRepository>().sync();
                  },
                  failure: (err) async {
                    await _appRouter.pop();
                    //TODO: fix lint.
                    // ignore: use_build_context_synchronously
                    showFlushBarError(context, context.l10n.something_went_wrong);
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
