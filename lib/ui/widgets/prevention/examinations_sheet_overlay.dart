import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/helpers/examination_status.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/prevention/examination_card.dart';

const int _TWO_MONTHS_IN_DAYS = 60;

class ExaminationsSheetOverlay extends StatelessWidget {
  const ExaminationsSheetOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 0.75,
        minChildSize: 0.15,
        builder: (context, scrollController) {
          final categorized = _fakeData.map(
            (e) {
              final status = getStatusForExamination(e);
              if (status == null) return null;
              return CategorizedExamination(examination: e, status: status);
            },
          ).toList()
            ..removeWhere((e) => e == null);
          print(categorized);

          return Container(
            color: LoonoColors.leaderboardPrimary,
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 4.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: examinationStatusOrdering.length,
                    itemBuilder: (context, index) {
                      final examinationStatus = examinationStatusOrdering.elementAt(index);
                      final elements = categorized.where((e) => e?.status == examinationStatus);
                      return elements.isEmpty
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(examinationStatus.getHeaderMessage(context)),
                                  ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: elements
                                        .map(
                                          (e) => ExaminationCard(
                                            categorizedExamination: e!,
                                            onTap: () => AutoRouter.of(context)
                                                .navigate(ExaminationDetailRoute()),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Temporary class for DEV purposes - API is not ready yet. TODO: remove later
class ExaminationRecord {
  const ExaminationRecord({
    required this.examinationType,
    required this.worth,
    this.currentStreak = 0,
    required this.interval,
    this.lastVisitDate,
    this.nextVisitDate,
    required this.priority,
  });

  final ExaminationType examinationType;
  final int worth;
  final int currentStreak;
  final int interval;
  final DateWithoutDay? lastVisitDate;
  final DateTime? nextVisitDate;
  final int priority;

  @override
  String toString() {
    return 'ExaminationRecord{examinationType: $examinationType, worth: $worth, currentStreak: $currentStreak, interval: $interval, lastVisitDate: $lastVisitDate, nextVisitDate: $nextVisitDate, priority: $priority}';
  }
}

class CategorizedExamination {
  const CategorizedExamination({
    required this.examination,
    required this.status,
  });

  final ExaminationRecord examination;
  final ExaminationStatus status;

  @override
  String toString() {
    return 'CategorizedExamination{examination: $examination, status: $status}';
  }
}

final _fakeData = <ExaminationRecord>[
  ExaminationRecord(examinationType: ExaminationType.GENERAL_PRACTITIONER, worth: 200, interval: 2, priority: 1, nextVisitDate: DateTime(2021, 12, 28)),
  ExaminationRecord(examinationType: ExaminationType.GYNECOLOGIST, worth: 300, interval: 1, priority: 3, nextVisitDate: DateTime(2021, 12, 10)),
  ExaminationRecord(examinationType: ExaminationType.MAMMOGRAM, worth: 500, interval: 2, priority: 2),
  ExaminationRecord(examinationType: ExaminationType.OPHTHALMOLOGIST, worth: 100, interval: 2, priority: 9),
  ExaminationRecord(examinationType: ExaminationType.DERMATOLOGIST, worth: 200, interval: 1, priority: 6, nextVisitDate: DateTime(2022, 2, 10)),
  ExaminationRecord(examinationType: ExaminationType.DENTIST, worth: 300, interval: 1, priority: 8, lastVisitDate: DateWithoutDay(month: Months.september, year: 2021)),
  ExaminationRecord(examinationType: ExaminationType.GYNECOLOGIST, worth: 300, interval: 1, priority: 3, lastVisitDate: DateWithoutDay(month: Months.march, year: 2021)),
];

ExaminationStatus? getStatusForExamination(ExaminationRecord examinationRecord) {
  if (examinationRecord.nextVisitDate == null && examinationRecord.lastVisitDate != null) {
    final lastVisitDateWithoutDay = examinationRecord.lastVisitDate!;
    final lastVisitDateTime =
        DateTime(lastVisitDateWithoutDay.year, lastVisitDateWithoutDay.month.index + 1);
    final toSubtract = Duration(days: examinationRecord.interval * 365 + _TWO_MONTHS_IN_DAYS);
    // if last visit date is older than CURRENT_MONTH - (INTERVAL - 2 months)
    if (lastVisitDateTime.difference(DateTime.now().subtract(toSubtract)).inDays < 0) {
      return const ExaminationStatus.never();
    }
    return const ExaminationStatus.waiting();
  }

  final nextVisitDate = examinationRecord.nextVisitDate;
  if (nextVisitDate != null) {
    final diffInDaysFromNow = nextVisitDate.difference(DateTime.now()).inDays;
    if (diffInDaysFromNow > 30) return const ExaminationStatus.scheduled();
    return const ExaminationStatus.scheduledNowOrSoon();
  }

  if (examinationRecord.lastVisitDate == null &&
      onboardingExaminations.contains(examinationRecord.examinationType)) {
    return const ExaminationStatus.unfinished();
  }

  return const ExaminationStatus.never();
}
