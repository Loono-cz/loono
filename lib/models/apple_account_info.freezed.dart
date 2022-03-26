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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppleAccountInfo _$AppleAccountInfoFromJson(Map<String, dynamic> json) {
  return _AppleAccountInfo.fromJson(json);
}

/// @nodoc
class _$AppleAccountInfoTearOff {
  const _$AppleAccountInfoTearOff();

  _AppleAccountInfo call(
      {required String userIdentifier,
      required String email,
      required String? givenName,
      required String? familyName}) {
    return _AppleAccountInfo(
      userIdentifier: userIdentifier,
      email: email,
      givenName: givenName,
      familyName: familyName,
    );
  }

  AppleAccountInfo fromJson(Map<String, Object?> json) {
    return AppleAccountInfo.fromJson(json);
  }
}

/// @nodoc
const $AppleAccountInfo = _$AppleAccountInfoTearOff();

/// @nodoc
mixin _$AppleAccountInfo {
  String get userIdentifier => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get givenName => throw _privateConstructorUsedError;
  String? get familyName => throw _privateConstructorUsedError;

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
      String? familyName});
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
    ));
  }
}

/// @nodoc
abstract class _$AppleAccountInfoCopyWith<$Res>
    implements $AppleAccountInfoCopyWith<$Res> {
  factory _$AppleAccountInfoCopyWith(
          _AppleAccountInfo value, $Res Function(_AppleAccountInfo) then) =
      __$AppleAccountInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String userIdentifier,
      String email,
      String? givenName,
      String? familyName});
}

/// @nodoc
class __$AppleAccountInfoCopyWithImpl<$Res>
    extends _$AppleAccountInfoCopyWithImpl<$Res>
    implements _$AppleAccountInfoCopyWith<$Res> {
  __$AppleAccountInfoCopyWithImpl(
      _AppleAccountInfo _value, $Res Function(_AppleAccountInfo) _then)
      : super(_value, (v) => _then(v as _AppleAccountInfo));

  @override
  _AppleAccountInfo get _value => super._value as _AppleAccountInfo;

  @override
  $Res call({
    Object? userIdentifier = freezed,
    Object? email = freezed,
    Object? givenName = freezed,
    Object? familyName = freezed,
  }) {
    return _then(_AppleAccountInfo(
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
      required this.familyName});

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
  String toString() {
    return 'AppleAccountInfo(userIdentifier: $userIdentifier, email: $email, givenName: $givenName, familyName: $familyName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppleAccountInfo &&
            const DeepCollectionEquality()
                .equals(other.userIdentifier, userIdentifier) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.givenName, givenName) &&
            const DeepCollectionEquality()
                .equals(other.familyName, familyName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userIdentifier),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(givenName),
      const DeepCollectionEquality().hash(familyName));

  @JsonKey(ignore: true)
  @override
  _$AppleAccountInfoCopyWith<_AppleAccountInfo> get copyWith =>
      __$AppleAccountInfoCopyWithImpl<_AppleAccountInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppleAccountInfoToJson(this);
  }
}

abstract class _AppleAccountInfo implements AppleAccountInfo {
  const factory _AppleAccountInfo(
      {required String userIdentifier,
      required String email,
      required String? givenName,
      required String? familyName}) = _$_AppleAccountInfo;

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
  @JsonKey(ignore: true)
  _$AppleAccountInfoCopyWith<_AppleAccountInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
