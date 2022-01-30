import 'package:loono/helpers/examination_extensions.dart' as dummy;

class ExaminationRepository {
  const ExaminationRepository();

  Future<List<dummy.ExaminationRecord>> getExaminationRecords() async {
    return dummy.fakeExaminationData;
  }
}
