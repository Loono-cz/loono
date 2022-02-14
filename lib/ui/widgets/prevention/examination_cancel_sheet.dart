import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/prevention/recommendation_item.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

void showCancelExaminationSheet({
  required BuildContext context,
  required ExaminationType examinationType,
  required String title,
  required DateTime date,
  required String id,
}) {
  final l10n = context.l10n;

  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    isScrollControlled: true,
    builder: (BuildContext modalContext) {
      return Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, size: 32),
                    onPressed: () => AutoRouter.of(context).pop(),
                  ),
                ],
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
              AsyncLoonoButton(
                text: l10n.cancel_checkup,
                asyncCallback: () =>
                    registry.get<ExaminationRepository>().cancelExamination(examinationType, id),
                onSuccess: () async {
                  await registry.get<CalendarRepository>().deleteEvent(examinationType);
                  AutoRouter.of(context).popUntilRouteWithName(const MainRoute().routeName);
                  showSnackBarSuccess(context, message: l10n.checkup_canceled);
                },
                onError: () async {
                  await AutoRouter.of(context).pop();
                  showSnackBarError(context, message: l10n.something_went_wrong);
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
  );
}
