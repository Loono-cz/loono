import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/prevention/datepicker_sheet.dart';
import 'package:loono/ui/widgets/prevention/examination_cancel_sheet.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

void showEditModal(BuildContext pageContext, CategorizedExamination examination) {
  final examinationType = examination.examination.examinationType;
  final preposition = czechPreposition(pageContext, examinationType: examinationType);
  final procedure =
      procedureQuestionTitle(pageContext, examinationType: examinationType).toLowerCase();

  Future<void> onChangeSubmit({required DateTime date}) async {
    /// code anchor: #postChangeExamiantion
    final response = await registry.get<ExaminationRepository>().postExamination(
          examinationType,
          newDate: date,
          uuid: examination.examination.uuid,
          firstExam: false,
        );
    await response.map(
      success: (res) async {
        Provider.of<ExaminationsProvider>(pageContext, listen: false)
            .updateExaminationsRecord(res.data);
        await registry.get<CalendarRepository>().updateEventDate(
              examinationType,
              newDate: date,
            );
        AutoRouter.of(pageContext).popUntilRouteWithName('ExaminationDetailRoute');
        showSnackBarSuccess(pageContext, message: pageContext.l10n.checkup_reminder_toast);
      },
      failure: (err) async {
        showSnackBarError(pageContext, message: pageContext.l10n.something_went_wrong);
      },
    );
  }

  final formattedDate = DateFormat('d. MMMM yyyy, HH:mm', 'cs-CZ')
      .format(examination.examination.plannedDate!.toLocal());

  showCupertinoModalPopup<void>(
    context: pageContext,
    builder: (BuildContext modalContext) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            final examinationUuid = examination.examination.uuid;
            if (examinationUuid != null) {
              AutoRouter.of(modalContext).pop();
              showCancelExaminationSheet(
                context: pageContext,
                id: examinationUuid,
                examinationType: examinationType,
                title: '${pageContext.l10n.checkup_cancel_question} $preposition $procedure?',
                date: examination.examination.plannedDate ?? DateTime.now(),
              );
            } else {
              showSnackBarError(modalContext, message: modalContext.l10n.something_went_wrong);
            }
          },
          child: Text(pageContext.l10n.cancel_checkup),
        ),
        CupertinoActionSheetAction(
          child: Text(
            pageContext.l10n.edit_checkup,
            style: const TextStyle(color: Colors.black),
          ),
          onPressed: () {
            AutoRouter.of(modalContext).pop();
            showDatePickerSheet(
              context: pageContext,
              categorizedExamination: examination,
              onSubmit: onChangeSubmit,
              firstStepTitle: pageContext.l10n.new_checkup_date,
              secondStepTitle: pageContext.l10n.new_checkup_time,
              additionalBottomText: '${pageContext.l10n.original_date}: $formattedDate',
            );
          },
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            AutoRouter.of(modalContext).pop();
          },
          child: Text(
            pageContext.l10n.back,
            style: const TextStyle(color: Colors.black),
          ),
        )
      ],
    ),
  );
}
