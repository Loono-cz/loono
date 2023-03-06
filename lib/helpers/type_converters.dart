import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:drift/drift.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/models/apple_account_info.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono_api/loono_api.dart'
    show
        Badge,
        ExaminationCategoryType,
        ExaminationStatus,
        ExaminationType,
        Sex,
        SimpleHealthcareProvider,
        standardSerializers;

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
    return ExaminationType.values.singleWhere((examinationType) => examinationType.name == fromDb);
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
        .singleWhere((examinationStatus) => examinationStatus.name == fromDb);
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
    return Sex.values.singleWhere((sex) => sex.name == fromDb);
  }

  @override
  String? mapToSql(Sex? value) {
    if (value == null) return null;
    return value.name;
  }
}

class DateOfBirthDbConverter extends TypeConverter<DateWithoutDay, String> {
  const DateOfBirthDbConverter();

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

class BadgeListDbConverter extends TypeConverter<BuiltList<Badge>, String> {
  const BadgeListDbConverter();

  @override
  BuiltList<Badge>? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    return standardSerializers.deserialize(
          jsonDecode(fromDb),
          specifiedType: const FullType(BuiltList, [FullType(Badge)]),
        ) as BuiltList<Badge>? ??
        BuiltList.of(<Badge>[]);
  }

  @override
  String? mapToSql(BuiltList<Badge>? value) {
    if (value == null) return null;
    return jsonEncode(
      standardSerializers.serialize(
        value,
        specifiedType: const FullType(BuiltList, [FullType(Badge)]),
      ),
    );
  }
}

class SimpleHealthcareProviderJsonConverter
    implements JsonConverter<SimpleHealthcareProvider?, String> {
  const SimpleHealthcareProviderJsonConverter();

  @override
  SimpleHealthcareProvider? fromJson(String json) {
    return standardSerializers.fromJson(SimpleHealthcareProvider.serializer, json);
  }

  @override
  String toJson(SimpleHealthcareProvider? object) {
    return standardSerializers.toJson(SimpleHealthcareProvider.serializer, object);
  }
}

class SearchHistoryDbConverter extends TypeConverter<List<SearchResult>, String> {
  const SearchHistoryDbConverter();

  @override
  List<SearchResult>? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    final list = (json.decode(fromDb) as Iterable<dynamic>).map(
      (dynamic e) => SearchResult.fromJson(e as Map<String, dynamic>),
    );
    return list.toList();
  }

  @override
  String? mapToSql(List<SearchResult>? value) {
    if (value == null) return null;
    return jsonEncode(value.map((e) => e.toJson()).toList()).toString();
  }
}

class SimpleHealthcareProviderListConverter
    extends TypeConverter<List<SimpleHealthcareProvider>, String> {
  const SimpleHealthcareProviderListConverter();

  @override
  List<SimpleHealthcareProvider>? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    final list = (json.decode(fromDb) as Iterable<dynamic>).map(
      (dynamic e) => standardSerializers.fromJson(
        SimpleHealthcareProvider.serializer,
        e as String,
      ),
    );
    return list.whereType<SimpleHealthcareProvider>().toList();
  }

  @override
  String? mapToSql(List<SimpleHealthcareProvider>? value) {
    if (value == null) return null;
    return jsonEncode(
      value.map((e) => standardSerializers.toJson(SimpleHealthcareProvider.serializer, e)).toList(),
    ).toString();
  }
}

class AppleAccountInfoListJsonConverter implements JsonConverter<List<AppleAccountInfo>, String> {
  const AppleAccountInfoListJsonConverter();

  @override
  List<AppleAccountInfo> fromJson(String json) {
    final list = (jsonDecode(json) as Iterable<dynamic>)
        .map((dynamic e) => AppleAccountInfo.fromJson(e as Map<String, dynamic>));
    return list.toList();
  }

  @override
  String toJson(List<AppleAccountInfo> objects) {
    return jsonEncode(objects.map((e) => e.toJson()).toList()).toString();
  }
}

class ExaminationCategoryTypeDbConverter extends TypeConverter<ExaminationCategoryType, String> {
  const ExaminationCategoryTypeDbConverter();

  @override
  ExaminationCategoryType? mapToDart(String? fromDb) {
    if (fromDb == null) return ExaminationCategoryType.MANDATORY;
    return ExaminationCategoryType.values
        .singleWhere((examinationCategoryType) => examinationCategoryType.name == fromDb);
  }

  @override
  String? mapToSql(ExaminationCategoryType? value) {
    if (value == null) return null;
    return value.name;
  }
}
