import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loono/models/api_params.dart';
import 'package:loono/models/api_response.dart';
import 'package:loono_api/loono_api.dart';

class ApiService {
  const ApiService({required LoonoApi api}) : _api = api;

  final LoonoApi _api;

  Future<ApiResponse<T>> _callApi<T>(Future<Response<T>> Function() apiCallback) async {
    try {
      // ignore: omit_local_variable_types
      final Response<T> response = await apiCallback();
      return ApiResponse<T>.success(response.data as T);
    } on DioError catch (e, _) {
      debugPrint(e.toString());
      return ApiResponse.failure(e);
    }
  }

  Future<ApiResponse<Uint8List>> getProvidersAll({ApiParams? params}) async {
    return _callApi(
      () async => _api.getProvidersApi().getProvidersAll(
            cancelToken: params?.cancelToken,
            extra: params?.extra,
            headers: params?.headers,
            onReceiveProgress: params?.onReceiveProgress,
            onSendProgress: params?.onSendProgress,
            validateStatus: params?.validateStatus,
          ),
    );
  }

  Future<ApiResponse<HealthcareProviderLastUpdate>> getProvidersLastUpdate() async {
    return _callApi(() async => _api.getProvidersApi().getProvidersLastupdate());
  }

  Future<ApiResponse<HealthcareProviderDetailList>> getProvidersDetailByIds(
    HealthcareProviderIdList idList,
  ) async {
    return _callApi(
      () async => _api.getProvidersApi().postProvidersDetail(
            healthcareProviderIdList: idList,
          ),
    );
  }

  Future<ApiResponse<Account>> getAccount() async {
    return _callApi(() async => _api.getAccountApi().getAccount());
  }

  Future<ApiResponse<Account>> updateAccountSettings({
    bool appointmentReminderEmailsOptIn = true,
    bool leaderboardAnonymizationOptIn = false,
    bool newsletterOptIn = false,
  }) async {
    return _callApi(
      () async => _api.getAccountApi().updateAccountSettings(
        settings: Settings((b) {
          b
            ..appointmentReminderEmailsOptIn = appointmentReminderEmailsOptIn
            ..leaderboardAnonymizationOptIn = leaderboardAnonymizationOptIn
            ..newsletterOptIn = newsletterOptIn;
        }),
      ),
    );
  }

  Future<ApiResponse<Account>> updateAccountUser({
    Sex? sex,
    int? birthdateYear,
    int? birthdateMonth,
    String? nickname,
    String? preferredEmail,
    String? profileImageUrl,
  }) async {
    return _callApi(
      () async => _api.getAccountApi().updateAccountUser(
        userPatch: UserPatch((b) {
          b
            ..sex = sex
            ..birthdateYear = birthdateYear
            ..birthdateMonth = birthdateMonth
            ..nickname = nickname
            ..preferredEmail = preferredEmail
            ..profileImageUrl = profileImageUrl;
        }),
      ),
    );
  }

  Future<ApiResponse<PreventionStatus>> getExaminations({ApiParams? params}) async {
    return _callApi(
      () async => _api.getExaminationsApi().getExaminations(
            cancelToken: params?.cancelToken,
            extra: params?.extra,
            headers: params?.headers,
            onReceiveProgress: params?.onReceiveProgress,
            onSendProgress: params?.onSendProgress,
            validateStatus: params?.validateStatus,
          ),
    );
  }

  Future<ApiResponse<ExaminationRecord>> cancelExamination(
    ExaminationType type,
    String uuid,
  ) async {
    return _callApi(
      () async => _api.getExaminationsApi().cancelExamination(
        examinationId: ExaminationId((id) {
          id.uuid = uuid;
        }),
      ),
    );
  }

  Future<ApiResponse<ExaminationRecord>> postExamination(
    ExaminationType type, {
    String? uuid,
    DateTime? newDate,
    ExaminationStatus? status,
    bool? firstExam,
  }) async {
    DateTime? utcNewDate;
    if (newDate != null) {
      utcNewDate = DateTime.utc(
        newDate.year,
        newDate.month,
        newDate.day,
        newDate.hour,
        newDate.minute,
        newDate.second,
      );
    }

    return _callApi(
      () async => _api.getExaminationsApi().postExaminations(
        examinationRecord: ExaminationRecord((record) {
          record
            ..uuid = uuid
            ..type = type
            ..date = utcNewDate
            ..status = status
            ..firstExam = firstExam;
        }),
      ),
    );
  }

  Future<ApiResponse<ExaminationRecord>> confirmExamination(
    ExaminationType type, {
    String? id,
  }) async {
    return _callApi(
      () async => _api.getExaminationsApi().completeExamination(
        examinationId: ExaminationId((newId) {
          newId.uuid = id;
        }),
      ),
    );
  }

  Future<ApiResponse<Leaderboard>> getLeaderboard() {
    return _callApi(() async => _api.getLeaderboardApi().getLeaderboard());
  }
}
