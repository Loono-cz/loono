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
  final objects = <SimpleHealthcareProvider>[
    SimpleHealthcareProvider((b) {
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
    })
  ];
  String toJson(SimpleHealthcareProvider o) =>
      standardSerializers.toJson(SimpleHealthcareProvider.serializer, o);
  final serializedList = objects.map(toJson).toList();
  final encodedJson = utf8.encode(serializedList.toString());
  final bytesData = Uint8List.fromList(encodedJson);
  final zip = Archive()..addFile(ArchiveFile('providers.json', bytesData.lengthInBytes, bytesData));
  final zipBytesData = ZipEncoder().encode(zip)!;
  return Uint8List.fromList(zipBytesData);
}
