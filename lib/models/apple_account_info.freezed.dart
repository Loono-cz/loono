// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'apple_account_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppleAccountInfo _$AppleAccountInfoFromJson(Map<String, dynamic> json) {
  return _AppleAccountInfo.fromJson(json);
}

/// @nodoc
mixin _$AppleAccountInfo {
  String get userIdentifier => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get givenName => throw _privateConstructorUsedError;
  String? get familyName => throw _privateConstructorUsedError;
  String? get identifierToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppleAccountInfoCopyWith<AppleAccountInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppleAccountInfoCopyWith<$Res> {
  factory $AppleAccountInfoCopyWith(
          AppleAccountInfo value, $Res Function(AppleAccountInfo) then) =
      _$AppleAccountInfoCopyWithImpl<$Res>;
  $Res call(
      {String userIdentifier,
      String email,
      String? givenName,
      String? familyName,
      String? identifierToken});
}

/// @nodoc
class _$AppleAccountInfoCopyWithImpl<$Res>
    implements $AppleAccountInfoCopyWith<$Res> {
  _$AppleAccountInfoCopyWithImpl(this._value, this._then);

  final AppleAccountInfo _value;
  // ignore: unused_field
  final $Res Function(AppleAccountInfo) _then;

  @override
  $Res call({
    Object? userIdentifier = freezed,
    Object? email = freezed,
    Object? givenName = freezed,
    Object? familyName = freezed,
    Object? identifierToken = freezed,
  }) {
    return _then(_value.copyWith(
      userIdentifier: userIdentifier == freezed
          ? _value.userIdentifier
          : userIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      givenName: givenName == freezed
          ? _value.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: familyName == freezed
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      identifierToken: identifierToken == freezed
          ? _value.identifierToken
          : identifierToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_AppleAccountInfoCopyWith<$Res>
    implements $AppleAccountInfoCopyWith<$Res> {
  factory _$$_AppleAccountInfoCopyWith(
          _$_AppleAccountInfo value, $Res Function(_$_AppleAccountInfo) then) =
      __$$_AppleAccountInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String userIdentifier,
      String email,
      String? givenName,
      String? familyName,
      String? identifierToken});
}

/// @nodoc
class __$$_AppleAccountInfoCopyWithImpl<$Res>
    extends _$AppleAccountInfoCopyWithImpl<$Res>
    implements _$$_AppleAccountInfoCopyWith<$Res> {
  __$$_AppleAccountInfoCopyWithImpl(
      _$_AppleAccountInfo _value, $Res Function(_$_AppleAccountInfo) _then)
      : super(_value, (v) => _then(v as _$_AppleAccountInfo));

  @override
  _$_AppleAccountInfo get _value => super._value as _$_AppleAccountInfo;

  @override
  $Res call({
    Object? userIdentifier = freezed,
    Object? email = freezed,
    Object? givenName = freezed,
    Object? familyName = freezed,
    Object? identifierToken = freezed,
  }) {
    return _then(_$_AppleAccountInfo(
      userIdentifier: userIdentifier == freezed
          ? _value.userIdentifier
          : userIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      givenName: givenName == freezed
          ? _value.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: familyName == freezed
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      identifierToken: identifierToken == freezed
          ? _value.identifierToken
          : identifierToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppleAccountInfo implements _AppleAccountInfo {
  const _$_AppleAccountInfo(
      {required this.userIdentifier,
      required this.email,
      required this.givenName,
      required this.familyName,
      required this.identifierToken});

  factory _$_AppleAccountInfo.fromJson(Map<String, dynamic> json) =>
      _$$_AppleAccountInfoFromJson(json);

  @override
  final String userIdentifier;
  @override
  final String email;
  @override
  final String? givenName;
  @override
  final String? familyName;
  @override
  final String? identifierToken;

  @override
  String toString() {
    return 'AppleAccountInfo(userIdentifier: $userIdentifier, email: $email, givenName: $givenName, familyName: $familyName, identifierToken: $identifierToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppleAccountInfo &&
            const DeepCollectionEquality()
                .equals(other.userIdentifier, userIdentifier) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.givenName, givenName) &&
            const DeepCollectionEquality()
                .equals(other.familyName, familyName) &&
            const DeepCollectionEquality()
                .equals(other.identifierToken, identifierToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userIdentifier),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(givenName),
      const DeepCollectionEquality().hash(familyName),
      const DeepCollectionEquality().hash(identifierToken));

  @JsonKey(ignore: true)
  @override
  _$$_AppleAccountInfoCopyWith<_$_AppleAccountInfo> get copyWith =>
      __$$_AppleAccountInfoCopyWithImpl<_$_AppleAccountInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppleAccountInfoToJson(
      this,
    );
  }
}

abstract class _AppleAccountInfo implements AppleAccountInfo {
  const factory _AppleAccountInfo(
      {required final String userIdentifier,
      required final String email,
      required final String? givenName,
      required final String? familyName,
      required final String? identifierToken}) = _$_AppleAccountInfo;

  factory _AppleAccountInfo.fromJson(Map<String, dynamic> json) =
      _$_AppleAccountInfo.fromJson;

  @override
  String get userIdentifier;
  @override
  String get email;
  @override
  String? get givenName;
  @override
  String? get familyName;
  @override
  String? get identifierToken;
  @override
  @JsonKey(ignore: true)
  _$$_AppleAccountInfoCopyWith<_$_AppleAccountInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
