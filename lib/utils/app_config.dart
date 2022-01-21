import 'package:package_info_plus/package_info_plus.dart';

enum AppFlavors { dev, prod }

class AppConfig {
  final String apiUrl;

  final String appId;
  final String appName;
  final String appVersion;
  final String buildNumber;

  final String platformVersion;
  final AppFlavors flavor;

  AppConfig({
    required Map<String, String> env,
    required PackageInfo packageInfo,
    required this.platformVersion,
    required this.flavor,
  })  : apiUrl = getEnvString(env, 'API_URL'),
        appId = packageInfo.packageName,
        appName = packageInfo.appName,
        appVersion = packageInfo.version,
        buildNumber = packageInfo.buildNumber;
}

class ConfigError extends Error {
  final String message;
  ConfigError(this.message);

  @override
  String toString() => 'ConfigError: $message';
}

bool getEnvBool(Map<String, String> env, String key, {bool? defaultValue}) {
  switch (env[key]) {
    case 'true':
      return true;
    case 'false':
      return false;
    case null:
      if (defaultValue != null) {
        return defaultValue;
      }
      throw ConfigError('Invalid config value: $key');
    default:
      throw ConfigError('Invalid config value: $key');
  }
}

int getEnvInt(Map<String, String> env, String key, {int? defaultValue}) {
  final value = env[key];
  if (value == null) {
    if (defaultValue != null) {
      return defaultValue;
    }
    throw ConfigError('Invalid config value: $key');
  } else {
    final parsedValue = int.tryParse(value);
    if (parsedValue != null) {
      return parsedValue;
    }
    throw ConfigError('Invalid config value: $key');
  }
}

String getEnvString(Map<String, String> env, String key, {String? defaultValue}) {
  final value = env[key];
  if (value != null) {
    return value;
  }

  if (defaultValue != null) {
    return defaultValue;
  }

  throw ConfigError('Invalid config value: $key');
}
