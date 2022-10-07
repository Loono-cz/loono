import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_helpers.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/prevention/datepicker_sheet.dart';
import 'package:loono/ui/widgets/prevention/examination_cancel_sheet.dart';
import 'package:loono/ui/widgets/prevention/examination_delete_sheet.dart';
import 'package:loono/ui/widgets/prevention/examination_edit_sheet.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

void showEditModal(
  BuildContext pageContext,
  CategorizedExamination examination,
  int intervalMonths,
) {
  final examinationType = examination.examination.examinationType;
  final preposition = czechPreposition(pageContext, examinationType: examinationType);
  final procedure =
      procedureQuestionTitle(pageContext, examinationType: examinationType).toLowerCase();

  Future<void> onChangeSubmit({required DateTime date}) async {
    /// code anchor: #postChangeExamiantion
    final intervalYears =
        ExaminationCategoryType.CUSTOM == examination.examination.examinationCategoryType
            ? examination.examination.intervalYears < 12
                ? examination.examination.intervalYears
                : transformMonthToYear(examination.examination.intervalYears)
            : examination.examination.intervalYears;
    final response = await registry.get<ExaminationRepository>().postExamination(
          examinationType,
          newDate: date,
          uuid: examination.examination.uuid,
          firstExam: false,
          status: examination.examination.state,
          periodicExam: examination.examination.periodicExam,
          actionType: examination.examination.examinationActionType,
          categoryType: examination.examination.examinationCategoryType!,
          customInterval: examination.examination.customInterval ?? intervalYears,
        );
    await response.map(
      success: (res) async {
        final autoRouter = AutoRouter.of(pageContext);
        ExaminationPreventionStatus? exam;
        final provider = Provider.of<ExaminationsProvider>(pageContext, listen: false);
        if (examination.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM) {
          exam = Provider.of<ExaminationsProvider>(pageContext, listen: false)
              .updateAndReturnCustomExaminationsRecord(
            res.data,
            examination.examination,
          );
        } else {
          Provider.of<ExaminationsProvider>(pageContext, listen: false)
              .updateExaminationsRecord(res.data);
        }
        await registry.get<CalendarRepository>().updateEventDate(
              examinationType,
              newDate: date,
            );
        autoRouter.popUntilRouteWithName(ExaminationDetailRoute.name);
        await autoRouter.replace(
          ExaminationDetailRoute(
            categorizedExamination: provider.getChoosedExamination().categorizedExamination!,
            choosedExamination: exam,
          ),
        );

        ///TODO: lint fix
        // ignore: use_build_context_synchronously
        showFlushBarSuccess(
          pageContext,
          pageContext.l10n.checkup_reminder_toast,
        );
      },
      failure: (err) async {
        showFlushBarError(pageContext, pageContext.l10n.something_went_wrong);
      },
    );
  }

  final formattedDate = DateFormat('d. MMMM yyyy, HH:mm', 'cs-CZ')
      .format(examination.examination.plannedDate!.toLocal());

  registry.get<FirebaseAnalytics>().logEvent(name: 'OpenEditCheckupModal');
  showCupertinoModalPopup<void>(
    context: pageContext,
    builder: (BuildContext modalContext) => CupertinoActionSheet(
      key: const Key('editCheckUpDateSheet'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          key: const Key('editCheckUpDateSheet_action_editDateCheckUp'),
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
              additionalBottomText: '${pageContext.l10n.original_date}: $formattedDate',
              intervalMonths: intervalMonths,
            );
          },
        ),
        CupertinoActionSheetAction(
          key: const Key('editCheckUpDateSheet_action_cancelCheckUp'),
          isDestructiveAction: true,
          onPressed: () {
            final examinationUuid = examination.examination.uuid;

            if (examinationUuid != null) {
              AutoRouter.of(modalContext).pop();
              showCancelExaminationSheet(
                context: pageContext,
                id: examinationUuid,
                examinationType: examinationType,
                title: examination.examination.periodicExam == true
                    ? pageContext.l10n.custom_exam_cancel_question
                    : '${pageContext.l10n.checkup_cancel_question} $preposition $procedure?',
                date: examination.examination.plannedDate?.toLocal() ?? DateTime.now(),
              );
            } else {
              showFlushBarError(
                modalContext,
                modalContext.l10n.something_went_wrong,
              );
            }
          },
          child: Text(pageContext.l10n.cancel_term_action),
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
  ).whenComplete(() {
    registry.get<FirebaseAnalytics>().logEvent(name: 'CloseEditCheckupModal');
  });
}

void showCustomExamEditModal(
  BuildContext pageContext,
  ExaminationPreventionStatus examination,
) {
  final examinationType = examination.examinationType;
  registry.get<FirebaseAnalytics>().logEvent(name: 'OpenEditCustomExaminationNonPeriodicModal');
  final examinationUuid = examination.uuid;
  showCupertinoModalPopup<void>(
    context: pageContext,
    builder: (BuildContext modalContext) => CupertinoActionSheet(
      key: const Key('editCheckUpDateSheet'),
      actions: <CupertinoActionSheetAction>[
        if (examination.periodicExam == true)
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              if (examinationUuid != null) {
                AutoRouter.of(modalContext).pop();
                showCustomEditExamSheet(
                  context: pageContext,
                  id: examinationUuid,
                  examinationType: examinationType,
                  date: examination.plannedDate?.toLocal() ?? DateTime.now(),
                );
              } else {
                showFlushBarError(
                  modalContext,
                  modalContext.l10n.something_went_wrong,
                );
              }
            },
            child: Text(
              pageContext.l10n.edit_examination,
              style: LoonoFonts.editExaminationMenuItem,
            ),
          ),
        if (examination.examinationCategoryType != ExaminationCategoryType.MANDATORY)
          CupertinoActionSheetAction(
            key: const Key('editCheckUpDateSheet_action_cancelCheckUp'),
            isDestructiveAction: true,
            onPressed: () {
              if (examinationUuid != null) {
                AutoRouter.of(modalContext).pop();
                showDeleteExaminationSheet(
                  context: pageContext,
                  id: examinationUuid,
                  examinationType: examinationType,
                  date: examination.plannedDate?.toLocal() ?? DateTime.now(),
                );
              } else {
                showFlushBarError(modalContext, modalContext.l10n.something_went_wrong);
              }
            },
            child: Text(pageContext.l10n.cancel_checkup),
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
  ).whenComplete(() {
    registry.get<FirebaseAnalytics>().logEvent(name: 'CloseEditCustomExaminationNonPeriodicModal');
  });
}
