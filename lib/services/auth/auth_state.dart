import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/models/firebase_user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = Unknown;

  const factory AuthState.notLoggedIn() = LoggedOut;

  const factory AuthState.loggedIn({
    @Default(false) bool isAccountNew,
    AuthUser? authUser,
  }) = LoggedIn;

  const factory AuthState.loggingOut() = LoggingOut;

  const factory AuthState.loggedOutManually() = LoggedOutManually;
}
