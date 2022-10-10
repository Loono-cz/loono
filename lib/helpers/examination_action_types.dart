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
      case ExaminationActionType.BLOOD_COLLECTION:
        examinationActionTypeUnion = const ExaminationActionTypeUnion.bloodcollection();
        break;
      case ExaminationActionType.VISUALIZATION_METHODS:
        examinationActionTypeUnion = const ExaminationActionTypeUnion.visualizationmethods();
        break;
    }

    return examinationActionTypeUnion;
  }

  // ignore: non_constant_identifier_names
  String get l10n_name => mapToUnion.when(
        examination: () => 'Vyšetření',
        control: () => 'Kontrola',
        bloodcollection: () => 'Odběry',
        visualizationmethods: () => 'Zobrazovací metody',
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
