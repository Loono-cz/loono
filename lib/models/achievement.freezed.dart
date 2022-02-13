// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'achievement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Achievement _$AchievementFromJson(Map<String, dynamic> json) {
  return _Achievement.fromJson(json);
}

/// @nodoc
class _$AchievementTearOff {
  const _$AchievementTearOff();

  _Achievement call({required String id, int points = 200}) {
    return _Achievement(
      id: id,
      points: points,
    );
  }

  Achievement fromJson(Map<String, Object?> json) {
    return Achievement.fromJson(json);
  }
}

/// @nodoc
const $Achievement = _$AchievementTearOff();

/// @nodoc
mixin _$Achievement {
  String get id => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AchievementCopyWith<Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementCopyWith<$Res> {
  factory $AchievementCopyWith(
          Achievement value, $Res Function(Achievement) then) =
      _$AchievementCopyWithImpl<$Res>;
  $Res call({String id, int points});
}

/// @nodoc
class _$AchievementCopyWithImpl<$Res> implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._value, this._then);

  final Achievement _value;
  // ignore: unused_field
  final $Res Function(Achievement) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? points = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$AchievementCopyWith<$Res>
    implements $AchievementCopyWith<$Res> {
  factory _$AchievementCopyWith(
          _Achievement value, $Res Function(_Achievement) then) =
      __$AchievementCopyWithImpl<$Res>;
  @override
  $Res call({String id, int points});
}

/// @nodoc
class __$AchievementCopyWithImpl<$Res> extends _$AchievementCopyWithImpl<$Res>
    implements _$AchievementCopyWith<$Res> {
  __$AchievementCopyWithImpl(
      _Achievement _value, $Res Function(_Achievement) _then)
      : super(_value, (v) => _then(v as _Achievement));

  @override
  _Achievement get _value => super._value as _Achievement;

  @override
  $Res call({
    Object? id = freezed,
    Object? points = freezed,
  }) {
    return _then(_Achievement(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Achievement implements _Achievement {
  _$_Achievement({required this.id, this.points = 200});

  factory _$_Achievement.fromJson(Map<String, dynamic> json) =>
      _$$_AchievementFromJson(json);

  @override
  final String id;
  @JsonKey()
  @override
  final int points;

  @override
  String toString() {
    return 'Achievement(id: $id, points: $points)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Achievement &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.points, points));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(points));

  @JsonKey(ignore: true)
  @override
  _$AchievementCopyWith<_Achievement> get copyWith =>
      __$AchievementCopyWithImpl<_Achievement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AchievementToJson(this);
  }
}

abstract class _Achievement implements Achievement {
  factory _Achievement({required String id, int points}) = _$_Achievement;

  factory _Achievement.fromJson(Map<String, dynamic> json) =
      _$_Achievement.fromJson;

  @override
  String get id;
  @override
  int get points;
  @override
  @JsonKey(ignore: true)
  _$AchievementCopyWith<_Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}
