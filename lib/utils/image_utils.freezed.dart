// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'image_utils.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ImageErrorTearOff {
  const _$ImageErrorTearOff();

  UnknownError unknown() {
    return const UnknownError();
  }

  NoMessageError noMessage() {
    return const NoMessageError();
  }

  PermissionDenied permissionDenied(RequiredImagePermission permission) {
    return PermissionDenied(
      permission,
    );
  }

  PermissionPermanentlyDenied permissionPermanentlyDenied(RequiredImagePermission permission) {
    return PermissionPermanentlyDenied(
      permission,
    );
  }

  NetworkError network() {
    return const NetworkError();
  }

  SizeExceededError sizeExceeded() {
    return const SizeExceededError();
  }
}

/// @nodoc
const $ImageError = _$ImageErrorTearOff();

/// @nodoc
mixin _$ImageError {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() noMessage,
    required TResult Function(RequiredImagePermission permission) permissionDenied,
    required TResult Function(RequiredImagePermission permission) permissionPermanentlyDenied,
    required TResult Function() network,
    required TResult Function() sizeExceeded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownError value) unknown,
    required TResult Function(NoMessageError value) noMessage,
    required TResult Function(PermissionDenied value) permissionDenied,
    required TResult Function(PermissionPermanentlyDenied value) permissionPermanentlyDenied,
    required TResult Function(NetworkError value) network,
    required TResult Function(SizeExceededError value) sizeExceeded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageErrorCopyWith<$Res> {
  factory $ImageErrorCopyWith(ImageError value, $Res Function(ImageError) then) =
      _$ImageErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$ImageErrorCopyWithImpl<$Res> implements $ImageErrorCopyWith<$Res> {
  _$ImageErrorCopyWithImpl(this._value, this._then);

  final ImageError _value;
  // ignore: unused_field
  final $Res Function(ImageError) _then;
}

/// @nodoc
abstract class $UnknownErrorCopyWith<$Res> {
  factory $UnknownErrorCopyWith(UnknownError value, $Res Function(UnknownError) then) =
      _$UnknownErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnknownErrorCopyWithImpl<$Res> extends _$ImageErrorCopyWithImpl<$Res>
    implements $UnknownErrorCopyWith<$Res> {
  _$UnknownErrorCopyWithImpl(UnknownError _value, $Res Function(UnknownError) _then)
      : super(_value, (v) => _then(v as UnknownError));

  @override
  UnknownError get _value => super._value as UnknownError;
}

/// @nodoc

class _$UnknownError extends UnknownError {
  const _$UnknownError() : super._();

  @override
  String toString() {
    return 'ImageError.unknown()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is UnknownError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() noMessage,
    required TResult Function(RequiredImagePermission permission) permissionDenied,
    required TResult Function(RequiredImagePermission permission) permissionPermanentlyDenied,
    required TResult Function() network,
    required TResult Function() sizeExceeded,
  }) {
    return unknown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
  }) {
    return unknown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
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
    required TResult Function(UnknownError value) unknown,
    required TResult Function(NoMessageError value) noMessage,
    required TResult Function(PermissionDenied value) permissionDenied,
    required TResult Function(PermissionPermanentlyDenied value) permissionPermanentlyDenied,
    required TResult Function(NetworkError value) network,
    required TResult Function(SizeExceededError value) sizeExceeded,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownError extends ImageError {
  const factory UnknownError() = _$UnknownError;
  const UnknownError._() : super._();
}

/// @nodoc
abstract class $NoMessageErrorCopyWith<$Res> {
  factory $NoMessageErrorCopyWith(NoMessageError value, $Res Function(NoMessageError) then) =
      _$NoMessageErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$NoMessageErrorCopyWithImpl<$Res> extends _$ImageErrorCopyWithImpl<$Res>
    implements $NoMessageErrorCopyWith<$Res> {
  _$NoMessageErrorCopyWithImpl(NoMessageError _value, $Res Function(NoMessageError) _then)
      : super(_value, (v) => _then(v as NoMessageError));

  @override
  NoMessageError get _value => super._value as NoMessageError;
}

/// @nodoc

class _$NoMessageError extends NoMessageError {
  const _$NoMessageError() : super._();

  @override
  String toString() {
    return 'ImageError.noMessage()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is NoMessageError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() noMessage,
    required TResult Function(RequiredImagePermission permission) permissionDenied,
    required TResult Function(RequiredImagePermission permission) permissionPermanentlyDenied,
    required TResult Function() network,
    required TResult Function() sizeExceeded,
  }) {
    return noMessage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
  }) {
    return noMessage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
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
    required TResult Function(UnknownError value) unknown,
    required TResult Function(NoMessageError value) noMessage,
    required TResult Function(PermissionDenied value) permissionDenied,
    required TResult Function(PermissionPermanentlyDenied value) permissionPermanentlyDenied,
    required TResult Function(NetworkError value) network,
    required TResult Function(SizeExceededError value) sizeExceeded,
  }) {
    return noMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
  }) {
    return noMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
    required TResult orElse(),
  }) {
    if (noMessage != null) {
      return noMessage(this);
    }
    return orElse();
  }
}

