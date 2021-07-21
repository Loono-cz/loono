import 'package:dio/dio.dart';
import 'package:loono/core/app_flavor.dart';
import 'package:loono/core/http/api_config.dart';

abstract class AppConfig {
  AppConfig._({required this.flavor, required this.apiConfig});

  final AppFlavor flavor;
  final ApiConfig apiConfig;

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
  ProdConfig()
      : super._(
          flavor: AppFlavor.prod,
          apiConfig: DogApiConfig(),
        );
}

class DevConfig extends AppConfig {
  DevConfig()
      : super._(
          flavor: AppFlavor.dev,
          // We would use a different config for dev and prod
          apiConfig: DogApiConfig(),
        );
}
