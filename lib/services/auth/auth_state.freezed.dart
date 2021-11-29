// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

  Unknown unknown() {
    return const Unknown();
  }

  LoggedOut notLoggedIn() {
    return const LoggedOut();
  }

  LoggedIn loggedIn({bool isAccountNew = false, AuthUser? authUser}) {
    return LoggedIn(
      isAccountNew: isAccountNew,
      authUser: authUser,
    );
  }

  LoggingOut loggingOut() {
    return const LoggingOut();
  }

  LoggedOutManually loggedOutManually() {
    return const LoggedOutManually();
  }
}

/// @nodoc
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() notLoggedIn,
    required TResult Function(bool isAccountNew, AuthUser? authUser) loggedIn,
    required TResult Function() loggingOut,
    required TResult Function() loggedOutManually,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(LoggedOut value) notLoggedIn,
    required TResult Function(LoggedIn value) loggedIn,
    required TResult Function(LoggingOut value) loggingOut,
    required TResult Function(LoggedOutManually value) loggedOutManually,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

/// @nodoc
abstract class $UnknownCopyWith<$Res> {
  factory $UnknownCopyWith(Unknown value, $Res Function(Unknown) then) =
      _$UnknownCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnknownCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $UnknownCopyWith<$Res> {
  _$UnknownCopyWithImpl(Unknown _value, $Res Function(Unknown) _then)
      : super(_value, (v) => _then(v as Unknown));

  @override
  Unknown get _value => super._value as Unknown;
}

/// @nodoc

class _$Unknown implements Unknown {
  const _$Unknown();

  @override
  String toString() {
    return 'AuthState.unknown()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Unknown);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() notLoggedIn,
    required TResult Function(bool isAccountNew, AuthUser? authUser) loggedIn,
    required TResult Function() loggingOut,
    required TResult Function() loggedOutManually,
  }) {
    return unknown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
  }) {
    return unknown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(LoggedOut value) notLoggedIn,
    required TResult Function(LoggedIn value) loggedIn,
    required TResult Function(LoggingOut value) loggingOut,
    required TResult Function(LoggedOutManually value) loggedOutManually,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class Unknown implements AuthState {
  const factory Unknown() = _$Unknown;
}

/// @nodoc
abstract class $LoggedOutCopyWith<$Res> {
  factory $LoggedOutCopyWith(LoggedOut value, $Res Function(LoggedOut) then) =
      _$LoggedOutCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoggedOutCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $LoggedOutCopyWith<$Res> {
  _$LoggedOutCopyWithImpl(LoggedOut _value, $Res Function(LoggedOut) _then)
      : super(_value, (v) => _then(v as LoggedOut));

  @override
  LoggedOut get _value => super._value as LoggedOut;
}

/// @nodoc

class _$LoggedOut implements LoggedOut {
  const _$LoggedOut();

  @override
  String toString() {
    return 'AuthState.notLoggedIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoggedOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() notLoggedIn,
    required TResult Function(bool isAccountNew, AuthUser? authUser) loggedIn,
    required TResult Function() loggingOut,
    required TResult Function() loggedOutManually,
  }) {
    return notLoggedIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
  }) {
    return notLoggedIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
    required TResult orElse(),
  }) {
    if (notLoggedIn != null) {
      return notLoggedIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(LoggedOut value) notLoggedIn,
    required TResult Function(LoggedIn value) loggedIn,
    required TResult Function(LoggingOut value) loggingOut,
    required TResult Function(LoggedOutManually value) loggedOutManually,
  }) {
    return notLoggedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
  }) {
    return notLoggedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
    required TResult orElse(),
  }) {
    if (notLoggedIn != null) {
      return notLoggedIn(this);
    }
    return orElse();
  }
}

abstract class LoggedOut implements AuthState {
  const factory LoggedOut() = _$LoggedOut;
}

/// @nodoc
abstract class $LoggedInCopyWith<$Res> {
  factory $LoggedInCopyWith(LoggedIn value, $Res Function(LoggedIn) then) =
      _$LoggedInCopyWithImpl<$Res>;
  $Res call({bool isAccountNew, AuthUser? authUser});
}

/// @nodoc
class _$LoggedInCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $LoggedInCopyWith<$Res> {
  _$LoggedInCopyWithImpl(LoggedIn _value, $Res Function(LoggedIn) _then)
      : super(_value, (v) => _then(v as LoggedIn));

  @override
  LoggedIn get _value => super._value as LoggedIn;

  @override
  $Res call({
    Object? isAccountNew = freezed,
    Object? authUser = freezed,
  }) {
    return _then(LoggedIn(
      isAccountNew: isAccountNew == freezed
          ? _value.isAccountNew
          : isAccountNew // ignore: cast_nullable_to_non_nullable
              as bool,
      authUser: authUser == freezed
          ? _value.authUser
          : authUser // ignore: cast_nullable_to_non_nullable
              as AuthUser?,
    ));
  }
}

/// @nodoc

class _$LoggedIn implements LoggedIn {
  const _$LoggedIn({this.isAccountNew = false, this.authUser});

  @JsonKey(defaultValue: false)
  @override
  final bool isAccountNew;
  @override
  final AuthUser? authUser;

