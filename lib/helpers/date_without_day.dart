import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_without_day.freezed.dart';
part 'date_without_day.g.dart';

enum Months {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

Months monthFromInt(int i) => Months.values[i - 1];

@freezed
class DateWithoutDay with _$DateWithoutDay {
  factory DateWithoutDay({
    required Months month,
    required int year,
  }) = _DateWithoutDay;

  factory DateWithoutDay.fromJson(Map<String, dynamic> json) => _$DateWithoutDayFromJson(json);
}
