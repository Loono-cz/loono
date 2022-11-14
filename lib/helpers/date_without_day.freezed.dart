// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'date_without_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DateWithoutDay _$DateWithoutDayFromJson(Map<String, dynamic> json) {
  return _DateWithoutDay.fromJson(json);
}

/// @nodoc
mixin _$DateWithoutDay {
  Months get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DateWithoutDayCopyWith<DateWithoutDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateWithoutDayCopyWith<$Res> {
  factory $DateWithoutDayCopyWith(
          DateWithoutDay value, $Res Function(DateWithoutDay) then) =
      _$DateWithoutDayCopyWithImpl<$Res, DateWithoutDay>;
  @useResult
  $Res call({Months month, int year});
}

/// @nodoc
class _$DateWithoutDayCopyWithImpl<$Res, $Val extends DateWithoutDay>
    implements $DateWithoutDayCopyWith<$Res> {
  _$DateWithoutDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? year = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as Months,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DateWithoutDayCopyWith<$Res>
    implements $DateWithoutDayCopyWith<$Res> {
  factory _$$_DateWithoutDayCopyWith(
          _$_DateWithoutDay value, $Res Function(_$_DateWithoutDay) then) =
      __$$_DateWithoutDayCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Months month, int year});
}

/// @nodoc
class __$$_DateWithoutDayCopyWithImpl<$Res>
    extends _$DateWithoutDayCopyWithImpl<$Res, _$_DateWithoutDay>
    implements _$$_DateWithoutDayCopyWith<$Res> {
  __$$_DateWithoutDayCopyWithImpl(
      _$_DateWithoutDay _value, $Res Function(_$_DateWithoutDay) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? year = null,
  }) {
    return _then(_$_DateWithoutDay(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as Months,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DateWithoutDay implements _DateWithoutDay {
  _$_DateWithoutDay({required this.month, required this.year});

  factory _$_DateWithoutDay.fromJson(Map<String, dynamic> json) =>
      _$$_DateWithoutDayFromJson(json);

  @override
  final Months month;
  @override
  final int year;

  @override
  String toString() {
    return 'DateWithoutDay(month: $month, year: $year)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DateWithoutDay &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, month, year);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DateWithoutDayCopyWith<_$_DateWithoutDay> get copyWith =>
      __$$_DateWithoutDayCopyWithImpl<_$_DateWithoutDay>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DateWithoutDayToJson(
      this,
    );
  }
}

abstract class _DateWithoutDay implements DateWithoutDay {
  factory _DateWithoutDay(
      {required final Months month,
      required final int year}) = _$_DateWithoutDay;

  factory _DateWithoutDay.fromJson(Map<String, dynamic> json) =
      _$_DateWithoutDay.fromJson;

  @override
  Months get month;
  @override
  int get year;
  @override
  @JsonKey(ignore: true)
  _$$_DateWithoutDayCopyWith<_$_DateWithoutDay> get copyWith =>
      throw _privateConstructorUsedError;
}
