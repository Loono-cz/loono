import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/prevention/change_last_visit_sheet.dart';
import 'package:loono_api/loono_api.dart';

void showLastVisitSheet({
  required CategorizedExamination examination,
  required BuildContext context,
  required Sex sex,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    builder: (BuildContext modalContext) {
      return _ModalContent(
        examination: examination,
        sex: sex,
      );
    },
  );
}

class _ModalContent extends StatelessWidget {
  const _ModalContent({Key? key, required this.examination, required this.sex}) : super(key: key);

  final CategorizedExamination examination;

  final Sex sex;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // TODO: remove now()
    final lastVisit = examination.examination.lastConfirmedDate ?? DateTime.now();

    final notificationDate = DateTime(
      lastVisit.year + examination.examination.intervalYears,
      lastVisit.month,
      lastVisit.day,
    );

    final practitioner =
        procedureQuestionTitle(context, examinationType: examination.examination.examinationType)
            .toLowerCase();
    final preposition =
        czechPreposition(context, examinationType: examination.examination.examinationType);

    final descriptionText =
        sex == Sex.MALE ? l10n.last_checkup_sheet_text_male : l10n.last_checkup_sheet_text_female;

    final title =
        '${sex == Sex.MALE ? l10n.last_checkup_question_male : l10n.last_checkup_question_female} $preposition $practitioner?';

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
                '${czechMonthsInflected[lastVisit.month - 1]} ${lastVisit.year} '
                '$descriptionText '
                '${czechMonthsInflected[notificationDate.month - 1]} ${notificationDate.year}',
              ),
              const Spacer(),
              LoonoButton(
                text: l10n.last_checkup_sheet_button,
                onTap: () {
                  AutoRouter.of(context).pop();
                  showChangeLastVisitSheet(
                    context: context,
                    title: title,
                    examination: examination,
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
  }
}