abstract class NoMessageError extends ImageError {
  const factory NoMessageError() = _$NoMessageError;
  const NoMessageError._() : super._();
}

/// @nodoc
abstract class $PermissionDeniedCopyWith<$Res> {
  factory $PermissionDeniedCopyWith(PermissionDenied value, $Res Function(PermissionDenied) then) =
      _$PermissionDeniedCopyWithImpl<$Res>;
  $Res call({RequiredImagePermission permission});
}

/// @nodoc
class _$PermissionDeniedCopyWithImpl<$Res> extends _$ImageErrorCopyWithImpl<$Res>
    implements $PermissionDeniedCopyWith<$Res> {
  _$PermissionDeniedCopyWithImpl(PermissionDenied _value, $Res Function(PermissionDenied) _then)
      : super(_value, (v) => _then(v as PermissionDenied));

  @override
  PermissionDenied get _value => super._value as PermissionDenied;

  @override
  $Res call({
    Object? permission = freezed,
  }) {
    return _then(PermissionDenied(
      permission == freezed
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as RequiredImagePermission,
    ));
  }
}

/// @nodoc

class _$PermissionDenied extends PermissionDenied {
  const _$PermissionDenied(this.permission) : super._();

  @override
  final RequiredImagePermission permission;

  @override
  String toString() {
    return 'ImageError.permissionDenied(permission: $permission)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PermissionDenied &&
            const DeepCollectionEquality().equals(other.permission, permission));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(permission));

  @JsonKey(ignore: true)
  @override
  $PermissionDeniedCopyWith<PermissionDenied> get copyWith =>
      _$PermissionDeniedCopyWithImpl<PermissionDenied>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() noMessage,
    required TResult Function(RequiredImagePermission permission) permissionDenied,
    required TResult Function(RequiredImagePermission permission) permissionPermanentlyDenied,
    required TResult Function() network,
    required TResult Function() sizeExceeded,
  }) {
    return permissionDenied(permission);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
  }) {
    return permissionDenied?.call(permission);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
    required TResult orElse(),
  }) {
    if (permissionDenied != null) {
      return permissionDenied(permission);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownError value) unknown,
    required TResult Function(NoMessageError value) noMessage,
    required TResult Function(PermissionDenied value) permissionDenied,
    required TResult Function(PermissionPermanentlyDenied value) permissionPermanentlyDenied,
    required TResult Function(NetworkError value) network,
    required TResult Function(SizeExceededError value) sizeExceeded,
  }) {
    return permissionDenied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
  }) {
    return permissionDenied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
    required TResult orElse(),
  }) {
    if (permissionDenied != null) {
      return permissionDenied(this);
    }
    return orElse();
  }
}

