import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/ui/widgets/prevention/examinations_sheet_overlay.dart';

part 'self_examination_category.freezed.dart';

extension SelfExaminationStatusExt on SelfExaminationCategory {
  String getHeaderMessage() {
    return when(
      first: () => 'Vyšetři se',
      active: () => 'Vyšetři se',
      waiting: () => 'Připomenu ti vyšetření',
      hasFinding: () => 'Připomenu ti vyšetření',
      hasFindingExpectingResult: () => 'Řekni nám výsledek',
    );
  }
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
