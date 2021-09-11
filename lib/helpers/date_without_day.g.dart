// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_without_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DateWithoutDay _$_$_DateWithoutDayFromJson(Map<String, dynamic> json) {
  return _$_DateWithoutDay(
    month: _$enumDecode(_$MonthsEnumMap, json['month']),
    year: json['year'] as int,
  );
}

Map<String, dynamic> _$_$_DateWithoutDayToJson(_$_DateWithoutDay instance) =>
    <String, dynamic>{
      'month': _$MonthsEnumMap[instance.month],
      'year': instance.year,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$MonthsEnumMap = {
  Months.january: 'january',
  Months.february: 'february',
  Months.march: 'march',
  Months.april: 'april',
  Months.may: 'may',
  Months.june: 'june',
  Months.july: 'july',
  Months.august: 'august',
  Months.september: 'september',
  Months.october: 'october',
  Months.november: 'november',
  Months.december: 'december',
};
