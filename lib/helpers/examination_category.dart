import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';

part 'examination_category.freezed.dart';

/// Ordering for the [ExaminationsSheetOverlay] check-up list component.
const examinationCategoriesOrdering = <ExaminationCategory>[
  ExaminationCategory.scheduledSoonOrOverdue(),
  ExaminationCategory.newToSchedule(),
  ExaminationCategory.unknownLastVisit(),
  ExaminationCategory.scheduled(),
  ExaminationCategory.waiting(),
];

// TODO: localization
extension ExaminationStatusExt on ExaminationCategory {
  String getHeaderMessage(BuildContext context) {
    return when(
      scheduledSoonOrOverdue: () => 'Běž na prohlídku',
      newToSchedule: () => 'Objednej se',
      unknownLastVisit: () => 'Další prohlídky',
      scheduled: () => 'Připomenu ti prohlídku',
      waiting: () => 'Připomenu ti objednání',
    );
  }
}

/// Examination categories are based on
/// [these rules](https://cesko-digital.atlassian.net/browse/LOON-324).
@freezed
class ExaminationCategory with _$ExaminationCategory {
  const ExaminationCategory._();

  /// Closely related to [ScheduledExamination] category.
  ///
  /// Scheduled check-up visit which is **less than 30 days or equal from now**,
  /// or **overdue** (waiting for confirmation of this check-up visit).
  const factory ExaminationCategory.scheduledSoonOrOverdue() = ScheduledSoonOrOverdueExamination;

  /// Closely related to [WaitingExamination] category. It moves here
  /// if the planned visit and previous visited date is before
  /// **CURRENT_MONTH - (INTERVAL - 2 months)**.
  const factory ExaminationCategory.newToSchedule() = NewToScheduleExamination;

  /// In the onboarding form user did not know the last visit date.
  const factory ExaminationCategory.unknownLastVisit() = UnknownLastVisitExamination;

  /// Scheduled check-up visit which is **more than 30 days from now**.
  const factory ExaminationCategory.scheduled() = ScheduledExamination;

  /// Check-up that the user should visit in the future (more than 2 months).
  const factory ExaminationCategory.waiting() = WaitingExamination;
}
