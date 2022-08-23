import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/ui/widgets/prevention/recommendation_item.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

void showCancelExaminationSheet({
  required BuildContext context,
  required ExaminationType examinationType,
  required String title,
  required DateTime date,
  required String id,
}) {
  final l10n = context.l10n;

  registry.get<FirebaseAnalytics>().logEvent(name: 'OpenCancelCheckupModal');
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    isScrollControlled: true,
    builder: (BuildContext modalContext) {
      return Container(
        key: const Key('cancelCheckUpSheet'),
        height: 700,
        decoration: const BoxDecoration(
          color: LoonoColors.bottomSheetPrevention,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: LoonoCloseButton(onPressed: () => AutoRouter.of(context).pop()),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: LoonoFonts.headerFontStyle,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                DateFormat('dd. MMMM yyyy hh:mm', 'cs-CZ').format(date),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              RecommendationItem(
                asset: 'assets/icons/prevention/calendar.svg',
                content: l10n.checkup_cancel_reschedule,
              ),
              const SizedBox(
                height: 40,
              ),
              RecommendationItem(
                asset: 'assets/icons/prevention/phone.svg',
                content: l10n.checkup_cancel_notify_doc,
              ),
              const SizedBox(
                height: 60,
              ),
              AsyncLoonoApiButton(
                key: const Key('cancelCheckUpSheet_btn_cancelCheckUp'),
                text: context.l10n.cancel_checkup,
                asyncCallback: () async {
                  /// code anchor: #postCancelExamiantion
                  final response =
                      await registry.get<ExaminationRepository>().cancelExamination(id);
                  await response.map(
                    success: (res) async {
                      final examProvider =
                          Provider.of<ExaminationsProvider>(context, listen: false);
                      final autoRouter = AutoRouter.of(context);
                      await registry.get<CalendarRepository>().deleteEvent(examinationType);
                      examProvider.updateExaminationsRecord(res.data);
                      await autoRouter.pop();
                      //TODO: lint fix
                      // ignore: use_build_context_synchronously
                      showFlushBarSuccess(context, context.l10n.checkup_canceled);
                    },
                    failure: (err) async {
                      await AutoRouter.of(context).pop();
                      //TODO: lint fix
                      // ignore: use_build_context_synchronously
                      showFlushBarError(context, context.l10n.something_went_wrong);
                    },
                  );
                },
              ),
              const SizedBox(
                height: 60,
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
