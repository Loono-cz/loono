import 'package:loono/core/app_flavor.dart';

abstract class AppConfig {
  const AppConfig._({required this.flavor});

  final AppFlavor flavor;
}

class ProdConfig extends AppConfig {
  const ProdConfig() : super._(flavor: AppFlavor.prod);
}

class DevConfig extends AppConfig {
  const DevConfig() : super._(flavor: AppFlavor.dev);
}