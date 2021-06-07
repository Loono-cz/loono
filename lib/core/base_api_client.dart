import 'package:dio/dio.dart';
import 'package:loono/core/api_exception.dart';

abstract class BaseApiClient {
  const BaseApiClient(this._httpClient);

  final Dio _httpClient;

  Uri buildUri({
    required String endpoint,
    required Map<String, dynamic> queryParams,
  });

  String _buildUrl({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) {
    assert(endpoint.isNotEmpty);

    queryParams ??= <String, dynamic>{};
    final filteredQueryParamsToString = <String, String>{
      for (final String key in queryParams.keys)
        if (queryParams[key] != null && '${queryParams[key]}'.isNotEmpty)
          key: '${queryParams[key]}'
    };

    final uri = buildUri(
      endpoint: endpoint,
      queryParams: filteredQueryParamsToString,
    );

    return uri.toString();
  }

  Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final url = _buildUrl(
      endpoint: endpoint,
      queryParams: queryParams,
    );

    try {
      return await _httpClient.delete<dynamic>(url);
    } on DioError catch (error) {
      throw ApiException.from(error);
    }
  }

  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final url = _buildUrl(
      endpoint: endpoint,
      queryParams: queryParams,
    );

    try {
      return await _httpClient.get<dynamic>(
        url,
        options: options,
      );
    } on DioError catch (error) {
      throw ApiException.from(error);
    }
  }

  Future<T> getAsMap<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> json) mapper,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final response = await get(
      endpoint: endpoint,
      queryParams: queryParams,
      options: options,
    );

    return mapper(response.data as Map<String, dynamic>);
  }

  Future<List<T>> getAsList<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> json) mapper,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final response = await get(
      endpoint: endpoint,
      queryParams: queryParams,
      options: options,
    );

    return (response.data as List)
        .map((dynamic json) => mapper(json as Map<String, dynamic>))
        .toList();
  }

  Future<Response> post({
    required String endpoint,
    required dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final url = _buildUrl(
      endpoint: endpoint,
      queryParams: queryParams,
    );

    try {
      return await _httpClient.post<dynamic>(
        url,
        data: data,
        options: options,
      );
    } on DioError catch (error) {
      throw ApiException.from(error);
    }
  }

  Future<T> postAsMap<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> json) mapper,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final response = await post(
      endpoint: endpoint,
      queryParams: queryParams,
      data: data,
      options: options,
    );

    return mapper(response.data as Map<String, dynamic>);
  }

  Future<List<T>> postAsList<T>({
    required String endpoint,
    required dynamic data,
    required T Function(Map<String, dynamic> json) mapper,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final response = await post(
      endpoint: endpoint,
      queryParams: queryParams,
      data: data,
      options: options,
    );

    return (response.data as List)
        .map((dynamic json) => mapper(json as Map<String, dynamic>))
        .toList();
  }

  Future<Response> put({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final url = _buildUrl(
      endpoint: endpoint,
      queryParams: queryParams,
    );

    try {
      return await _httpClient.put<dynamic>(
        url,
        data: data,
        options: options,
      );
    } on DioError catch (error) {
      throw ApiException.from(error);
    }
  }

  Future<T> putAsMap<T>({
    required String endpoint,
    required T Function(Map<String, dynamic> json) mapper,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final response = await put(
      endpoint: endpoint,
      queryParams: queryParams,
      data: data,
      options: options,
    );

    return mapper(response.data as Map<String, dynamic>);
  }
}
