import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:loono_api/loono_api.dart' show serializers;
import 'package:moor/moor.dart';

class CategoryConverter extends TypeConverter<BuiltList<String>, String> {
  const CategoryConverter();

  @override
  BuiltList<String>? mapToDart(String? fromDb) {
    if (fromDb == null) return null;
    return serializers.deserialize(
          jsonDecode(fromDb),
          specifiedType: const FullType(BuiltList, [FullType(String)]),
        ) as BuiltList<String>? ??
        BuiltList.from(<String>[]);
  }

  @override
  String? mapToSql(BuiltList<String>? value) {
    if (value == null) return null;
    return jsonEncode(
      serializers.serialize(
        value,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      ),
    );
  }
}
