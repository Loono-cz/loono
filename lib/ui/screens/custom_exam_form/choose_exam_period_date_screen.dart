import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/close_button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono_api/loono_api.dart';

class ChooseExamPeriodDateScreen extends StatefulWidget {
  const ChooseExamPeriodDateScreen({
    this.dateTime,
    required this.onValueChange,
    required this.label,
    required this.pickTime,
    this.showLastExamDate,
    this.isLastExamChoose = false,
    super.key,
  });
  final String label;
  final bool pickTime;
  final bool? showLastExamDate;
  final bool? isLastExamChoose;

  final DateTime? dateTime;
  final Function(DateTime?) onValueChange;
  @override
  State<ChooseExamPeriodDateScreen> createState() => _ChooseExamPeriodDateScreenState();
}

class _ChooseExamPeriodDateScreenState extends State<ChooseExamPeriodDateScreen> {
  Future<void> _closeForm(BuildContext context) async => Navigator.of(context).pop();
  DateTime? _dateTime;
  @override
  void initState() {
    super.initState();
    _dateTime = widget.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: LoonoColors.primaryLight50,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoonoCloseButton(onPressed: () async => _closeForm(context)),
          ),
        ],
      ),
      backgroundColor: LoonoColors.primaryLight50,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: LoonoFonts.customExamLabel,
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: CustomDatePicker(
                defaultDay: DateTime.now().day,
                valueChanged: (value) {
                  _dateTime = value;
                },
                yearsBeforeActual: 10,
                yearsOverActual: 10,
                allowDays: true,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            LoonoButton(
              text: widget.pickTime ? context.l10n.continue_info : context.l10n.confirm_info,
              onTap: () {
                bool isDateValid;
                if (widget.isLastExamChoose == true) {
                  isDateValid = Date.now().toDateTime().isAtSameMomentAs(
                            Date(_dateTime!.year, _dateTime!.month, _dateTime!.day).toDateTime(),
                          ) ||
                      DateTime.now().isAfter(_dateTime!);
                } else {
                  isDateValid = Date.now().toDateTime().isAtSameMomentAs(
                            Date(_dateTime!.year, _dateTime!.month, _dateTime!.day).toDateTime(),
                          ) ||
                      DateTime.now().isBefore(_dateTime!);
                }

                if (!isDateValid) {
                  showFlushBarError(
                    context,
                    widget.isLastExamChoose == true
                        ? context.l10n.error_date_must_be_in_past
                        : context.l10n.error_must_be_in_future,
                  );
                  return;
                }

                if (widget.pickTime) {
                  AutoRouter.of(context).navigate(
                    ChooseExamPeriodTimeRoute(
                      dateTime: _dateTime,
                      onTimeSet: widget.onValueChange,
                    ),
                  );
                } else {
                  widget.onValueChange(_dateTime);
                  AutoRouter.of(context).pop();
                }
              },
            ),
            const SizedBox(
              height: 4.0,
            ),
            if (widget.showLastExamDate == true && widget.dateTime != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Původní datum: ${DateFormat(LoonoStrings.dateFormatWithNameMonth, 'CS-cz').format(widget.dateTime!)}',
                  ),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
