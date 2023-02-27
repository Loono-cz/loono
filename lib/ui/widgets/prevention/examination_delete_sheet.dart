import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

void showDeleteExaminationSheet({
  required BuildContext context,
  required ExaminationType examinationType,
  required DateTime date,
  required String id,
}) {
  registry.get<FirebaseAnalytics>().logEvent(name: 'OpenCancelCheckupModal');
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    isScrollControlled: false,
    builder: (BuildContext modalContext) {
      return Container(
        key: const Key('cancelCheckUpSheet'),
        decoration: const BoxDecoration(
          color: LoonoColors.bottomSheetPrevention,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LoonoCloseButton(onPressed: () => AutoRouter.of(context).pop()),
                ],
              ),
              Text(
                context.l10n.disposable_exam_delete_question,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                context.l10n.disposable_exam_delete_desc,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              AsyncLoonoApiButton(
                key: const Key('cancelCheckUpSheet_btn_cancelCheckUp'),
                text: context.l10n.delete_checkup,
                asyncCallback: () async {
                  /// code anchor: #postCancelExamiantion
                  final response =
                      await registry.get<ExaminationRepository>().deleteExamination(id);
                  await response.map(
                    success: (res) async {
                      final examProvider =
                          Provider.of<ExaminationsProvider>(context, listen: false);
                      final autoRouter = AutoRouter.of(context);
                      await registry.get<CalendarRepository>().deleteEvent(examinationType);
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        showFlushBarSuccess(context, context.l10n.checkup_deleted);
                      });
                      await autoRouter.replace(MainRoute(children: [PreventionRoute()]));
                      examProvider.deleteExaminationRecord(id);
                    },
                    failure: (err) async {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        showFlushBarError(context, context.l10n.something_went_wrong);
                      });
                      await AutoRouter.of(context).pop();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  ).whenComplete(() {
    registry.get<FirebaseAnalytics>().logEvent(name: 'CloseCancelCheckupModal');
  });
}
