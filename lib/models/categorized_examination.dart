import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_status.dart';

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
