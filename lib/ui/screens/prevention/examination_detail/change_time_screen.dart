import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/repositories/calendar_repository.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/custom_time_picker.dart';
import 'package:loono/utils/registry.dart';

class ChangeTimeScreen extends StatefulWidget {
  const ChangeTimeScreen({
    Key? key,
    required this.categorizedExamination,
    required this.newDate,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final DateTime newDate;

  @override
  State<ChangeTimeScreen> createState() => _ChangeTimeScreenState();
}

class _ChangeTimeScreenState extends State<ChangeTimeScreen> {
  DateTime? newDate;

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

    final formattedOriginalDate = DateFormat('d. MMMM yyyy, kk:mm', 'cs-CZ')
        .format(widget.categorizedExamination.examination.nextVisitDate!);

    final formattedNewDate = DateFormat('d. MMMM yyyy', 'cs-CZ').format(widget.newDate);

    return Scaffold(
      backgroundColor: LoonoColors.bottomSheetPrevention,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: LoonoColors.black),
        leading: IconButton(
          onPressed: () => AutoRouter.of(context).pop(),
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => AutoRouter.of(context).popUntilRouteWithName('ExaminationDetailRoute'),
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
                '${context.l10n.new_checkup_time} $preposition $practitioner',
                style: LoonoFonts.headerFontStyle,
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                formattedNewDate,
                style: LoonoFonts.headerFontStyle.copyWith(fontSize: 16),
              ),
              const Spacer(),
              Center(
                child: SizedBox(
                  child: CustomTimePicker(
                    valueChanged: onTimeChanged,
                    defaultDate: widget.newDate,
                    defaultHour: 12,
                  ),
                ),
              ),
              const Spacer(),
              LoonoButton(
                text: context.l10n.action_save,
                onTap: () async {
                  if (newDate != null) {
                    await registry.get<CalendarRepository>().updateEventDate(
                          examinationType,
                          newDate: newDate!,
                        );
                  }
                  AutoRouter.of(context).popUntilRouteWithName('ExaminationDetailRoute');
                  showSnackBarError(context, message: 'TODO: save to API\n$newDate');
                },
              ),
              const SizedBox(
                height: 18,
              ),
              Center(child: Text('${context.l10n.original_date}: $formattedOriginalDate')),
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
