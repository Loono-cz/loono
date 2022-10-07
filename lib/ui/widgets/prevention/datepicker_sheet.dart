import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/ui/widgets/custom_time_picker.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

void showDatePickerSheet({
  required BuildContext context,
  required CategorizedExamination categorizedExamination,
  required Future<void> Function({required DateTime date}) onSubmit,
  bool isNewCheckup = false,
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
        key: const Key('datePickerSheet'),
        height: 680,
        decoration: const BoxDecoration(
          color: LoonoColors.primaryLight,
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
              additionalBottomText: additionalBottomText,
              isNewCheckup: isNewCheckup,
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
    required this.isNewCheckup,
    this.additionalBottomText,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final Future<void> Function({required DateTime date}) onSubmit;

  final String? additionalBottomText;
  final bool isNewCheckup;

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

  Sex get _sex {
    final user = registry.get<DatabaseService>().users.user;
    return user?.sex ?? Sex.MALE;
  }

  @override
  Widget build(BuildContext context) {
    final examinationType = widget.categorizedExamination.examination.examinationType;

    final originalDate = widget.categorizedExamination.examination.plannedDate?.toLocal();

    String _buildTitle(BuildContext context) {
      return isFirstStep
          ? _sex == Sex.MALE
              ? context.l10n.wich_date_you_have_reservation_male
              : context.l10n.wich_date_you_have_reservation_female
          : _sex == Sex.MALE
              ? context.l10n.custom_exam_reservation_time_male
              : context.l10n.custom_exam_reservation_time_female;
    }

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
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  setState(() {
                    isFirstStep = true;
                  });
                },
              ),
            const Spacer(),
            LoonoCloseButton(onPressed: () => AutoRouter.of(context).pop()),
          ],
        ),
        const SizedBox(
          height: 21,
        ),
        Row(
          children: [
            Flexible(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: _buildTitle(context),
                      style: LoonoFonts.headerFontStyle,
                    ),
                    if (widget.isNewCheckup)
                      TextSpan(
                        text: '${examinationTypeCasus(
                          context,
                          casus: Casus.dativ,
                          examinationType: examinationType,
                        )}?',
                        style: LoonoFonts.headerFontStyle.copyWith(fontWeight: FontWeight.w700),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (!isFirstStep)
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Text(
                  DateFormat('d. MMMM yyyy', 'cs-CZ').format(newDate!).toString(),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ],
            ),
          ),
        const Spacer(),
        Center(
          child: isFirstStep
              ? CustomDatePicker(
                  valueChanged: onDateChanged,
                  yearsBeforeActual: DateTime.now().year - (DateTime.now().year - 10),
                  yearsOverActual: 10,
                  allowDays: true,
                  defaultDay: DateTime.now().day,
                  defaultMonth: DateTime.now().month,
                  defaultYear: DateTime.now().year,
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
          key: const Key('datePickerSheet_btn_continue'),
          text: isFirstStep ? context.l10n.continue_info : context.l10n.action_save,
          enabled: newDate != null,
          asyncCallback: () async {
            final isDateValid = Date.now().toDateTime().isAtSameMomentAs(
                      Date(newDate!.year, newDate!.month, newDate!.day).toDateTime(),
                    ) ||
                DateTime.now().isBefore(newDate!);
            if (!isDateValid) {
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
