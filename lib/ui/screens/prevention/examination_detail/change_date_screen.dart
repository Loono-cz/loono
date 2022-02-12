import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_date_picker.dart';

class ChangeDateScreen extends StatefulWidget {
  const ChangeDateScreen({
    Key? key,
    required this.categorizedExamination,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;

  @override
  State<ChangeDateScreen> createState() => _ChangeDateScreenState();
}

class _ChangeDateScreenState extends State<ChangeDateScreen> {
  DateTime? newDate;

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
    final examinationType = widget.categorizedExamination.examination.examinationType;
    final practitioner =
        procedureQuestionTitle(context, examinationType: examinationType).toLowerCase();
    final preposition = czechPreposition(context, examinationType: examinationType);

    final formattedDate = DateFormat('d. MMMM yyyy, kk:mm', 'cs-CZ')
        .format(widget.categorizedExamination.examination.nextVisitDate!);

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
                '${context.l10n.new_checkup_date} $preposition $practitioner',
                style: LoonoFonts.headerFontStyle,
              ),
              const Spacer(),
              Center(
                child: CustomDatePicker(
                  valueChanged: onDateChanged,
                  yearsBeforeActual: DateTime.now().year - 1900,
                  yearsOverActual: 2,
                  allowDays: true,
                ),
              ),
              const Spacer(),
              LoonoButton(
                text: context.l10n.continue_info,
                enabled: newDate != null,
                onTap: () {
                  AutoRouter.of(context).push(
                    ChangeTimeRoute(
                      categorizedExamination: widget.categorizedExamination,
                      newDate: newDate!,
                      uuid: widget.categorizedExamination.examination.id,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 18,
              ),
              Text('${context.l10n.original_date}: $formattedDate'),
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
