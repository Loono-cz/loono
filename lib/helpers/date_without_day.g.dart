// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_without_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DateWithoutDay _$$_DateWithoutDayFromJson(Map<String, dynamic> json) => _$_DateWithoutDay(
      month: $enumDecode(_$MonthsEnumMap, json['month']),
      year: json['year'] as int,
    );

Map<String, dynamic> _$$_DateWithoutDayToJson(_$_DateWithoutDay instance) => <String, dynamic>{
      'month': _$MonthsEnumMap[instance.month],
      'year': instance.year,
    };

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
