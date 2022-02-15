import 'dart:developer';

import 'package:loono/models/api_response.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationRepository {
  const ExaminationRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  Future<PreventionStatus?> getExaminationRecords() async {
    final response = await _apiService.getExaminations();
    return response.map(
      success: (success) {
        return success.data;
      },
      failure: (err) {
        return null;
      },
    );
  }

  Future<bool> cancelExamination(ExaminationType type, String uuid) async {
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
    ExaminationType type, {
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

  Future<ApiResponse<ExaminationRecord>> confirmExamination(
    ExaminationType type, {
    String? uuid,
  }) async {
    final response = await _apiService.confirmExamination(type, id: uuid);
    log(response.runtimeType.toString());
    return response;
  }
}
