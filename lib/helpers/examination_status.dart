import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';

part 'examination_status.freezed.dart';

/// Ordering for the [ExaminationsSheetOverlay] check-up list component.
const examinationStatusOrdering = <ExaminationStatus>[
  ExaminationStatus.scheduledSoonOrOverdue(),
  ExaminationStatus.newToSchedule(),
  ExaminationStatus.unknownLastVisit(),
  ExaminationStatus.scheduled(),
  ExaminationStatus.waiting(),
];

// TODO: localization
extension ExaminationStatusExt on ExaminationStatus {
  String getHeaderMessage(BuildContext context) {
    return when(
      scheduledSoonOrOverdue: () => 'běž na prohlídku',
      newToSchedule: () => 'objednej se',
      unknownLastVisit: () => 'další prohlídky',
      scheduled: () => 'připomeneme ti prohlídku',
      waiting: () => 'připomeneme ti objednání',
    ).toUpperCase();
  }
}

/// Examination statuses are based on
/// [these rules](https://cesko-digital.atlassian.net/browse/LOON-324).
@freezed
class ExaminationStatus with _$ExaminationStatus {
  const ExaminationStatus._();

  /// Closely related to [ScheduledExamination] status.
  ///
  /// Scheduled check-up visit which is **less than 30 days or equal from now**,
  /// or **overdue** (waiting for confirmation of this check-up visit).
  const factory ExaminationStatus.scheduledSoonOrOverdue() = ScheduledSoonOrOverdueExamination;

  /// Closely related to [WaitingExamination] status. It moves here
  /// if the planned visit and previous visited date is before
  /// **CURRENT_MONTH - (INTERVAL - 2 months)**.
  const factory ExaminationStatus.newToSchedule() = NewToScheduleExamination;

  /// In the onboarding form user did not know the last visit date.
  const factory ExaminationStatus.unknownLastVisit() = UnknownLastVisitExamination;

  /// Scheduled check-up visit which is **more than 30 days from now**.
  const factory ExaminationStatus.scheduled() = ScheduledExamination;

  /// Check-up that the user should visit in the future (more than 2 months).
  const factory ExaminationStatus.waiting() = WaitingExamination;
}
