import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

void showChangeLastVisitSheet({
  required BuildContext context,
  required CategorizedExamination examination,
  required String title,
}) {
  registry.get<FirebaseAnalytics>().logEvent(name: 'OpenLastVisitModal');
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    enableDrag: true,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: 680,
        decoration: const BoxDecoration(
          color: LoonoColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: _DatePickerContent(
            categorizedExamination: examination,
            title: title,
          ),
        ),
      );
    },
  ).whenComplete(() {
    registry.get<FirebaseAnalytics>().logEvent(name: 'CloseLastVisitModal');
  });
}

class _DatePickerContent extends StatefulWidget {
  const _DatePickerContent({
    Key? key,
    required this.categorizedExamination,
    required this.title,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final String title;

  @override
  _DatePickerContentState createState() => _DatePickerContentState();
}

class _DatePickerContentState extends State<_DatePickerContent> {
  DateTime? newDate;

  void onDateChanged(DateTime? date) {
    /// prevent setting state from date picker during build
    Future.delayed(Duration.zero, () async {
      setState(() {
        newDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lastVisit = widget.categorizedExamination.examination.lastConfirmedDate?.toLocal() ??
        Date.now().toDateTime();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.close,
                size: 31,
              ),
              onPressed: () => AutoRouter.of(context).pop(),
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                widget.title,
                style: LoonoFonts.headerFontStyle,
              ),
            ),
          ],
        ),
        const Spacer(),
        Center(
          child: CustomDatePicker(
            defaultDay: lastVisit.day,
            defaultMonth: lastVisit.month,
            defaultYear: lastVisit.year,
            valueChanged: onDateChanged,
            yearsBeforeActual: DateTime.now().year - 1900,
            yearsOverActual: 2,
            allowDays: true,
          ),
        ),
        const Spacer(),
        AsyncLoonoApiButton(
          text: context.l10n.action_save,
          enabled: newDate != null,
          asyncCallback: () async {
            /// code anchor: #postChangeLastExamiantion
            final response = await registry.get<ExaminationRepository>().postExamination(
                  widget.categorizedExamination.examination.examinationType,
                  newDate: newDate,
                  uuid: widget.categorizedExamination.examination.uuid,
                  periodicExam: widget.categorizedExamination.examination.periodicExam,
                  status: ExaminationStatus.CONFIRMED,
                  firstExam: true,
                  actionType: widget.categorizedExamination.examination.examinationActionType,
                  categoryType: widget.categorizedExamination.examination.examinationCategoryType ??
                      ExaminationCategoryType.MANDATORY,
                  customInterval: widget.categorizedExamination.examination.customInterval,
                );

            await response.map(
              success: (res) async {
                Provider.of<ExaminationsProvider>(context, listen: false)
                    .updateExaminationsRecord(res.data);
                await AutoRouter.of(context).pop();
              },
              failure: (err) async {
                showFlushBarError(
                  context,
                  err.error.response?.statusCode == 400
                      ? context.l10n.unsupported_interval
                      : context.l10n.something_went_wrong,
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          '${context.l10n.original_date}: ${DateFormat('MMMM', 'cs-CZ').format(lastVisit)} ${lastVisit.year}',
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
