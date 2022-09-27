import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono_api/loono_api.dart';

part 'examination_action_types.freezed.dart';

extension ExaminationActionTypeExt on ExaminationActionType {
  ExaminationActionTypeUnion get mapToUnion {
    late final ExaminationActionTypeUnion examinationActionTypeUnion;
    switch (this) {
      case ExaminationActionType.EXAMINATION:
        examinationActionTypeUnion = const ExaminationActionTypeUnion.examination();
        break;
      case ExaminationActionType.CONTROL:
        examinationActionTypeUnion = const ExaminationActionTypeUnion.control();
        break;
      case ExaminationActionType.bLOODCOLLECTION:
        examinationActionTypeUnion = const ExaminationActionTypeUnion.bloodcollection();
        break;
      case ExaminationActionType.vISUALIZATIONMETHODS:
        examinationActionTypeUnion = const ExaminationActionTypeUnion.visualizationmethods();
        break;
    }

    return examinationActionTypeUnion;
  }

  // ignore: non_constant_identifier_names
  String get l10n_name => mapToUnion.when(
        examination: () => 'Odborné vyšetření',
        control: () => 'Kontrola',
        bloodcollection: () => 'Odběr krve',
        visualizationmethods: () => 'Konzultace',
      );
}

@freezed
class ExaminationActionTypeUnion with _$ExaminationActionTypeUnion {
  const ExaminationActionTypeUnion._();

  const factory ExaminationActionTypeUnion.examination() = ExaminationUnion;
  const factory ExaminationActionTypeUnion.control() = ControlUnion;
  const factory ExaminationActionTypeUnion.bloodcollection() = BloodcollectionUnion;
  const factory ExaminationActionTypeUnion.visualizationmethods() = VisualizationMethodsUnion;
}
