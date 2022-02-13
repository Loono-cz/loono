import 'dart:developer';

import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_parser.dart';
import 'package:loono/models/api_response.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationRepository {
  const ExaminationRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<List<ExaminationRecordTemp>> getExaminationRecords() async {
    var records = <ExaminationRecordTemp>[];
    final response = await _apiService.getExaminations();
    response.when(
      success: (data) {
        records = parseExaminations(data);
      },
      failure: (err) {},
    );
    return records;
  }

  Future<bool> cancelExamination(ExaminationTypeEnum type, String uuid) async {
    final response = await _apiService.cancelExamination(type, uuid);
    var res = false;
    response.map(
      success: (data) {
        res = true;
      },
      failure: (err) {
        res = false;
      },
    );
    return res;
  }

  Future<ApiResponse<ExaminationRecord>> postExamination(
    ExaminationTypeEnum type, {
    String? uuid,
    DateTime? newDate,
    ExaminationStatus? status,
    bool? firstExam,
  }) async {
    final response = await _apiService.postExamination(
      type,
      uuid: uuid,
      newDate: newDate,
      status: status,
      firstExam: firstExam,
    );
    log(response.runtimeType.toString());
    return response;
  }

  Future<bool> confirmExamination(ExaminationTypeEnum type, {String? uuid}) async {
    final response = await _apiService.confirmExamination(type, id: uuid);
    var res = false;
    response.when(
      success: (data) {
        res = true;
      },
      failure: (err) {},
    );
    return res;
  }
}
