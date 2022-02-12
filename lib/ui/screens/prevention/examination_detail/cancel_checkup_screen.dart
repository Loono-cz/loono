import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/prevention/recommendation_item.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class CancelCheckupScreen extends StatelessWidget {
  const CancelCheckupScreen({
    Key? key,
    required this.examinationType,
    required this.date,
    required this.title,
    required this.id,
  }) : super(key: key);

  final ExaminationTypeEnum examinationType;
  final DateTime date;
  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoonoColors.bottomSheetPrevention,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: LoonoColors.black),
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => AutoRouter.of(context).pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                content: context.l10n.checkup_cancel_reschedule,
              ),
              const SizedBox(
                height: 40,
              ),
              RecommendationItem(
                asset: 'assets/icons/prevention/phone.svg',
                content: context.l10n.checkup_cancel_notify_doc,
              ),
              const SizedBox(
                height: 60,
              ),
              AsyncLoonoButton(
                text: context.l10n.cancel_checkup,
                asyncCallback: () =>
                    registry.get<ExaminationRepository>().cancelExamination(examinationType, id),
                onSuccess: () async {
                  await registry.get<CalendarRepository>().deleteEvent(examinationType);
                  await AutoRouter.of(context).pop();
                  showSnackBarSuccess(context, message: context.l10n.checkup_canceled);
                },
                onError: () {
                  showSnackBarError(context, message: context.l10n.something_went_wrong);
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
