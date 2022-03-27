import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/custom_time_picker.dart';
import 'package:loono/utils/registry.dart';

void showDatePickerSheet({
  required BuildContext context,
  required CategorizedExamination categorizedExamination,
  required Future<void> Function({required DateTime date}) onSubmit,
  required String firstStepTitle,
  required String secondStepTitle,
  String? additionalBottomText,
}) {
  registry.get<FirebaseAnalytics>().logEvent(name: 'OpenDatePickerModal');
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    enableDrag: true,
    isScrollControlled: true,
    builder: (BuildContext modalContext) {
      return Container(
        height: 680,
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
            child: _DatePickerContent(
              categorizedExamination: categorizedExamination,
              onSubmit: onSubmit,
              firstStepTitle: firstStepTitle,
              secondStepTitle: secondStepTitle,
              additionalBottomText: additionalBottomText,
            ),
          ),
        ),
      );
    },
  ).whenComplete(() {
    registry.get<FirebaseAnalytics>().logEvent(name: 'CloseDatePickerModal');
  });
}

class _DatePickerContent extends StatefulWidget {
  const _DatePickerContent({
    Key? key,
    required this.categorizedExamination,
    required this.onSubmit,
    required this.firstStepTitle,
    required this.secondStepTitle,
    this.additionalBottomText,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final Future<void> Function({required DateTime date}) onSubmit;
  final String firstStepTitle;
  final String secondStepTitle;
  final String? additionalBottomText;

  @override
  _DatePickerContentState createState() => _DatePickerContentState();
}

class _DatePickerContentState extends State<_DatePickerContent> {
  DateTime? newDate;
  bool isFirstStep = true;

  void onDateChanged(DateTime date) {
    /// prevent setting state from date picker during build
    Future.delayed(Duration.zero, () async {
      setState(() {
        newDate = date;
      });
    });
  }

  void onTimeChanged(DateTime date) {
    /// prevent setting state from date picker during build
    Future.delayed(Duration.zero, () async {
      setState(() {
        newDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final examinationType = widget.categorizedExamination.examination.examinationType;
    final practitioner =
        procedureQuestionTitle(context, examinationType: examinationType).toLowerCase();
    final preposition = czechPreposition(context, examinationType: examinationType);

    final originalDate = widget.categorizedExamination.examination.plannedDate?.toLocal();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isFirstStep)
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/arrow_back.svg',
                ),
                onPressed: () {
                  setState(() {
                    isFirstStep = true;
                  });
                },
              ),
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
                '${isFirstStep ? context.l10n.new_checkup_date : context.l10n.new_checkup_time} $preposition $practitioner',
                style: LoonoFonts.headerFontStyle,
              ),
            ),
          ],
        ),
        const Spacer(),
        Center(
          child: isFirstStep
              ? CustomDatePicker(
                  valueChanged: onDateChanged,
                  yearsBeforeActual: DateTime.now().year - 1900,
                  yearsOverActual: 2,
                  allowDays: true,
                  defaultDay: originalDate?.day,
                  defaultMonth: originalDate?.month,
                  defaultYear: originalDate?.year,
                )
              : CustomTimePicker(
                  valueChanged: onTimeChanged,
                  defaultDate: newDate!,
                  defaultHour: originalDate?.hour,
                  defaultMinute: originalDate?.minute,
                ),
        ),
        const Spacer(),
        AsyncLoonoApiButton(
          text: isFirstStep ? context.l10n.continue_info : context.l10n.action_save,
          enabled: newDate != null,
          asyncCallback: () async {
            if (DateTime.now().isAfter(newDate!)) {
              showFlushBarError(context, context.l10n.error_must_be_in_future);
              return;
            }
            if (isFirstStep) {
              if (originalDate != null) {
                /// preset original date
                newDate = DateTime(
                  newDate!.year,
                  newDate!.month,
                  newDate!.day,
                  originalDate.hour.clamp(0, 23),
                  originalDate.minute.clamp(0, 55),
                );
              }
              setState(() {
                isFirstStep = false;
              });
            } else {
              await widget.onSubmit(date: newDate!);
            }
          },
        ),
        const SizedBox(
          height: 18,
        ),
        if (widget.additionalBottomText != null) Text(widget.additionalBottomText!),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