abstract class PermissionDenied extends ImageError {
  const factory PermissionDenied(RequiredImagePermission permission) = _$PermissionDenied;
  const PermissionDenied._() : super._();

  RequiredImagePermission get permission;
  @JsonKey(ignore: true)
  $PermissionDeniedCopyWith<PermissionDenied> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionPermanentlyDeniedCopyWith<$Res> {
  factory $PermissionPermanentlyDeniedCopyWith(
          PermissionPermanentlyDenied value, $Res Function(PermissionPermanentlyDenied) then) =
      _$PermissionPermanentlyDeniedCopyWithImpl<$Res>;
  $Res call({RequiredImagePermission permission});
}

/// @nodoc
class _$PermissionPermanentlyDeniedCopyWithImpl<$Res> extends _$ImageErrorCopyWithImpl<$Res>
    implements $PermissionPermanentlyDeniedCopyWith<$Res> {
  _$PermissionPermanentlyDeniedCopyWithImpl(
      PermissionPermanentlyDenied _value, $Res Function(PermissionPermanentlyDenied) _then)
      : super(_value, (v) => _then(v as PermissionPermanentlyDenied));

  @override
  PermissionPermanentlyDenied get _value => super._value as PermissionPermanentlyDenied;

  @override
  $Res call({
    Object? permission = freezed,
  }) {
    return _then(PermissionPermanentlyDenied(
      permission == freezed
          ? _value.permission
          : permission // ignore: cast_nullable_to_non_nullable
              as RequiredImagePermission,
    ));
  }
}

/// @nodoc

class _$PermissionPermanentlyDenied extends PermissionPermanentlyDenied {
  const _$PermissionPermanentlyDenied(this.permission) : super._();

  @override
  final RequiredImagePermission permission;

  @override
  String toString() {
    return 'ImageError.permissionPermanentlyDenied(permission: $permission)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PermissionPermanentlyDenied &&
            const DeepCollectionEquality().equals(other.permission, permission));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(permission));

  @JsonKey(ignore: true)
  @override
  $PermissionPermanentlyDeniedCopyWith<PermissionPermanentlyDenied> get copyWith =>
      _$PermissionPermanentlyDeniedCopyWithImpl<PermissionPermanentlyDenied>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() noMessage,
    required TResult Function(RequiredImagePermission permission) permissionDenied,
    required TResult Function(RequiredImagePermission permission) permissionPermanentlyDenied,
    required TResult Function() network,
    required TResult Function() sizeExceeded,
  }) {
    return permissionPermanentlyDenied(permission);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
  }) {
    return permissionPermanentlyDenied?.call(permission);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
    required TResult orElse(),
  }) {
    if (permissionPermanentlyDenied != null) {
      return permissionPermanentlyDenied(permission);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownError value) unknown,
    required TResult Function(NoMessageError value) noMessage,
    required TResult Function(PermissionDenied value) permissionDenied,
    required TResult Function(PermissionPermanentlyDenied value) permissionPermanentlyDenied,
    required TResult Function(NetworkError value) network,
    required TResult Function(SizeExceededError value) sizeExceeded,
  }) {
    return permissionPermanentlyDenied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
  }) {
    return permissionPermanentlyDenied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
    required TResult orElse(),
  }) {
    if (permissionPermanentlyDenied != null) {
      return permissionPermanentlyDenied(this);
    }
    return orElse();
  }
}

abstract class PermissionPermanentlyDenied extends ImageError {
  const factory PermissionPermanentlyDenied(RequiredImagePermission permission) =
      _$PermissionPermanentlyDenied;
  const PermissionPermanentlyDenied._() : super._();

