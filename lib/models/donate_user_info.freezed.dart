// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'donate_user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DonateUserInfo _$DonateUserInfoFromJson(Map<String, dynamic> json) {
  return _DonateUserInfo.fromJson(json);
}

/// @nodoc
mixin _$DonateUserInfo {
  DateTime get lastOpened => throw _privateConstructorUsedError;
  bool get showNotification => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DonateUserInfoCopyWith<DonateUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DonateUserInfoCopyWith<$Res> {
  factory $DonateUserInfoCopyWith(
          DonateUserInfo value, $Res Function(DonateUserInfo) then) =
      _$DonateUserInfoCopyWithImpl<$Res>;
  $Res call({DateTime lastOpened, bool showNotification});
}

/// @nodoc
class _$DonateUserInfoCopyWithImpl<$Res>
    implements $DonateUserInfoCopyWith<$Res> {
  _$DonateUserInfoCopyWithImpl(this._value, this._then);

  final DonateUserInfo _value;
  // ignore: unused_field
  final $Res Function(DonateUserInfo) _then;

  @override
  $Res call({
    Object? lastOpened = freezed,
    Object? showNotification = freezed,
  }) {
    return _then(_value.copyWith(
      lastOpened: lastOpened == freezed
          ? _value.lastOpened
          : lastOpened // ignore: cast_nullable_to_non_nullable
              as DateTime,
      showNotification: showNotification == freezed
          ? _value.showNotification
          : showNotification // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_DonateUserInfoCopyWith<$Res>
    implements $DonateUserInfoCopyWith<$Res> {
  factory _$$_DonateUserInfoCopyWith(
          _$_DonateUserInfo value, $Res Function(_$_DonateUserInfo) then) =
      __$$_DonateUserInfoCopyWithImpl<$Res>;
  @override
  $Res call({DateTime lastOpened, bool showNotification});
}

/// @nodoc
class __$$_DonateUserInfoCopyWithImpl<$Res>
    extends _$DonateUserInfoCopyWithImpl<$Res>
    implements _$$_DonateUserInfoCopyWith<$Res> {
  __$$_DonateUserInfoCopyWithImpl(
      _$_DonateUserInfo _value, $Res Function(_$_DonateUserInfo) _then)
      : super(_value, (v) => _then(v as _$_DonateUserInfo));

  @override
  _$_DonateUserInfo get _value => super._value as _$_DonateUserInfo;

  @override
  $Res call({
    Object? lastOpened = freezed,
    Object? showNotification = freezed,
  }) {
    return _then(_$_DonateUserInfo(
      lastOpened: lastOpened == freezed
          ? _value.lastOpened
          : lastOpened // ignore: cast_nullable_to_non_nullable
              as DateTime,
      showNotification: showNotification == freezed
          ? _value.showNotification
          : showNotification // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DonateUserInfo implements _DonateUserInfo {
  const _$_DonateUserInfo(
      {required this.lastOpened, required this.showNotification});

  factory _$_DonateUserInfo.fromJson(Map<String, dynamic> json) =>
      _$$_DonateUserInfoFromJson(json);

  @override
  final DateTime lastOpened;
  @override
  final bool showNotification;

  @override
  String toString() {
    return 'DonateUserInfo(lastOpened: $lastOpened, showNotification: $showNotification)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DonateUserInfo &&
            const DeepCollectionEquality()
                .equals(other.lastOpened, lastOpened) &&
            const DeepCollectionEquality()
                .equals(other.showNotification, showNotification));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(lastOpened),
      const DeepCollectionEquality().hash(showNotification));

  @JsonKey(ignore: true)
  @override
  _$$_DonateUserInfoCopyWith<_$_DonateUserInfo> get copyWith =>
      __$$_DonateUserInfoCopyWithImpl<_$_DonateUserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DonateUserInfoToJson(
      this,
    );
  }
}

abstract class _DonateUserInfo implements DonateUserInfo {
  const factory _DonateUserInfo(
      {required final DateTime lastOpened,
      required final bool showNotification}) = _$_DonateUserInfo;

  factory _DonateUserInfo.fromJson(Map<String, dynamic> json) =
      _$_DonateUserInfo.fromJson;

  @override
  DateTime get lastOpened;
  @override
  bool get showNotification;
  @override
  @JsonKey(ignore: true)
  _$$_DonateUserInfoCopyWith<_$_DonateUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
