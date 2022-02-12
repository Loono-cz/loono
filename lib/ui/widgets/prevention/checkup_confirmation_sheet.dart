import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/how/loon_botton_sheet.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

void showConfirmationSheet(BuildContext context, ExaminationTypeEnum examinationType, Sex sex) {
  final practitioner =
      procedureQuestionTitle(context, examinationType: examinationType).toLowerCase();
  final preposition = czechPreposition(context, examinationType: examinationType);

  Future<void> _completedAction() async {
    await registry.get<CalendarRepository>().deleteOnlyDbEvent(examinationType);
    AutoRouter.of(context).popUntilRouteWithName('ExaminationDetailRoute');
    showSnackBarError(context, message: 'TODO: save to API');
  }

  final l10n = context.l10n;

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
              '${context.l10n.checkup_confirmation_title} $preposition $practitioner?',
              style: LoonoFonts.headerFontStyle,
            ),
            const SizedBox(
              height: 60,
            ),

            /// Leaving this here for testing. Button switch will be implemented in progress bar task
            /// All achievement and assets not implemented yet. Should be completed in separate task.
            /// As of now, API for completion doesnt exists. Should be completed in separate task.
            LoonoButton(
              text:
                  '${l10n.yes}, ${sex == Sex.MALE ? l10n.checkup_confirmation_male.toLowerCase() : l10n.checkup_confirmation_female.toLowerCase()}',
              onTap: () => AutoRouter.of(context).navigate(
                AchievementRoute(
                  header: 'TO DO: complete all rewards',
                  textLines: [context.l10n.award_desc],
                  numberOfPoints: examinationType.awardPoints,
                  itemPath: 'assets/icons/coat-practitioner.svg',
                  onButtonTap: _completedAction,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