  @override
  String toString() {
    return 'AuthState.loggedIn(isAccountNew: $isAccountNew, authUser: $authUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoggedIn &&
            (identical(other.isAccountNew, isAccountNew) ||
                const DeepCollectionEquality()
                    .equals(other.isAccountNew, isAccountNew)) &&
            (identical(other.authUser, authUser) ||
                const DeepCollectionEquality()
                    .equals(other.authUser, authUser)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isAccountNew) ^
      const DeepCollectionEquality().hash(authUser);

  @JsonKey(ignore: true)
  @override
  $LoggedInCopyWith<LoggedIn> get copyWith =>
      _$LoggedInCopyWithImpl<LoggedIn>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() notLoggedIn,
    required TResult Function(bool isAccountNew, AuthUser? authUser) loggedIn,
    required TResult Function() loggingOut,
    required TResult Function() loggedOutManually,
  }) {
    return loggedIn(isAccountNew, authUser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
  }) {
    return loggedIn?.call(isAccountNew, authUser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
    required TResult orElse(),
  }) {
    if (loggedIn != null) {
      return loggedIn(isAccountNew, authUser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(LoggedOut value) notLoggedIn,
    required TResult Function(LoggedIn value) loggedIn,
    required TResult Function(LoggingOut value) loggingOut,
    required TResult Function(LoggedOutManually value) loggedOutManually,
  }) {
    return loggedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
  }) {
    return loggedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
    required TResult orElse(),
  }) {
    if (loggedIn != null) {
      return loggedIn(this);
    }
    return orElse();
  }
}

abstract class LoggedIn implements AuthState {
  const factory LoggedIn({bool isAccountNew, AuthUser? authUser}) = _$LoggedIn;

  bool get isAccountNew => throw _privateConstructorUsedError;
  AuthUser? get authUser => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoggedInCopyWith<LoggedIn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoggingOutCopyWith<$Res> {
  factory $LoggingOutCopyWith(
          LoggingOut value, $Res Function(LoggingOut) then) =
      _$LoggingOutCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoggingOutCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $LoggingOutCopyWith<$Res> {
  _$LoggingOutCopyWithImpl(LoggingOut _value, $Res Function(LoggingOut) _then)
      : super(_value, (v) => _then(v as LoggingOut));

  @override
  LoggingOut get _value => super._value as LoggingOut;
}

/// @nodoc

class _$LoggingOut implements LoggingOut {
  const _$LoggingOut();

  @override
  String toString() {
    return 'AuthState.loggingOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoggingOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() notLoggedIn,
    required TResult Function(bool isAccountNew, AuthUser? authUser) loggedIn,
    required TResult Function() loggingOut,
    required TResult Function() loggedOutManually,
  }) {
    return loggingOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
  }) {
    return loggingOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
    required TResult orElse(),
  }) {
    if (loggingOut != null) {
      return loggingOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(LoggedOut value) notLoggedIn,
    required TResult Function(LoggedIn value) loggedIn,
    required TResult Function(LoggingOut value) loggingOut,
    required TResult Function(LoggedOutManually value) loggedOutManually,
  }) {
    return loggingOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
  }) {
    return loggingOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
    required TResult orElse(),
  }) {
    if (loggingOut != null) {
      return loggingOut(this);
    }
    return orElse();
  }
}

abstract class LoggingOut implements AuthState {
  const factory LoggingOut() = _$LoggingOut;
}

/// @nodoc
abstract class $LoggedOutManuallyCopyWith<$Res> {
  factory $LoggedOutManuallyCopyWith(
          LoggedOutManually value, $Res Function(LoggedOutManually) then) =
      _$LoggedOutManuallyCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoggedOutManuallyCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements $LoggedOutManuallyCopyWith<$Res> {
  _$LoggedOutManuallyCopyWithImpl(
      LoggedOutManually _value, $Res Function(LoggedOutManually) _then)
      : super(_value, (v) => _then(v as LoggedOutManually));

  @override
  LoggedOutManually get _value => super._value as LoggedOutManually;
}

/// @nodoc

class _$LoggedOutManually implements LoggedOutManually {
  const _$LoggedOutManually();

  @override
  String toString() {
    return 'AuthState.loggedOutManually()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoggedOutManually);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() notLoggedIn,
    required TResult Function(bool isAccountNew, AuthUser? authUser) loggedIn,
    required TResult Function() loggingOut,
    required TResult Function() loggedOutManually,
  }) {
    return loggedOutManually();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
  }) {
    return loggedOutManually?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? notLoggedIn,
    TResult Function(bool isAccountNew, AuthUser? authUser)? loggedIn,
    TResult Function()? loggingOut,
    TResult Function()? loggedOutManually,
    required TResult orElse(),
  }) {
    if (loggedOutManually != null) {
      return loggedOutManually();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unknown value) unknown,
    required TResult Function(LoggedOut value) notLoggedIn,
    required TResult Function(LoggedIn value) loggedIn,
    required TResult Function(LoggingOut value) loggingOut,
    required TResult Function(LoggedOutManually value) loggedOutManually,
  }) {
    return loggedOutManually(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
  }) {
    return loggedOutManually?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unknown value)? unknown,
    TResult Function(LoggedOut value)? notLoggedIn,
    TResult Function(LoggedIn value)? loggedIn,
    TResult Function(LoggingOut value)? loggingOut,
    TResult Function(LoggedOutManually value)? loggedOutManually,
    required TResult orElse(),
  }) {
    if (loggedOutManually != null) {
      return loggedOutManually(this);
    }
    return orElse();
  }
}

abstract class LoggedOutManually implements AuthState {
  const factory LoggedOutManually() = _$LoggedOutManually;
}
