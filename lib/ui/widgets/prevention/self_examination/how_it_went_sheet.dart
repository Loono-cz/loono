import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/how/loon_botton_sheet.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

void showHowItWentSheet(
  BuildContext context,
  Sex sex,
  SelfExaminationPreventionStatus selfExamination,
) {
  registry.get<FirebaseAnalytics>().logEvent(name: 'OpenHowItWentModal');
  final userRepository = registry.get<UserRepository>();
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (context) {
      return LoonBottomSheet(
        key: const Key('selfExaminationDetailPage_howItWentModal'),
        sheetHeight: 400,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.l10n.self_exam_how_it_went,
                style: LoonoFonts.headerFontStyle,
              ),
            ),
            const SizedBox(height: 60),
            AsyncLoonoLightApiButton(
              key: const Key('selfExaminationDetailPage_howItWentModal_okBtn'),
              text: context.l10n.self_exam_how_it_went_ok,
              asyncCallback: () async {
                final apiRes = await registry.get<ApiService>().confirmSelfExamination(
                  selfExamination.type,
                  result: SelfExaminationResult((b) {
                    b.result = SelfExaminationResultResultEnum.OK;
                  }),
                );
                unawaited(
                  Provider.of<ExaminationsProvider>(context, listen: false).fetchExaminations(),
                );
                await apiRes.whenOrNull(
                  success: (data) async {
                    await userRepository.updateCurrentUserFromSelfExamCompletion(data);
                    await AutoRouter.of(context).popAndPush(
                      NoFindingRoute(
                        type: selfExamination.type,
                        points: selfExamination.points,
                        history: selfExamination.history,
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            AsyncLoonoLightApiButton(
              key: const Key('selfExaminationDetailPage_howItWentModal_hasFindingBtn'),
              text: sex == Sex.FEMALE
                  ? context.l10n.self_exam_how_it_went_finding_female
                  : context.l10n.self_exam_how_it_went_finding_male,
              asyncCallback: () async {
                final apiRes = await registry.get<ApiService>().confirmSelfExamination(
                  selfExamination.type,
                  result: SelfExaminationResult((b) {
                    b.result = SelfExaminationResultResultEnum.FINDING;
                  }),
                );
                await apiRes.whenOrNull(
                  success: (data) async =>
                      userRepository.updateCurrentUserFromSelfExamCompletion(data),
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
  ).whenComplete(() {
    registry.get<FirebaseAnalytics>().logEvent(name: 'CloseHowItWentModal');
  });
}
