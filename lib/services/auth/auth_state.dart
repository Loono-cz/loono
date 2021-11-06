import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = Unknown;

  const factory AuthState.accountCreated() = AccountCreated;

  const factory AuthState.loggedIn() = LoggedIn;

  const factory AuthState.loggingOut() = LoggingOut;

  const factory AuthState.loggedManually() = LoggedOutManually;

  const factory AuthState.loggedOut() = LoggedOut;
}
