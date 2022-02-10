import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class ChangeLastVisitScreen extends StatefulWidget {
  const ChangeLastVisitScreen({
    Key? key,
    required this.originalDate,
    required this.title,
    required this.examinationType,
  }) : super(key: key);

  final DateTime originalDate;
  final String title;
  final ExaminationTypeEnum examinationType;

  @override
  State<ChangeLastVisitScreen> createState() => _ChangeLastVisitScreenState();
}

class _ChangeLastVisitScreenState extends State<ChangeLastVisitScreen> {
  late DateTime newDate = widget.originalDate;

  void onDateChanged(DateTime date) {
    /// prevent setting state from date picker during build
    Future.delayed(Duration.zero, () async {
      setState(() {
        newDate = date;
      });
    });
  }

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
            icon: const Icon(
              Icons.close,
              size: 32,
            ),
            onPressed: () => AutoRouter.of(context).pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Text(
                widget.title,
                style: LoonoFonts.headerFontStyle,
              ),
              const Spacer(),
              Center(
                child: CustomDatePicker(
                  valueChanged: onDateChanged,
                  yearsBeforeActual: widget.originalDate.year - 1900,
                  yearsOverActual: 0,
                  defaultMonth: widget.originalDate.month,
                  defaultYear: widget.originalDate.year,
                ),
              ),
              const Spacer(),
              AsyncLoonoButton(
                text: context.l10n.action_save,
                asyncCallback: () => registry.get<ExaminationRepository>().postExamination(
                      widget.examinationType,
                      newDate: newDate,
                    ),
                onSuccess: () async {
                  await AutoRouter.of(context).pop();
                  showSnackBarSuccess(context, message: context.l10n.checkup_reminder_toast);
                },
                onError: () {
                  showSnackBarError(context, message: context.l10n.something_went_wrong);
                },
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                '${context.l10n.original_date}: ${DateFormat('MMMM', 'cs-CZ').format(widget.originalDate)} ${widget.originalDate.year}',
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
