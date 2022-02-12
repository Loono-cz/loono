import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono_api/loono_api.dart';

void showLastVisitSheet({
  required BuildContext context,
  required String? uuid,
  required ExaminationTypeEnum examinationType,
  required Sex sex,
  required int examinationIntervalYears,
  required DateTime skippedDate,
  required ExaminationCategory status,
}) {
  final l10n = context.l10n;

  final notificationDate = DateTime(
    skippedDate.year + examinationIntervalYears,
    skippedDate.month,
    skippedDate.day,
  );

  final practitioner =
      procedureQuestionTitle(context, examinationType: examinationType).toLowerCase();
  final preposition = czechPreposition(context, examinationType: examinationType);

  final descriptionText =
      sex == Sex.MALE ? l10n.last_checkup_sheet_text_male : l10n.last_checkup_sheet_text_female;

  final title =
      '${sex == Sex.MALE ? l10n.last_checkup_question_male : l10n.last_checkup_question_female} $preposition $practitioner?';

  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (BuildContext modalContext) {
      return Container(
        height: 390,
        decoration: const BoxDecoration(
          color: LoonoColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, size: 32),
                      onPressed: () => AutoRouter.of(context).pop(),
                    ),
                  ],
                ),
                Text(
                  title,
                  style: LoonoFonts.headerFontStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${l10n.preposition_in} '
                  '${czechMonthsInflected[skippedDate.month - 1]} ${skippedDate.year} '
                  '$descriptionText '
                  '${czechMonthsInflected[notificationDate.month - 1]} ${notificationDate.year}',
                ),
                const Spacer(),
                LoonoButton(
                  text: l10n.last_checkup_sheet_button,
                  onTap: () {
                    AutoRouter.of(modalContext).pop();
                    AutoRouter.of(context).navigate(
                      ChangeLastVisitRoute(
                        uuid: uuid,
                        originalDate: skippedDate,
                        title: title,
                        examinationType: examinationType,
                        status: status,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
