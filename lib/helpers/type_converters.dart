import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono_api/loono_api.dart'
    show ExaminationStatus, ExaminationType, Sex, SimpleHealthcareProvider, standardSerializers;
import 'package:moor/moor.dart';

class CategoryDbConverter extends TypeConverter<BuiltList<String>, String> {
  const CategoryDbConverter();

  @override
  BuiltList<String>? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    return standardSerializers.deserialize(
      jsonDecode(fromDb),
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    ) as BuiltList<String>?;
  }

  @override
  String? mapToSql(BuiltList<String>? value) {
    if (value == null) return null;
    return jsonEncode(
      standardSerializers.serialize(
        value,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      ),
    );
  }
}

class ExaminationTypeDbConverter extends TypeConverter<ExaminationType, String> {
  const ExaminationTypeDbConverter();

  @override
  ExaminationType? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    return ExaminationType.values
        .singleWhereOrNull((examinationType) => examinationType.name == fromDb);
  }

  @override
  String? mapToSql(ExaminationType? value) {
    if (value == null) return null;
    return value.name;
  }
}

class ExaminationStatusDbConverter extends TypeConverter<ExaminationStatus, String> {
  const ExaminationStatusDbConverter();

  @override
  ExaminationStatus? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    return ExaminationStatus.values
        .singleWhereOrNull((examinationStatus) => examinationStatus.name == fromDb);
  }

  @override
  String? mapToSql(ExaminationStatus? value) {
    if (value == null) return null;
    return value.name;
  }
}

class SexDbConverter extends TypeConverter<Sex, String> {
  const SexDbConverter();

  @override
  Sex? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    return Sex.values.singleWhereOrNull((sex) => sex.name == fromDb);
  }

  @override
  String? mapToSql(Sex? value) {
    if (value == null) return null;
    return value.name;
  }
}

class DateOfBirthConverter extends TypeConverter<DateWithoutDay, String> {
  const DateOfBirthConverter();

  @override
  DateWithoutDay? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    final dateTimeMap = jsonDecode(fromDb) as Map<String, dynamic>;
    return DateWithoutDay.fromJson(dateTimeMap);
  }

  @override
  String? mapToSql(DateWithoutDay? value) {
    if (value == null) return null;
    return jsonEncode(value.toJson());
  }
}


class SimpleHealthcareListConverter
    extends JsonConverter<BuiltList<SimpleHealthcareProvider>, String> {
  const SimpleHealthcareListConverter();

  @override
  BuiltList<SimpleHealthcareProvider> fromJson(String json) {
    return standardSerializers.deserialize(
          jsonDecode(json),
          specifiedType: const FullType(BuiltList, [FullType(SimpleHealthcareProvider)]),
        ) as BuiltList<SimpleHealthcareProvider>? ??
        BuiltList.of(<SimpleHealthcareProvider>[]);
  }

  @override
  String toJson(BuiltList<SimpleHealthcareProvider> object) {
    return jsonEncode(
      standardSerializers.serialize(
        object,
        specifiedType: const FullType(BuiltList, [FullType(SimpleHealthcareProvider)]),
      ),
    );
  }
}
