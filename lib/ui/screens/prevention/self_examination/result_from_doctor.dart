import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

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
                                child: IconButton(
                                  onPressed: () {
                                    AutoRouter.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 32,
                                  ),
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
                              sex == Sex.MALE
                                  ? context.l10n.self_examination_cancer_male
                                  : context.l10n.self_examination_cancer_female,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 300),
                            child: LoonoButton.light(
                              text: context.l10n.self_examination_everything_good,
                              // TODO: call BE we notify normally
                              onTap: () async {
                                await registry.get<ApiService>().resultSelfExamination(
                                  selfExamination.type,
                                  result: SelfExaminationResult((b) {
                                    b.result = SelfExaminationResultResultEnum.OK;
                                  }),
                                );
                                AutoRouter.of(context).popUntilRouteWithName(MainRoute.name);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: LoonoButton.light(
                              text: context.l10n.self_examination_it_is_cancer,
                              // TODO: call BE we don't ever notify
                              onTap: () async {
                                await registry.get<ApiService>().resultSelfExamination(
                                  selfExamination.type,
                                  result: SelfExaminationResult((b) {
                                    b.result = SelfExaminationResultResultEnum.NOT_OK;
                                  }),
                                );
                                AutoRouter.of(context).popUntilRouteWithName(MainRoute.name);
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
}
