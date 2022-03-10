import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:built_collection/built_collection.dart';
import 'package:drift/drift.dart';
import 'package:loono_api/loono_api.dart';

// ignore: non_constant_identifier_names
final Uint8List HEALTHCARE_PROVIDER_ENCODED = _encodedProvider;

// TODO: expand this to be able to create multiple healthcare providers
Uint8List get _encodedProvider {
  final object = SimpleHealthcareProvider((b) {
    b
      ..locationId = 1
      ..institutionId = 1
      ..title = 'title'
      ..city = 'city'
      ..postalCode = '1234'
      ..houseNumber = '123'
      ..lat = 0.005
      ..lng = 0.002
      ..category = BuiltList.of(<String>[]).toBuilder();
  });
  final json = standardSerializers.toJson(SimpleHealthcareProvider.serializer, object);
  final encodeJson = utf8.encode(json);
  final bytes = Uint8List.fromList(encodeJson);
  final zip = Archive()..addFile(ArchiveFile('providers.json', bytes.lengthInBytes, bytes));
  final encodedZip = ZipEncoder().encode(zip)!;
  return Uint8List.fromList(encodedZip);
}
