// ignore_for_file: constant_identifier_names
import 'package:collection/collection.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_helpers.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_category_types.dart';
import 'package:loono/helpers/self_examination_category.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono_api/loono_api.dart';

const int TO_SCHEDULE_MONTHS_TRANSFER = 2;
const int SELF_EXAMINATION_ACTIVE_CARD_INTERVAL_IN_HOURS = 72;

extension ExaminationPreventionStatusExt on ExaminationPreventionStatus {
  bool get isCustom => examinationCategoryType == ExaminationCategoryType.CUSTOM;
  ExaminationCategory calculateStatus([DateTime? dateTimeNow]) {
    final now = dateTimeNow ?? DateTime.now();

    // STATUS: waiting or newToSchedule
    if (([ExaminationStatus.CONFIRMED, ExaminationStatus.UNKNOWN].contains(state)) &&
        lastConfirmedDate != null &&
        (periodicExam == true || periodicExam == null)) {
      final lastVisitDateTime = lastConfirmedDate!.toLocal();
      final lastVisitDateWithoutDay = DateTime(lastVisitDateTime.year, lastVisitDateTime.month);
      DateTime subtractedWaitingDate;
      if (isCustom && customInterval != null) {
        subtractedWaitingDate = DateTime(
          now.year,
          now.month -
              (transformMonthToYear(customInterval!) * LoonoStrings.monthInYear -
                  TO_SCHEDULE_MONTHS_TRANSFER),
        );
      } else {
        // if last visit date is before: CURRENT_MONTH - (INTERVAL - 2 months)
        subtractedWaitingDate = DateTime(
          now.year,
          now.month - (intervalYears * LoonoStrings.monthInYear - TO_SCHEDULE_MONTHS_TRANSFER),
        );
      }

      // then waiting time has ended, move to "TO BE SCHEDULED"
      if (lastVisitDateWithoutDay.isBefore(subtractedWaitingDate) ||
          lastVisitDateWithoutDay.isAtSameMomentAs(subtractedWaitingDate)) {
        return const ExaminationCategory.newToSchedule();
      }
      // else wait
      return const ExaminationCategory.waiting();
    }
    if ([ExaminationStatus.UNKNOWN, ExaminationStatus.CANCELED].contains(state)) {
      return const ExaminationCategory.newToSchedule();
    }

    // STATUS: scheduled or scheduledSoonOrOverdue
    if (plannedDate != null) {
      final diffInDaysFromNow = plannedDate!.toLocal().difference(now).inDays;
      // if it is more than 30 days before the check-up visit the status is "SCHEDULED"
      if (diffInDaysFromNow > 30) return const ExaminationCategory.scheduled();
      // else 30 days or equal before check-up visit the status is "SCHEDULED_SOON_OR_OVERDUE"
      return const ExaminationCategory.scheduledSoonOrOverdue();
    }

    // else fallback to STATUS: unknownLastVisit
    return const ExaminationCategory.unknownLastVisit();
  }
}

extension SelfExaminationPreventionStatusExt on SelfExaminationPreventionStatus {
  SelfExaminationCategory calculateStatus([DateTime? dateTimeNow]) {
    final now = dateTimeNow ?? DateTime.now();

    if (history.isEmpty) {
      return const SelfExaminationCategory.first();
    }

    if (history.last == SelfExaminationStatus.WAITING_FOR_RESULT) {
      return const SelfExaminationCategory.hasFindingExpectingResult();
    }

    if (history.last == SelfExaminationStatus.WAITING_FOR_CHECKUP) {
      return const SelfExaminationCategory.hasFinding();
    }

    if (history.last == SelfExaminationStatus.PLANNED) {
      if (plannedDate != null) {
        final nowDate = DateTime(now.year, now.month, now.day); //now with set hour and minute to 0
        final difference = plannedDate!.toDateTime().difference(nowDate).inHours.abs();
        if (difference <= SELF_EXAMINATION_ACTIVE_CARD_INTERVAL_IN_HOURS) {
          return const SelfExaminationCategory.active();
        } else {
          return const SelfExaminationCategory.waiting();
        }
      }
    }

    return const SelfExaminationCategory.waiting();
  }
}

extension ExaminationExt on ExaminationPreventionStatus{
  DateTime? get targetExamDate  {
    if(plannedDate != null && plannedDate != lastConfirmedDate){
      return plannedDate!;
    }
    else if(lastConfirmedDate != null){
      final months =
          customInterval != null ? customInterval! : intervalYears * 12;
      return DateTime(lastConfirmedDate!.year, lastConfirmedDate!.month + months, lastConfirmedDate!.day);
    } else {
      return null;
    }
  }
}

extension CategorizedExaminationListExt on List<CategorizedExamination> {
  void sortExaminations() {
    if (isEmpty) return;

    final scheduledOrOverdue = <CategorizedExamination>[];
    final newToSchedule = <CategorizedExamination>[];
    final unknownLastVisit = <CategorizedExamination>[];
    final scheduled = <CategorizedExamination>[];
    final waiting = <CategorizedExamination>[];

    for (final exam in this) {
      exam.category.whenOrNull(
        scheduledSoonOrOverdue: () => scheduledOrOverdue.add(exam),
        newToSchedule: () => newToSchedule.add(exam),
        unknownLastVisit: () => unknownLastVisit.add(exam),
        scheduled: () => scheduled.add(exam),
        waiting: () => waiting.add(exam),
      );
    }

    final sorted = <CategorizedExamination>[
      ...scheduledOrOverdue.sorted(_compareByDateThenByCategoryType),
      ...newToSchedule.sorted(_compareNewToSchedule),
      ...unknownLastVisit
          .sorted((a, b) => compareExaminationType(a, b, compareByDate: false)),
      ...scheduled.sorted(_compareByDateThenByCategoryType),
      ...waiting.sorted(_compareByDateThenByCategoryType),
    ];
    clear();
    addAll(sorted);
  }

  int _compareNewToSchedule(CategorizedExamination a,
      CategorizedExamination b,) {
    final now = DateTime.now();
    final aWaitingDate = a.examination.isCustom
        ? DateTime(now.year, now.month - (a.examination.customInterval ?? 0))
        : DateTime(
      now.year,
      now.month -
          (a.examination.intervalYears * LoonoStrings.monthInYear -
              TO_SCHEDULE_MONTHS_TRANSFER),
    );
    final bWaitingDate = b.examination.isCustom
        ? DateTime(now.year, now.month - (b.examination.customInterval ?? 0))
        : DateTime(
      now.year,
      now.month -
          (b.examination.intervalYears * LoonoStrings.monthInYear -
              TO_SCHEDULE_MONTHS_TRANSFER),
    );
    final aDifference = now
        .difference(aWaitingDate)
        .inDays;
    final bDifference = now
        .difference(bWaitingDate)
        .inDays;

    if (aDifference > 60 && bDifference < 60) {
      return -1;
    }
    else if (aDifference < 60 && bDifference > 60) {
      return 1;
    }
    else {
      return compareExaminationType(a, b, compareByDate: false);
    }
  }

  int _compareByDateThenByCategoryType(
    CategorizedExamination a,
    CategorizedExamination b,
  ) {
    final dateDifference = a.examination.targetExamDate!.difference(b.examination.targetExamDate!).inDays;

    if (dateDifference == 0) {
      return compareExaminationType(a, b, compareByDate: false);
    }
    else {
      return dateDifference > 0 ? 1 : -1;
    }
  }
}
