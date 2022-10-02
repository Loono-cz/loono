import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
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

enum ViewSteps { datePicker, timePicker, noteField }

void showCreateOrderFromDetailSheet({
  required BuildContext context,
  required CategorizedExamination categorizedExamination,
  required Future<void> Function({required DateTime date, String? note}) onSubmit,
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
    this.additionalBottomText,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final Future<void> Function({required DateTime date, String? note}) onSubmit;

  final String? additionalBottomText;

  @override
  _DatePickerContentState createState() => _DatePickerContentState();
}

class _DatePickerContentState extends State<_DatePickerContent> {
  DateTime? newDate;
  bool isFirstStep = true;
  String? _note;

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

  void onNoteChange(String note) {
    /// prevent setting state from date picker during build
    Future.delayed(Duration.zero, () async {
      setState(() {
        _note = note;
      });
    });
  }

  Sex get _sex {
    final user = registry.get<DatabaseService>().users.user;
    return user?.sex ?? Sex.MALE;
  }

  var viewStep = ViewSteps.datePicker;

  @override
  Widget build(BuildContext context) {
    final originalDate = widget.categorizedExamination.examination.plannedDate?.toLocal();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (viewStep != ViewSteps.datePicker)
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/arrow_back.svg',
                ),
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  setState(() {
                    if (viewStep == ViewSteps.noteField) viewStep = ViewSteps.timePicker;
                    viewStep = ViewSteps.datePicker;
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
                      text: buildTitle(viewStep),
                      style: LoonoFonts.headerFontStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (viewStep == ViewSteps.timePicker)
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
        buildStepView(viewStep, originalDate),
        const Spacer(),
        AsyncLoonoApiButton(
          key: const Key('datePickerSheet_btn_continue'),
          text: viewStep != ViewSteps.noteField
              ? context.l10n.continue_info
              : context.l10n.action_save,
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
            if (viewStep == ViewSteps.datePicker) {
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
                viewStep = ViewSteps.timePicker;
              });
            } else if (viewStep == ViewSteps.timePicker) {
              setState(() {
                viewStep = ViewSteps.noteField;
              });
            } else {
              await widget.onSubmit(date: newDate!, note: _note);
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

  Widget buildStepView(ViewSteps view, DateTime? originalDate) {
    switch (view) {
      case ViewSteps.datePicker:
        return Center(
          child: CustomDatePicker(
            valueChanged: onDateChanged,
            yearsBeforeActual: DateTime.now().year - 1900,
            yearsOverActual: 2,
            allowDays: true,
            defaultDay: originalDate?.day,
            defaultMonth: originalDate?.month,
            defaultYear: originalDate?.year,
          ),
        );
      case ViewSteps.timePicker:
        return Center(
          child: CustomTimePicker(
            valueChanged: onTimeChanged,
            defaultDate: newDate!,
            defaultHour: originalDate?.hour,
            defaultMinute: originalDate?.minute,
          ),
        );
      case ViewSteps.noteField:
        return TextFormField(
          minLines: 5,
          maxLines: 10,
          maxLength: 256,
          keyboardType: TextInputType.multiline,
          initialValue: _note,
          onChanged: (value) => setState(() {
            _note = value;
          }),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: context.l10n.note_visiting_description,
            hintStyle: const TextStyle(color: Colors.grey),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: LoonoColors.primary),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        );
    }
  }

  String buildTitle(ViewSteps view) {
    switch (view) {
      case ViewSteps.datePicker:
        return _sex == Sex.MALE
            ? context.l10n.wich_date_you_have_reservation_male
            : context.l10n.wich_date_you_have_reservation_female;
      case ViewSteps.timePicker:
        return _sex == Sex.MALE
            ? context.l10n.custom_exam_reservation_time_male
            : context.l10n.custom_exam_reservation_time_female;
      case ViewSteps.noteField:
        return context.l10n.note_visiting;
      default:
        return '';
    }
  }
}