  RequiredImagePermission get permission;
  @JsonKey(ignore: true)
  $PermissionPermanentlyDeniedCopyWith<PermissionPermanentlyDenied> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkErrorCopyWith<$Res> {
  factory $NetworkErrorCopyWith(NetworkError value, $Res Function(NetworkError) then) =
      _$NetworkErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$NetworkErrorCopyWithImpl<$Res> extends _$ImageErrorCopyWithImpl<$Res>
    implements $NetworkErrorCopyWith<$Res> {
  _$NetworkErrorCopyWithImpl(NetworkError _value, $Res Function(NetworkError) _then)
      : super(_value, (v) => _then(v as NetworkError));

  @override
  NetworkError get _value => super._value as NetworkError;
}

/// @nodoc

class _$NetworkError extends NetworkError {
  const _$NetworkError() : super._();

  @override
  String toString() {
    return 'ImageError.network()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is NetworkError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() noMessage,
    required TResult Function(RequiredImagePermission permission) permissionDenied,
    required TResult Function(RequiredImagePermission permission) permissionPermanentlyDenied,
    required TResult Function() network,
    required TResult Function() sizeExceeded,
  }) {
    return network();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
  }) {
    return network?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownError value) unknown,
    required TResult Function(NoMessageError value) noMessage,
    required TResult Function(PermissionDenied value) permissionDenied,
    required TResult Function(PermissionPermanentlyDenied value) permissionPermanentlyDenied,
    required TResult Function(NetworkError value) network,
    required TResult Function(SizeExceededError value) sizeExceeded,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkError extends ImageError {
  const factory NetworkError() = _$NetworkError;
  const NetworkError._() : super._();
}

/// @nodoc
abstract class $SizeExceededErrorCopyWith<$Res> {
  factory $SizeExceededErrorCopyWith(
          SizeExceededError value, $Res Function(SizeExceededError) then) =
      _$SizeExceededErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$SizeExceededErrorCopyWithImpl<$Res> extends _$ImageErrorCopyWithImpl<$Res>
    implements $SizeExceededErrorCopyWith<$Res> {
  _$SizeExceededErrorCopyWithImpl(SizeExceededError _value, $Res Function(SizeExceededError) _then)
      : super(_value, (v) => _then(v as SizeExceededError));

  @override
  SizeExceededError get _value => super._value as SizeExceededError;
}

/// @nodoc

class _$SizeExceededError extends SizeExceededError {
  const _$SizeExceededError() : super._();

  @override
  String toString() {
    return 'ImageError.sizeExceeded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SizeExceededError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function() noMessage,
    required TResult Function(RequiredImagePermission permission) permissionDenied,
    required TResult Function(RequiredImagePermission permission) permissionPermanentlyDenied,
    required TResult Function() network,
    required TResult Function() sizeExceeded,
  }) {
    return sizeExceeded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
  }) {
    return sizeExceeded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function()? noMessage,
    TResult Function(RequiredImagePermission permission)? permissionDenied,
    TResult Function(RequiredImagePermission permission)? permissionPermanentlyDenied,
    TResult Function()? network,
    TResult Function()? sizeExceeded,
    required TResult orElse(),
  }) {
    if (sizeExceeded != null) {
      return sizeExceeded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownError value) unknown,
    required TResult Function(NoMessageError value) noMessage,
    required TResult Function(PermissionDenied value) permissionDenied,
    required TResult Function(PermissionPermanentlyDenied value) permissionPermanentlyDenied,
    required TResult Function(NetworkError value) network,
    required TResult Function(SizeExceededError value) sizeExceeded,
  }) {
    return sizeExceeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
  }) {
    return sizeExceeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownError value)? unknown,
    TResult Function(NoMessageError value)? noMessage,
    TResult Function(PermissionDenied value)? permissionDenied,
    TResult Function(PermissionPermanentlyDenied value)? permissionPermanentlyDenied,
    TResult Function(NetworkError value)? network,
    TResult Function(SizeExceededError value)? sizeExceeded,
    required TResult orElse(),
  }) {
    if (sizeExceeded != null) {
      return sizeExceeded(this);
    }
    return orElse();
  }
}

abstract class SizeExceededError extends ImageError {
  const factory SizeExceededError() = _$SizeExceededError;
  const SizeExceededError._() : super._();
}
