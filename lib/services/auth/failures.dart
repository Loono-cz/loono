import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const AuthFailure._();

  const factory AuthFailure.unknown(
          [@Default('Přihlášení se nepovedlo. Zkus to znovu později.') String message]) =
      UnknownFailure;

  const factory AuthFailure.noMessage([@Default('') String message]) = NoMessageFailure;

  const factory AuthFailure.network([@Default('Nejsi připojený/á k internetu.') String message]) =
      NetworkFailure;
}
