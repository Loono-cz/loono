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

  Future<ApiResponse<HealthcareProviderDetail>> getProvidersDetailByIds(
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

  Future<ApiResponse<void>> deleteAccount() async {
    final response = await _callApi(() async => _api.getAccountApi().deleteAccount());
    return response;
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
}
