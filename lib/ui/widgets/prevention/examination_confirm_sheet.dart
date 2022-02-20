import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/how/loon_botton_sheet.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

void showConfirmationSheet(
  BuildContext context,
  ExaminationType examinationType,
  Sex sex,
  String? uuid,
) {
  final practitioner =
      procedureQuestionTitle(context, examinationType: examinationType).toLowerCase();
  final preposition = czechPreposition(context, examinationType: examinationType);

  Future<void> _completedAction() async {
    AutoRouter.of(context).popUntilRouteWithName(const MainRoute().routeName);
  }

  final l10n = context.l10n;

  final _api = registry.get<ExaminationRepository>();
  final _calendar = registry.get<CalendarRepository>();

  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (BuildContext context) {
      return LoonBottomSheet(
        child: Column(
          children: <Widget>[
            Text(
              '${l10n.checkup_confirmation_title} $preposition $practitioner?',
              style: LoonoFonts.headerFontStyle,
            ),
            const SizedBox(
              height: 60,
            ),

            /// old api implementation, needs api update
            AsyncLoonoApiButton(
              text:
                  '${l10n.yes}, ${sex == Sex.MALE ? l10n.checkup_confirmation_male.toLowerCase() : l10n.checkup_confirmation_female.toLowerCase()}',
              asyncCallback: () async {
                final response = await _api.confirmExamination(
                  examinationType,
                  uuid: uuid,
                );
                await response.map(
                  success: (res) async {
                    await _calendar.deleteOnlyDbEvent(examinationType);
                    Provider.of<ExaminationsProvider>(context, listen: false)
                        .updateExaminationsRecord(res.data);
                    await AutoRouter.of(context).navigate(
                      AchievementRoute(
                        header: 'TO DO: complete all rewards',
                        textLines: [l10n.award_desc],
                        numberOfPoints: examinationType.awardPoints,
                        itemPath: 'assets/badges/achievement/cloak-level_1.svg',
                        onButtonTap: _completedAction,
                      ),
                    );
                  },
                  failure: (error) async {
                    await AutoRouter.of(context).pop();
                    showSnackBarError(context, message: context.l10n.something_went_wrong);
                  },
                );
              },
            )
          ],
        ),
      );
    },
  );
}
