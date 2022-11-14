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
        ExaminationStatus,
        ExaminationType,
        Sex,
        SimpleHealthcareProvider,
        standardSerializers;

class CategoryDbConverter extends TypeConverter<BuiltList<String>, String> {
  const CategoryDbConverter();

  @override
  BuiltList<String> fromSql(String fromDb) {
    return standardSerializers.deserialize(
      jsonDecode(fromDb),
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    ) as BuiltList<String>;
  }

  @override
  String toSql(BuiltList<String> value) {
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
  ExaminationType fromSql(String fromDb) {
    return ExaminationType.values.singleWhere((examinationType) => examinationType.name == fromDb);
  }

  @override
  String toSql(ExaminationType value) {
    return value.name;
  }
}

class ExaminationStatusDbConverter extends TypeConverter<ExaminationStatus, String> {
  const ExaminationStatusDbConverter();

  @override
  ExaminationStatus fromSql(String fromDb) {
    return ExaminationStatus.values
        .singleWhere((examinationStatus) => examinationStatus.name == fromDb);
  }

  @override
  String toSql(ExaminationStatus value) {
    return value.name;
  }
}

class SexDbConverter extends TypeConverter<Sex, String> {
  const SexDbConverter();

  @override
  Sex fromSql(String fromDb) {
    return Sex.values.singleWhere((sex) => sex.name == fromDb);
  }

  @override
  String toSql(Sex value) {
    return value.name;
  }
}

class DateOfBirthDbConverter extends TypeConverter<DateWithoutDay, String> {
  const DateOfBirthDbConverter();

  @override
  DateWithoutDay fromSql(String fromDb) {
    final dateTimeMap = jsonDecode(fromDb) as Map<String, dynamic>;
    return DateWithoutDay.fromJson(dateTimeMap);
  }

  @override
  String toSql(DateWithoutDay value) {
    return jsonEncode(value.toJson());
  }
}

class BadgeListDbConverter extends TypeConverter<BuiltList<Badge>, String> {
  const BadgeListDbConverter();

  @override
  BuiltList<Badge> fromSql(String fromDb) {
    return standardSerializers.deserialize(
          jsonDecode(fromDb),
          specifiedType: const FullType(BuiltList, [FullType(Badge)]),
        ) as BuiltList<Badge>? ??
        BuiltList.of(<Badge>[]);
  }

  @override
  String toSql(BuiltList<Badge> value) {
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
  List<SearchResult> fromSql(String fromDb) {
    final list = (json.decode(fromDb) as Iterable<dynamic>).map(
      (dynamic e) => SearchResult.fromJson(e as Map<String, dynamic>),
    );
    return list.toList();
  }

  @override
  String toSql(List<SearchResult> value) {
    return jsonEncode(value.map((e) => e.toJson()).toList()).toString();
  }
}

class SimpleHealthcareProviderListConverter
    extends TypeConverter<List<SimpleHealthcareProvider>, String> {
  const SimpleHealthcareProviderListConverter();

  @override
  List<SimpleHealthcareProvider> fromSql(String fromDb) {
    final list = (json.decode(fromDb) as Iterable<dynamic>).map(
      (dynamic e) => standardSerializers.fromJson(
        SimpleHealthcareProvider.serializer,
        e as String,
      ),
    );
    return list.whereType<SimpleHealthcareProvider>().toList();
  }

  @override
  String toSql(List<SimpleHealthcareProvider> value) {
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
