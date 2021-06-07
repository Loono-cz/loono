import 'package:dio/dio.dart';
import 'package:loono/core/app_flavor.dart';

abstract class AppConfig {
  AppConfig._({required this.flavor});

  final AppFlavor flavor;

  final BaseOptions dioBaseOptions = BaseOptions(
    connectTimeout: 10000, // 10s
    receiveTimeout: 5000,
    contentType: 'application/json',
    validateStatus: (status) {
      return status != null && status >= 200 && status <= 299;
    },
  );
}

class ProdConfig extends AppConfig {
  ProdConfig() : super._(flavor: AppFlavor.prod);
}

class DevConfig extends AppConfig {
  DevConfig() : super._(flavor: AppFlavor.dev);
}
