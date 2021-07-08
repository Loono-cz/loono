import 'package:loono/core/app_flavor.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryService {
  SentryService({required this.dns}) : assert(dns.isNotEmpty);

  final String dns;

  /// In order to catch any error that occurs in the app
  /// we need to wrap the runApp method in the sentry scope
  Future<void> sentryScope({
    required AppFlavor appFlavor,
    required AppRunner appRunner,
  }) async {
    await Sentry.init(
      (options) {
        options
          ..dsn = dns
          ..environment = appFlavor.prettyString;
      },
      appRunner: appRunner,
    );
  }
}
