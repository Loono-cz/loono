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

  ExaminationCategoryType? get _examinationCategoryType =>
      categorizedExamination.examination.examinationCategoryType;

  ExaminationCategory get category => categorizedExamination.category;

  bool get _isToday {
    final now = DateTime.now();
    final visit = categorizedExamination.examination.plannedDate!.toLocal();
    return now.day == visit.day && now.month == visit.month && now.year == visit.year;
  }

  bool get _isCustomExamination => _examinationCategoryType == ExaminationCategoryType.CUSTOM;

  String _intervalYears(BuildContext context) {
    final interval = _isCustomExamination
        ? categorizedExamination.examination.customInterval ?? LoonoStrings.customDefaultMonth
        : categorizedExamination.examination.intervalYears;
    //transformMonthToYear
    if (_isCustomExamination) {
      return '${transformMonthToYear(interval)} ${interval < LoonoStrings.monthInYear ? 'měsíců' : 'roků'}';
    } else {
      return '${interval.toString()} ${interval > 1 ? context.l10n.years : context.l10n.year}';
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
        softWrap: true,
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
    final visitData = _getVisitDataForExamination(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          visitData.title,
          textAlign: TextAlign.center,
          style: LoonoFonts.paragraphSmallFontStyle.copyWith(
            color: LoonoColors.primaryEnabled,
            fontWeight: visitData.isAfter ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        Text(
          _isToday ? context.l10n.today : visitData.date,
          textAlign: TextAlign.center,
          style: LoonoFonts.cardSubtitle.copyWith(fontSize: 16),
        ),
        Text(
          visitData.time,
          style: LoonoFonts.cardSubtitle.copyWith(fontSize: 16),
        )
      ],
    );
  }

  Widget _earlyCheckupContent(BuildContext context) {
    final examination = categorizedExamination.examination;
    final interval = _isCustomExamination
        ? examination.customInterval ?? LoonoStrings.customDefaultMonth
        : examination.intervalYears;
    DateTime newWaitToDateTime;
    final lastDateVisit = examination.lastConfirmedDate!.toLocal();

    if (_isCustomExamination && interval <= LoonoStrings.monthInYear) {
      newWaitToDateTime = DateTime(lastDateVisit.year, lastDateVisit.month + interval);
    } else {
      newWaitToDateTime = DateTime(
        lastDateVisit.year + (_isCustomExamination ? transformMonthToYear(interval) : interval),
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _progressBarContent(context),
                ),
              ),
            ),
          ),
          _buildProgressBarLeftDot(),
          _buildProgressBarRightDot(),
        ],
      ),
    );
  }

  Widget _buildProgressBarLeftDot() {
    var color = LoonoColors.red;
    if ([
      const ExaminationCategory.scheduledSoonOrOverdue(),
      const ExaminationCategory.scheduled(),
    ].contains(category)) {
      color = LoonoColors.greenSuccess;
    } else if (category == const ExaminationCategory.waiting()) {
      color = LoonoColors.primary;
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: color,
          width: 16,
          height: 16,
          child: Visibility(
            visible: [
              const ExaminationCategory.scheduledSoonOrOverdue(),
              const ExaminationCategory.scheduled(),
            ].contains(category),
            child: const Icon(
              Icons.done,
              size: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBarRightDot() {
    var color = LoonoColors.primary;
    IconData? icon;
    if (category == const ExaminationCategory.scheduledSoonOrOverdue()) {
      color = LoonoColors.red;
      icon = Icons.priority_high;
    } else if (category == const ExaminationCategory.waiting()) {
      color = LoonoColors.greenSuccess;
      icon = Icons.done;
    }
    return Align(
      alignment: Alignment.centerRight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: color,
          width: 16,
          height: 16,
          child: icon != null
              ? Icon(
                  icon,
                  size: 14,
                  color: Colors.white,
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  _VisitContentData _getVisitDataForExamination(BuildContext context) {
    final now = DateTime.now();
    final plannedDate = categorizedExamination.examination.plannedDate;
    if (plannedDate == null) {
      // this situation should not happened
      return _VisitContentData(
        title: context.l10n.not_ordered,
        time: context.l10n.not_ordered,
        date: context.l10n.not_ordered,
        isAfter: false,
      );
    }
    final time = DateFormat(LoonoStrings.hoursFormat, 'cs-CZ')
        .format(categorizedExamination.examination.plannedDate!.toLocal());
    final visitTimePreposition = categorizedExamination.examination.plannedDate!.toLocal().hour > 11
        ? context.l10n.preposition_in
        : context.l10n.preposition_in_ve;
    final date = DateFormat(LoonoStrings.dateFormatSpacing, 'cs-CZ')
        .format(categorizedExamination.examination.plannedDate!.toLocal());
    final isAfter = now.isAfter(categorizedExamination.examination.plannedDate!.toLocal());
    return _VisitContentData(
      title: isAfter
          ? (sex == Sex.MALE
              ? context.l10n.did_you_visited_male
              : context.l10n.did_you_visited_female)
          : context.l10n.next_visit,
      time: _isToday ? '$visitTimePreposition $time' : time,
      date: _isToday ? context.l10n.today : date,
      isAfter: isAfter,
    );
  }
}

class _VisitContentData {
  const _VisitContentData({
    required this.title,
    required this.time,
    required this.date,
    required this.isAfter,
  });

  final String title;
  final String time;
  final String date;
  final bool isAfter;
}
