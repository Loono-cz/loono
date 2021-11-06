import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/models/firebase_user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = Unknown;

  const factory AuthState.accountJustCreated([AuthUser? authUser]) = AccountCreated;

  const factory AuthState.loggedIn() = LoggedIn;

  const factory AuthState.loggingOut() = LoggingOut;

  const factory AuthState.loggedOutManually() = LoggedOutManually;

  const factory AuthState.loggedOut() = LoggedOut;
}
