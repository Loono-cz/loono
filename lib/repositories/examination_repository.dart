import 'package:loono/helpers/examination_extensions.dart';

class ExaminationRepository {
  const ExaminationRepository();

  Future<List<ExaminationRecord>> getExaminationRecords() async {
    return fakeExaminationData;
  }
}
