abstract class AuthFailure {
  const AuthFailure(this.message);

  final String message;
}

class UnknownFailure extends AuthFailure {
  const UnknownFailure([String? message])
      : super(message ?? 'Neznámá chyba. Zkus to znovu později.');
}

class NoMessageFailure extends AuthFailure {
  const NoMessageFailure() : super('');
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure() : super('Nejsi připojený(á) k internetu.');
}
