// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message, String? errCode) unknown,
    required TResult Function() noMessage,
    required TResult Function(SocialLoginAccount socialLoginAccount)
        accountNotExists,
    required TResult Function(String? message) network,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message, String? errCode)? unknown,
    TResult? Function()? noMessage,
    TResult? Function(SocialLoginAccount socialLoginAccount)? accountNotExists,
    TResult? Function(String? message)? network,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message, String? errCode)? unknown,
    TResult Function()? noMessage,
    TResult Function(SocialLoginAccount socialLoginAccount)? accountNotExists,
    TResult Function(String? message)? network,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(NoMessageFailure value) noMessage,
    required TResult Function(AccountNotExists value) accountNotExists,
    required TResult Function(NetworkFailure value) network,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(NoMessageFailure value)? noMessage,
    TResult? Function(AccountNotExists value)? accountNotExists,
    TResult? Function(NetworkFailure value)? network,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(AccountNotExists value)? accountNotExists,
    TResult Function(NetworkFailure value)? network,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(
          AuthFailure value, $Res Function(AuthFailure) then) =
      _$AuthFailureCopyWithImpl<$Res, AuthFailure>;
}

/// @nodoc
class _$AuthFailureCopyWithImpl<$Res, $Val extends AuthFailure>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UnknownFailureCopyWith<$Res> {
  factory _$$UnknownFailureCopyWith(
          _$UnknownFailure value, $Res Function(_$UnknownFailure) then) =
      __$$UnknownFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message, String? errCode});
}

/// @nodoc
class __$$UnknownFailureCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$UnknownFailure>
    implements _$$UnknownFailureCopyWith<$Res> {
  __$$UnknownFailureCopyWithImpl(
      _$UnknownFailure _value, $Res Function(_$UnknownFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? errCode = freezed,
  }) {
    return _then(_$UnknownFailure(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == errCode
          ? _value.errCode
          : errCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnknownFailure extends UnknownFailure {
  const _$UnknownFailure([this.message, this.errCode]) : super._();

  @override
  final String? message;
  @override
  final String? errCode;

  @override
  String toString() {
    return 'AuthFailure.unknown(message: $message, errCode: $errCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailure &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errCode, errCode) || other.errCode == errCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, errCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureCopyWith<_$UnknownFailure> get copyWith =>
      __$$UnknownFailureCopyWithImpl<_$UnknownFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message, String? errCode) unknown,
    required TResult Function() noMessage,
    required TResult Function(SocialLoginAccount socialLoginAccount)
        accountNotExists,
    required TResult Function(String? message) network,
  }) {
    return unknown(message, errCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message, String? errCode)? unknown,
    TResult? Function()? noMessage,
    TResult? Function(SocialLoginAccount socialLoginAccount)? accountNotExists,
    TResult? Function(String? message)? network,
  }) {
    return unknown?.call(message, errCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message, String? errCode)? unknown,
    TResult Function()? noMessage,
    TResult Function(SocialLoginAccount socialLoginAccount)? accountNotExists,
    TResult Function(String? message)? network,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message, errCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(NoMessageFailure value) noMessage,
    required TResult Function(AccountNotExists value) accountNotExists,
    required TResult Function(NetworkFailure value) network,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(NoMessageFailure value)? noMessage,
    TResult? Function(AccountNotExists value)? accountNotExists,
    TResult? Function(NetworkFailure value)? network,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(AccountNotExists value)? accountNotExists,
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
  const factory UnknownFailure([final String? message, final String? errCode]) =
      _$UnknownFailure;
  const UnknownFailure._() : super._();

  String? get message;
  String? get errCode;
  @JsonKey(ignore: true)
  _$$UnknownFailureCopyWith<_$UnknownFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NoMessageFailureCopyWith<$Res> {
  factory _$$NoMessageFailureCopyWith(
          _$NoMessageFailure value, $Res Function(_$NoMessageFailure) then) =
      __$$NoMessageFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoMessageFailureCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$NoMessageFailure>
    implements _$$NoMessageFailureCopyWith<$Res> {
  __$$NoMessageFailureCopyWithImpl(
      _$NoMessageFailure _value, $Res Function(_$NoMessageFailure) _then)
      : super(_value, _then);
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
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoMessageFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message, String? errCode) unknown,
    required TResult Function() noMessage,
    required TResult Function(SocialLoginAccount socialLoginAccount)
        accountNotExists,
    required TResult Function(String? message) network,
  }) {
    return noMessage();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message, String? errCode)? unknown,
    TResult? Function()? noMessage,
    TResult? Function(SocialLoginAccount socialLoginAccount)? accountNotExists,
    TResult? Function(String? message)? network,
  }) {
    return noMessage?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message, String? errCode)? unknown,
    TResult Function()? noMessage,
    TResult Function(SocialLoginAccount socialLoginAccount)? accountNotExists,
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
    required TResult Function(AccountNotExists value) accountNotExists,
    required TResult Function(NetworkFailure value) network,
  }) {
    return noMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(NoMessageFailure value)? noMessage,
    TResult? Function(AccountNotExists value)? accountNotExists,
    TResult? Function(NetworkFailure value)? network,
  }) {
    return noMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(AccountNotExists value)? accountNotExists,
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
abstract class _$$AccountNotExistsCopyWith<$Res> {
  factory _$$AccountNotExistsCopyWith(
          _$AccountNotExists value, $Res Function(_$AccountNotExists) then) =
      __$$AccountNotExistsCopyWithImpl<$Res>;
  @useResult
  $Res call({SocialLoginAccount socialLoginAccount});
}

/// @nodoc
class __$$AccountNotExistsCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$AccountNotExists>
    implements _$$AccountNotExistsCopyWith<$Res> {
  __$$AccountNotExistsCopyWithImpl(
      _$AccountNotExists _value, $Res Function(_$AccountNotExists) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? socialLoginAccount = null,
  }) {
    return _then(_$AccountNotExists(
      null == socialLoginAccount
          ? _value.socialLoginAccount
          : socialLoginAccount // ignore: cast_nullable_to_non_nullable
              as SocialLoginAccount,
    ));
  }
}

