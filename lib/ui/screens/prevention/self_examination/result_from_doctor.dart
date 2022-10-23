import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class ResultFromDoctorScreen extends StatelessWidget {
  const ResultFromDoctorScreen({
    Key? key,
    required this.sex,
    required this.selfExamination,
  }) : super(key: key);
  final Sex sex;
  final SelfExaminationPreventionStatus selfExamination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Stack(
                  children: [
                    Positioned(
                      right: -50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(107),
                        child: Container(
                          color: LoonoColors.beigeLighter,
                          width: 207,
                          height: 207,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: LoonoCloseButton(
                                  onPressed: () => AutoRouter.of(context).pop(),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                context.l10n.self_examination_result_from_doctor,
                                style: LoonoFonts.headerFontStyle.copyWith(
                                  color: LoonoColors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _getSubtitleText(context),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 300),
                            child: AsyncLoonoLightApiButton(
                              text: context.l10n.self_examination_everything_good,
                              asyncCallback: () async {
                                final examProvider =
                                    Provider.of<ExaminationsProvider>(context, listen: false);
                                final autoRouter = AutoRouter.of(context);
                                await registry.get<ApiService>().resultSelfExamination(
                                  selfExamination.type,
                                  result: SelfExaminationResult((b) {
                                    b.result = SelfExaminationResultResultEnum.OK;
                                  }),
                                );
                                unawaited(
                                  examProvider.fetchExaminations(),
                                );
                                autoRouter.popUntilRouteWithName(MainRoute.name);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: AsyncLoonoLightApiButton(
                              text: context.l10n.self_examination_it_is_cancer,
                              asyncCallback: () async {
                                final examProvider =
                                    Provider.of<ExaminationsProvider>(context, listen: false);
                                final autoRouter = AutoRouter.of(context);
                                await registry.get<ApiService>().resultSelfExamination(
                                  selfExamination.type,
                                  result: SelfExaminationResult((b) {
                                    b.result = SelfExaminationResultResultEnum.NOT_OK;
                                  }),
                                );
                                unawaited(
                                  examProvider.fetchExaminations(),
                                );
                                autoRouter.popUntilRouteWithName(MainRoute.name);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String _getSubtitleText(BuildContext context){
    switch(selfExamination.type){
      case SelfExaminationType.BREAST:
        return context.l10n.self_examination_cancer_breast;
      case SelfExaminationType.TESTICULAR:
        return context.l10n.self_examination_cancer_testicular;
      case SelfExaminationType.SKIN:
        return context.l10n.self_examination_cancer_skin;
      default:
        return '';
    }
  }
}
