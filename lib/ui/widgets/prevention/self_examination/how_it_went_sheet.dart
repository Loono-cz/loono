import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/how/loon_botton_sheet.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

void showHowItWentSheet(
  BuildContext context,
  Sex sex,
  SelfExaminationPreventionStatus selfExamination,
) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (context) {
      return LoonBottomSheet(
        sheetHeight: 400,
        child: Column(
          children: <Widget>[
            Text(context.l10n.self_exam_how_it_went, style: LoonoFonts.headerFontStyle),
            const SizedBox(height: 60),
            LoonoButton.light(
              text: context.l10n.self_exam_how_it_went_ok,
              onTap: () async {
                await registry.get<ApiService>().confirmSelfExamination(
                  selfExamination.type,
                  result: SelfExaminationResult((b) {
                    b.result = SelfExaminationResultResultEnum.OK;
                  }),
                );
                unawaited(
                  Provider.of<ExaminationsProvider>(context, listen: false).fetchExaminations(),
                );
                await AutoRouter.of(context)
                    .popAndPush(NoFindingRoute(points: selfExamination.points));
              },
            ),
            const SizedBox(height: 20),
            LoonoButton.light(
              text: sex == Sex.FEMALE
                  ? context.l10n.self_exam_how_it_went_finding_female
                  : context.l10n.self_exam_how_it_went_finding_male,
              onTap: () async {
                await registry.get<ApiService>().confirmSelfExamination(
                  selfExamination.type,
                  result: SelfExaminationResult((b) {
                    b.result = SelfExaminationResultResultEnum.FINDING;
                  }),
                );
                unawaited(
                  Provider.of<ExaminationsProvider>(context, listen: false).fetchExaminations(),
                );
                await AutoRouter.of(context).popAndPush(HasFindingRoute(sex: sex));
              },
            ),
          ],
        ),
      );
    },
  );
}
