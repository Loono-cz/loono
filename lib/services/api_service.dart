import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loono/models/api_params.dart';
import 'package:loono/models/api_response.dart';
import 'package:loono_api/loono_api.dart';

class ApiService {
  const ApiService(this._api);

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
}
