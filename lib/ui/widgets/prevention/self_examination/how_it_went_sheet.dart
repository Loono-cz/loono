import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/how/loon_botton_sheet.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

void showHowItWentSheet(BuildContext context, Sex sex, int points) {
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
            const Text(
              'Jak to dopadlo?',
              style: LoonoFonts.headerFontStyle,
            ),
            const SizedBox(height: 60),
            LoonoButton.light(
              text: 'Je to v pořádku',
              onTap: () async {
                // TODO: temporary call for debug
                await registry.get<ApiService>().confirmSelfExamination(
                  SelfExaminationType.TESTICULAR,
                  result: SelfExaminationResult((b) {
                    b.result = SelfExaminationResultResultEnum.OK;
                  }),
                );
                await Provider.of<ExaminationsProvider>(context, listen: false).fetchExaminations();
                await AutoRouter.of(context).push(NoFindingRoute(points: points));
              },
            ),
            const SizedBox(height: 20),
            LoonoButton.light(
              text: 'Něco jsem našla',
              onTap: () async {
                // TODO: temporary call for debug
                await registry.get<ApiService>().confirmSelfExamination(
                  SelfExaminationType.TESTICULAR,
                  result: SelfExaminationResult((b) {
                    b.result = SelfExaminationResultResultEnum.FINDING;
                  }),
                );
                await Provider.of<ExaminationsProvider>(context, listen: false).fetchExaminations();
                await AutoRouter.of(context).push(HasFindingRoute(sex: sex));
              },
            ),
          ],
        ),
      );
    },
  );
}