/// @nodoc

class _$AccountNotExists extends AccountNotExists {
  const _$AccountNotExists(this.socialLoginAccount) : super._();

  @override
  final SocialLoginAccount socialLoginAccount;

  @override
  String toString() {
    return 'AuthFailure.accountNotExists(socialLoginAccount: $socialLoginAccount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountNotExists &&
            (identical(other.socialLoginAccount, socialLoginAccount) ||
                other.socialLoginAccount == socialLoginAccount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, socialLoginAccount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountNotExistsCopyWith<_$AccountNotExists> get copyWith =>
      __$$AccountNotExistsCopyWithImpl<_$AccountNotExists>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message, String? errCode) unknown,
    required TResult Function() noMessage,
    required TResult Function(SocialLoginAccount socialLoginAccount)
        accountNotExists,
    required TResult Function(String? message) network,
  }) {
    return accountNotExists(socialLoginAccount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message, String? errCode)? unknown,
    TResult? Function()? noMessage,
    TResult? Function(SocialLoginAccount socialLoginAccount)? accountNotExists,
    TResult? Function(String? message)? network,
  }) {
    return accountNotExists?.call(socialLoginAccount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message, String? errCode)? unknown,
    TResult Function()? noMessage,
    TResult Function(SocialLoginAccount socialLoginAccount)? accountNotExists,
    TResult Function(String? message)? network,
    required TResult orElse(),
  }) {
    if (accountNotExists != null) {
      return accountNotExists(socialLoginAccount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnknownFailure value) unknown,
    required TResult Function(NoMessageFailure value) noMessage,
    required TResult Function(AccountNotExists value) accountNotExists,
    required TResult Function(NetworkFailure value) network,
  }) {
    return accountNotExists(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(NoMessageFailure value)? noMessage,
    TResult? Function(AccountNotExists value)? accountNotExists,
    TResult? Function(NetworkFailure value)? network,
  }) {
    return accountNotExists?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(AccountNotExists value)? accountNotExists,
    TResult Function(NetworkFailure value)? network,
    required TResult orElse(),
  }) {
    if (accountNotExists != null) {
      return accountNotExists(this);
    }
    return orElse();
  }
}

abstract class AccountNotExists extends AuthFailure {
  const factory AccountNotExists(final SocialLoginAccount socialLoginAccount) =
      _$AccountNotExists;
  const AccountNotExists._() : super._();

  SocialLoginAccount get socialLoginAccount;
  @JsonKey(ignore: true)
  _$$AccountNotExistsCopyWith<_$AccountNotExists> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkFailureCopyWith<$Res> {
  factory _$$NetworkFailureCopyWith(
          _$NetworkFailure value, $Res Function(_$NetworkFailure) then) =
      __$$NetworkFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$NetworkFailureCopyWithImpl<$Res>
    extends _$AuthFailureCopyWithImpl<$Res, _$NetworkFailure>
    implements _$$NetworkFailureCopyWith<$Res> {
  __$$NetworkFailureCopyWithImpl(
      _$NetworkFailure _value, $Res Function(_$NetworkFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$NetworkFailure(
      freezed == message
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
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureCopyWith<_$NetworkFailure> get copyWith =>
      __$$NetworkFailureCopyWithImpl<_$NetworkFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message, String? errCode) unknown,
    required TResult Function() noMessage,
    required TResult Function(SocialLoginAccount socialLoginAccount)
        accountNotExists,
    required TResult Function(String? message) network,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message, String? errCode)? unknown,
    TResult? Function()? noMessage,
    TResult? Function(SocialLoginAccount socialLoginAccount)? accountNotExists,
    TResult? Function(String? message)? network,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message, String? errCode)? unknown,
    TResult Function()? noMessage,
    TResult Function(SocialLoginAccount socialLoginAccount)? accountNotExists,
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
    required TResult Function(AccountNotExists value) accountNotExists,
    required TResult Function(NetworkFailure value) network,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnknownFailure value)? unknown,
    TResult? Function(NoMessageFailure value)? noMessage,
    TResult? Function(AccountNotExists value)? accountNotExists,
    TResult? Function(NetworkFailure value)? network,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnknownFailure value)? unknown,
    TResult Function(NoMessageFailure value)? noMessage,
    TResult Function(AccountNotExists value)? accountNotExists,
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
  const factory NetworkFailure([final String? message]) = _$NetworkFailure;
  const NetworkFailure._() : super._();

  String? get message;
  @JsonKey(ignore: true)
  _$$NetworkFailureCopyWith<_$NetworkFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
