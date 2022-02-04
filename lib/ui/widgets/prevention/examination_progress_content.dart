import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';

class ExaminationProgressContent extends StatelessWidget {
  const ExaminationProgressContent({Key? key, required this.categorizedExamination})
      : super(key: key);

  final CategorizedExamination categorizedExamination;

  bool get _isToday {
    final now = DateTime.now();
    final visit = categorizedExamination.examination.nextVisitDate!;
    return now.day == visit.day && now.month == visit.month && now.year == visit.year;
  }

  String _intervalYears(BuildContext context) =>
      '${categorizedExamination.examination.interval.toString()} ${categorizedExamination.examination.interval > 1 ? context.l10n.years : context.l10n.year}';

  /// get correct combination of text font styles and colors
  Widget _progressBarContent(BuildContext context) {
    if (categorizedExamination.category == const ExaminationCategory.scheduledSoonOrOverdue() ||
        categorizedExamination.category == const ExaminationCategory.scheduled()) {
      /// known next visit
      return _scheduledVisitContent(context);
    } else if (categorizedExamination.category == const ExaminationCategory.newToSchedule() ||
        categorizedExamination.category == const ExaminationCategory.waiting()) {
      /// awaiting new checkup
      return _earlyCheckupContent(context);
    } else if (categorizedExamination.examination.lastVisitDate != null) {
      /// examination long overdue
      return Text(
        '${context.l10n.more_than} ${_intervalYears(context)} ${context.l10n.since_last_visit}',
        textAlign: TextAlign.center,
        style: LoonoFonts.paragraphSmallFontStyle.copyWith(fontWeight: FontWeight.w700),
      );
    } else {
      /// first examination
      return Text(
        context.l10n.first_visit_awaiting,
        style: LoonoFonts.paragraphSmallFontStyle.copyWith(fontWeight: FontWeight.w700),
      );
    }
  }

  Widget _scheduledVisitContent(BuildContext context) {
    final now = DateTime.now();
    final visitTime =
        DateFormat('hh:mm', 'cs-CZ').format(categorizedExamination.examination.nextVisitDate!);
    final visitTimePreposition =
        categorizedExamination.examination.nextVisitDate!.hour > 11 ? 've' : 'v';
    final visitDate = DateFormat('dd. MMMM yyyy', 'cs-CZ')
        .format(categorizedExamination.examination.nextVisitDate!);
    final isAfterVisit = now.isAfter(categorizedExamination.examination.nextVisitDate!);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isAfterVisit ? context.l10n.did_you_visited : context.l10n.next_visit,
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
    final lastDateVisit = categorizedExamination.examination.lastVisitDate!;
    final newWaitToDateTime = DateTime(
      lastDateVisit.year + categorizedExamination.examination.interval,
      lastDateVisit.month.index + 1,
    );
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(80),
      child: Container(
        width: 160,
        height: 160,
        color: LoonoColors.beigeLighter,
        child: Center(
          child: _progressBarContent(context),
        ),
      ),
    );
  }
}
