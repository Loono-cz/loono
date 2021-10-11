// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthFailureTearOff {
  const _$AuthFailureTearOff();

  UnknownFailure unknown([String? message]) {
    return UnknownFailure(
      message,
    );
  }

  NoMessageFailure noMessage() {
    return const NoMessageFailure();
  }

  NetworkFailure network([String? message]) {
    return NetworkFailure(
      message,
    );
  }
}

/// @nodoc
const $AuthFailure = _$AuthFailureTearOff();

/// @nodoc
mixin _$AuthFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) unknown,
    required TResult Function() noMessage,
    required TResult Function(String? message) network,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? unknown,
    TResult Function()? noMessage,
    TResult Function(String? message)? network,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? unknown,
    TResult Function()? noMessage,
    TResult Function(String? message)? network,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(NoMessageFailure value) noMessage,
    required TResult Function(NetworkFailure value) network,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(NetworkFailure value)? network,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(NetworkFailure value)? network,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(
          AuthFailure value, $Res Function(AuthFailure) then) =
      _$AuthFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthFailureCopyWithImpl<$Res> implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._value, this._then);

  final AuthFailure _value;
  // ignore: unused_field
  final $Res Function(AuthFailure) _then;
}

/// @nodoc
abstract class $UnknownFailureCopyWith<$Res> {
  factory $UnknownFailureCopyWith(
          UnknownFailure value, $Res Function(UnknownFailure) then) =
      _$UnknownFailureCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class _$UnknownFailureCopyWithImpl<$Res> extends _$AuthFailureCopyWithImpl<$Res>
    implements $UnknownFailureCopyWith<$Res> {
  _$UnknownFailureCopyWithImpl(
      UnknownFailure _value, $Res Function(UnknownFailure) _then)
      : super(_value, (v) => _then(v as UnknownFailure));

  @override
  UnknownFailure get _value => super._value as UnknownFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(UnknownFailure(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnknownFailure extends UnknownFailure {
  const _$UnknownFailure([this.message]) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthFailure.unknown(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UnknownFailure &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $UnknownFailureCopyWith<UnknownFailure> get copyWith =>
      _$UnknownFailureCopyWithImpl<UnknownFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) unknown,
    required TResult Function() noMessage,
    required TResult Function(String? message) network,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? unknown,
    TResult Function()? noMessage,
    TResult Function(String? message)? network,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? unknown,
    TResult Function()? noMessage,
    TResult Function(String? message)? network,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(NoMessageFailure value) noMessage,
    required TResult Function(NetworkFailure value) network,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(NetworkFailure value)? network,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(NetworkFailure value)? network,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure extends AuthFailure {
  const factory UnknownFailure([String? message]) = _$UnknownFailure;
  const UnknownFailure._() : super._();

  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnknownFailureCopyWith<UnknownFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoMessageFailureCopyWith<$Res> {
  factory $NoMessageFailureCopyWith(
          NoMessageFailure value, $Res Function(NoMessageFailure) then) =
      _$NoMessageFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$NoMessageFailureCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res>
    implements $NoMessageFailureCopyWith<$Res> {
  _$NoMessageFailureCopyWithImpl(
      NoMessageFailure _value, $Res Function(NoMessageFailure) _then)
      : super(_value, (v) => _then(v as NoMessageFailure));

  @override
  NoMessageFailure get _value => super._value as NoMessageFailure;
}

/// @nodoc

class _$NoMessageFailure extends NoMessageFailure {
  const _$NoMessageFailure() : super._();

  @override
  String toString() {
    return 'AuthFailure.noMessage()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is NoMessageFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) unknown,
    required TResult Function() noMessage,
    required TResult Function(String? message) network,
  }) {
    return noMessage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? unknown,
    TResult Function()? noMessage,
    TResult Function(String? message)? network,
  }) {
    return noMessage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? unknown,
    TResult Function()? noMessage,
    TResult Function(String? message)? network,
    required TResult orElse(),
  }) {
    if (noMessage != null) {
      return noMessage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(NoMessageFailure value) noMessage,
    required TResult Function(NetworkFailure value) network,
  }) {
    return noMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(NetworkFailure value)? network,
  }) {
    return noMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(NetworkFailure value)? network,
    required TResult orElse(),
  }) {
    if (noMessage != null) {
      return noMessage(this);
    }
    return orElse();
  }
}

abstract class NoMessageFailure extends AuthFailure {
  const factory NoMessageFailure() = _$NoMessageFailure;
  const NoMessageFailure._() : super._();
}

/// @nodoc
abstract class $NetworkFailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(
          NetworkFailure value, $Res Function(NetworkFailure) then) =
      _$NetworkFailureCopyWithImpl<$Res>;
  $Res call({String? message});
}

/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res> extends _$AuthFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(
      NetworkFailure _value, $Res Function(NetworkFailure) _then)
      : super(_value, (v) => _then(v as NetworkFailure));

  @override
  NetworkFailure get _value => super._value as NetworkFailure;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(NetworkFailure(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NetworkFailure extends NetworkFailure {
  const _$NetworkFailure([this.message]) : super._();

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthFailure.network(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NetworkFailure &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $NetworkFailureCopyWith<NetworkFailure> get copyWith =>
      _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) unknown,
    required TResult Function() noMessage,
    required TResult Function(String? message) network,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? message)? unknown,
    TResult Function()? noMessage,
    TResult Function(String? message)? network,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? unknown,
    TResult Function()? noMessage,
    TResult Function(String? message)? network,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(NoMessageFailure value) noMessage,
    required TResult Function(NetworkFailure value) network,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(NetworkFailure value)? network,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(NetworkFailure value)? network,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure extends AuthFailure {
  const factory NetworkFailure([String? message]) = _$NetworkFailure;
  const NetworkFailure._() : super._();

  String? get message => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NetworkFailureCopyWith<NetworkFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
