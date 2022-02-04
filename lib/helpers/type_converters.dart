import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono_api/loono_api.dart'
    show ExaminationTypeEnum, Sex, SimpleHealthcareProvider, standardSerializers;
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

class ExaminationTypeEnumDbConverter extends TypeConverter<ExaminationTypeEnum, String> {
  const ExaminationTypeEnumDbConverter();

  @override
  ExaminationTypeEnum? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    return ExaminationTypeEnum.values
        .singleWhereOrNull((examinationType) => describeEnum(examinationType) == fromDb);
  }

  @override
  String? mapToSql(ExaminationTypeEnum? value) {
    if (value == null) return null;
    return describeEnum(value);
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
