import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loono_api/loono_api.dart' show SimpleHealthcareProvider, standardSerializers;
import 'package:moor/moor.dart';

class CategoryConverter extends TypeConverter<BuiltList<String>, String> {
  const CategoryConverter();

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
