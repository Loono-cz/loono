import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';

part 'self_examination_category.freezed.dart';

extension SelfExaminationStatusExt on SelfExaminationCategory {
  String getHeaderMessage(BuildContext context) => when(
        first: () => context.l10n.do_self_examination,
        active: () => context.l10n.do_self_examination,
        waiting: () => context.l10n.will_remind_you_self_examination,
        hasFinding: () => context.l10n.will_remind_you_self_examination,
        hasFindingExpectingResult: () => context.l10n.tell_us_result_self_examination,
      );
}

/// Self Examination categories are based on
/// [these rules](https://cesko-digital.atlassian.net/browse/LOON-492).
@freezed
class SelfExaminationCategory with _$SelfExaminationCategory {
  const SelfExaminationCategory._();

  const factory SelfExaminationCategory.first() = FirstSelfExamination;

  const factory SelfExaminationCategory.active() = ActiveSelfExamination;

  const factory SelfExaminationCategory.waiting() = WaitingSelfExamination;

  const factory SelfExaminationCategory.hasFinding() = HasFindingSelfExamination;

  const factory SelfExaminationCategory.hasFindingExpectingResult() =
      HasFindingExpectingResultSelfExamination;

  /// Position in the main screen [ExaminationsSheetOverlay], for now it is either first or last.
  CardPosition get position => map(
        first: (_) => CardPosition.first,
        active: (_) => CardPosition.first,
        waiting: (_) => CardPosition.last,
        hasFinding: (_) => CardPosition.last,
        hasFindingExpectingResult: (_) => CardPosition.first,
      );
}

enum CardPosition { first, last }
