abstract class ApiConfig {
  ApiConfig._({
    required this.host,
    this.path = '',
    this.scheme = 'https',
    this.port,
  })  : assert(host.isNotEmpty),
        assert(scheme.isNotEmpty);

  final String host;
  final String path;
  final String scheme;
  final int? port;
}

class DogApiConfig extends ApiConfig {
  DogApiConfig() : super._(
    host: 'dog.ceo',
    path: 'api',
  );
}