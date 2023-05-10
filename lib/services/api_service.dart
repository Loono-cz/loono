import 'dart:async';
import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/models/api_params.dart';
import 'package:loono/models/api_response.dart';
import 'package:loono/utils/my_logger.dart';
import 'package:loono_api/loono_api.dart';

class ApiService {
  const ApiService({
    required LoonoApi api,
  }) : _api = api;

  final LoonoApi _api;

  Future<ApiResponse<T>> _callApi<T>(Future<Response<T>> Function() apiCallback) async {
    try {
      // ignore: omit_local_variable_types
      final Response<T> response = await apiCallback();
      return ApiResponse<T>.success(response.data as T);
    } on DioError catch (e) {
      await MyLogger().writeToFile('${e.message}: ${e.response.toString()}\n${e.toString()}');
      debugPrint('${e.message}: ${e.response.toString()}\n${e.toString()}');
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

  Future<ApiResponse<Account>> updateAccountUser({
    String? nickname,
    String? preferredEmail,
    String? profileImageUrl,
    bool? newsletterOptIn,
  }) async {
    return _callApi(
      () async => _api.getAccountApi().postAccount(
        accountUpdate: AccountUpdate((b) {
          b
            ..nickname = nickname
            ..preferredEmail = preferredEmail
            ..newsletterOptIn = newsletterOptIn
            ..profileImageUrl = profileImageUrl;
        }),
      ),
    );
  }

  Future<ApiResponse<Account>> onboardUser({
    required Sex sex,
    required DateWithoutDay birthdate,
    required BuiltList<ExaminationRecord> examinations,
    required String nickname,
    required String preferredEmail,
    required bool newsletterOptIn,
  }) async {
    return _callApi(
      () async => _api.getAccountApi().postAccountOnboard(
            accountOnboarding: AccountOnboarding(
              (b) => b
                ..sex = sex
                ..nickname = nickname
                ..preferredEmail = preferredEmail
                ..examinations = examinations.toBuilder()
                ..birthdate = Date(birthdate.year, birthdate.month.index + 1, 1)
                ..newsletterOptIn = newsletterOptIn,
            ),
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

  Future<ApiResponse<void>> deleteExamination(
    String uuid,
  ) async {
    return _callApi(
      () async => _api.getExaminationsApi().deleteExamination(
        examinationId: ExaminationId((id) {
          id.uuid = uuid;
        }),
      ),
    );
  }

  Future<ApiResponse<ExaminationRecord>> postExamination(
    ExaminationType type, {
    String? uuid,
    DateTime? newDate, //planned Date
    ExaminationStatus? status,
    bool? firstExam,
    ExaminationCategoryType categoryType = ExaminationCategoryType.MANDATORY,
    String? note,
    int? customInterval,
    bool? periodicExam,
    ExaminationActionType? actionType,
    Date? createdAt,
  }) async {
    return _callApi(
      () async => _api.getExaminationsApi().postExaminations(
        examinationRecord: ExaminationRecord((record) {
          record
            ..uuid = uuid
            ..type = type
            ..plannedDate = newDate?.toUtc()
            ..status = status
            ..firstExam = firstExam
            ..customInterval = customInterval
            ..periodicExam = periodicExam
            ..note = note
            ..examinationCategoryType = categoryType
            ..examinationActionType = actionType
            ..createdAt = createdAt;
        }),
      ),
    );
  }

  Future<ApiResponse<ExaminationRecord>> confirmExamination(
    String? id,
  ) async {
    return _callApi(
      () async => _api.getExaminationsApi().completeExamination(
        examinationId: ExaminationId((newId) {
          newId.uuid = id;
        }),
      ),
    );
  }

  Future<ApiResponse<SelfExaminationCompletionInformation>> confirmSelfExamination(
    SelfExaminationType type, {
    required SelfExaminationResult result,
  }) async {
    return _callApi(
      () async => _api.getExaminationsApi().confirmSelfExamination(
            selfType: type.name,
            selfExaminationResult: result,
          ),
    );
  }

  Future<ApiResponse<SelfExaminationFindingResponse>> resultSelfExamination(
    SelfExaminationType type, {
    required SelfExaminationResult result,
  }) async {
    return _callApi(
      () async => _api.getExaminationsApi().resultSelfExamination(
            selfType: type.name,
            selfExaminationResult: result,
          ),
    );
  }

  Future<ApiResponse<Leaderboard>> getLeaderboard() {
    return _callApi(() async => _api.getLeaderboardApi().getLeaderboard(leaderboardSize: 6));
  }

  Future<ApiResponse<void>> deleteAccount() async {
    return _callApi(
      () async => _api.getAccountApi().deleteAccount(),
    );
  }

  Future<ApiResponse<HealthcareProviderDetailList>> postProviderDetail({
    ApiParams? params,
    required List<HealthcareProviderId> providersIds,
  }) async {
    return _callApi(
      () async => _api.getProvidersApi().postProvidersDetail(
            healthcareProviderIdList: HealthcareProviderIdList((list) {
              list.providersIds = BuiltList.of(providersIds).toBuilder();
            }),
            headers: params?.headers,
            cancelToken: params?.cancelToken,
            extra: params?.extra,
            onReceiveProgress: params?.onReceiveProgress,
            onSendProgress: params?.onSendProgress,
            validateStatus: params?.validateStatus,
          ),
    );
  }

  Future<bool> sendFeedback({
    required String? message,
    required int rating,
    required String? uid,
  }) async {
    final res = await _callApi(
      () async => _api.getDefaultApi().feedback(
            userFeedback: UserFeedback(
              (b) => b
                ..uid = uid
                ..message = message
                ..evaluation = rating,
            ),
          ),
    );
    return res.when(success: (_) => true, failure: (_) => false);
  }

  Future<bool> sendConsultancyForm({
    required String tag,
    required String message,
  }) async {
    final res = await _callApi(
      () async => _api.getDefaultApi().postConsultancyFrom(
            consultancyFormContent: ConsultancyFormContent(
              (b) => b
                ..tag = tag
                ..message = message,
            ),
          ),
    );
    return res.when(success: (_) => true, failure: (_) => false);
  }
}
