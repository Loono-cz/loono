import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_helpers.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/ui/widgets/prevention/progress_bar/base_ring.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationProgressContent extends StatelessWidget {
  const ExaminationProgressContent({
    Key? key,
    required this.categorizedExamination,
    required this.sex,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final Sex sex;

  ExaminationCategoryType get _examinationCategoryType =>
      categorizedExamination.examination.examinationCategoryType;
  bool get _isToday {
    final now = DateTime.now();
    final visit = categorizedExamination.examination.plannedDate!.toLocal();
    return now.day == visit.day && now.month == visit.month && now.year == visit.year;
  }

  String _intervalYears(BuildContext context) {
    final yearInterval = categorizedExamination.examination.intervalYears;
    //transformMonthToYear
    if (_examinationCategoryType == ExaminationCategoryType.CUSTOM) {
      return '${transformMonthToYear(yearInterval)} ${yearInterval < 11 ? 'měsíců' : 'roků'}';
    } else {
      return '${yearInterval.toString()} ${yearInterval > 1 ? context.l10n.years : context.l10n.year}';
    }
  }

  /// get correct combination of text font styles and colors
  Widget _progressBarContent(BuildContext context) {
    if ([
      const ExaminationCategory.scheduledSoonOrOverdue(),
      const ExaminationCategory.scheduled(),
    ].contains(categorizedExamination.category)) {
      /// known next visit
      return _scheduledVisitContent(context);
    } else if (const ExaminationCategory.waiting() == categorizedExamination.category ||
        categorizedExamination.examination.state == ExaminationStatus.CONFIRMED) {
      /// awaiting new checkup
      return _earlyCheckupContent(context);
    } else if (categorizedExamination.examination.lastConfirmedDate != null) {
      /// examination long overdue
      return Text(
        '${context.l10n.more_than} ${_intervalYears(context)} ${context.l10n.since_last_visit}',
        textAlign: TextAlign.center,
        style: LoonoFonts.paragraphSmallFontStyle.copyWith(
          fontWeight: FontWeight.w700,
          color: LoonoColors.primaryEnabled,
        ),
      );
    } else {
      /// first examination
      return Text(
        context.l10n.first_visit_awaiting,
        key: const Key('examinationProgress_firstVisitAwaiting'),
        textAlign: TextAlign.center,
        style: LoonoFonts.paragraphSmallFontStyle.copyWith(
          fontWeight: FontWeight.w700,
          color: LoonoColors.primaryEnabled,
        ),
      );
    }
  }

  Widget _scheduledVisitContent(BuildContext context) {
    final now = DateTime.now();
    final visitTime = DateFormat(LoonoStrings.hoursFormat, 'cs-CZ')
        .format(categorizedExamination.examination.plannedDate!.toLocal());
    final visitTimePreposition =
        categorizedExamination.examination.plannedDate!.toLocal().hour > 11 ? 've' : 'v';
    final visitDate = DateFormat(LoonoStrings.dateFormatSpacing, 'cs-CZ')
        .format(categorizedExamination.examination.plannedDate!.toLocal());
    final isAfterVisit = now.isAfter(categorizedExamination.examination.plannedDate!.toLocal());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isAfterVisit
              ? (sex == Sex.MALE
                  ? context.l10n.did_you_visited_male
                  : context.l10n.did_you_visited_female)
              : context.l10n.next_visit,
          textAlign: TextAlign.center,
          style: LoonoFonts.paragraphSmallFontStyle.copyWith(
            color: LoonoColors.primaryEnabled,
            fontWeight: isAfterVisit ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        Text(
          _isToday ? context.l10n.today : visitDate,
          style: LoonoFonts.cardSubtitle.copyWith(fontSize: 16),
        ),
        Text(
          _isToday ? '$visitTimePreposition $visitTime' : visitTime,
          style: LoonoFonts.cardSubtitle.copyWith(fontSize: 16),
        )
      ],
    );
  }

  Widget _earlyCheckupContent(BuildContext context) {
    final examination = categorizedExamination.examination;
    if (examination.periodicExam == true &&
        examination.examinationCategoryType == ExaminationCategoryType.CUSTOM &&
        examination.plannedDate == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.waiting_you,
            style: LoonoFonts.paragraphSmallFontStyle.copyWith(
              color: LoonoColors.primaryEnabled,
            ),
          ),
          Text(
            context.l10n.first_exam_progress,
            style: LoonoFonts.paragraphSmallFontStyle.copyWith(
              color: LoonoColors.primaryEnabled,
            ),
          )
        ],
      );
    } else {
      final examination = categorizedExamination.examination;
      final interval = examination.intervalYears;
      DateTime newWaitToDateTime;
      final lastDateVisit = examination.lastConfirmedDate!.toLocal();

      if (interval <= 11) {
        newWaitToDateTime = DateTime(lastDateVisit.year, lastDateVisit.month + interval);
      } else {
        newWaitToDateTime = DateTime(
          lastDateVisit.year + categorizedExamination.examination.intervalYears,
          lastDateVisit.month,
        );
      }

      final formattedDate = DateFormat.yMMMM('cs-CZ').format(newWaitToDateTime);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.early_ordering,
            style: LoonoFonts.paragraphSmallFontStyle.copyWith(color: LoonoColors.primaryEnabled),
          ),
          Text(
            formattedDate,
            style: LoonoFonts.cardSubtitle.copyWith(fontSize: 16),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 168,
      height: 168,
      child: Stack(
        children: [
          SizedBox(
            child: CustomPaint(
              painter: Ring(
                progressColor: progressBarColor(categorizedExamination.category),
                upperArcAngle: upperArcProgress(categorizedExamination),
                lowerArcAngle: lowerArcProgress(categorizedExamination),
                isOverdue: isOverdue(categorizedExamination),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _progressBarContent(context),
                  ),
                ),
              ),
            ),
          ),
          progressBarLeftDot(categorizedExamination.category),
          progressBarRightDot(categorizedExamination.category),
        ],
      ),
    );
  }
}
