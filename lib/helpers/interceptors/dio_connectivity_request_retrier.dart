import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  final Dio dio;
  final Connectivity connectivity;

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription?.cancel();
          responseCompleter.complete(
            dio.request<dynamic>(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: options,
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
