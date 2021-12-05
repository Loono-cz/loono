import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/helpers/healthcare_provider_type_converters.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono_api/loono_api.dart';
import 'package:moor/moor.dart';

class HealthcareProviderRepository {
  HealthcareProviderRepository({
    required DatabaseService databaseService,
  }) : _db = databaseService;

  final DatabaseService _db;

  final _api = LoonoApi();

  /// Updates [HealthcareProviders] with new [SimpleHealthcareProvider] data if the current local
  /// data are not up to date or not fetched yet.
  Future<List<HealthcareProvider>> checkAndUpdate() async {
    final localLatestUpdate = _db.users.user?.mapDateUpdated;
    Response<HealthcareProviderLastUpdate>? serverLatestUpdateResponse;
    try {
      serverLatestUpdateResponse = await _api.getProvidersApi().getProvidersLastupdate();
    } catch (e) {
      debugPrint(e.toString());
    }
    final serverLatestUpdateDate = serverLatestUpdateResponse?.data?.lastUpdate;
    final serverFormat = DateFormat('yyyy-M-d');

    // server data are updated on the 2nd day of each month
    // update if outdated or data missing
    debugPrint('LOCAL LATEST: $localLatestUpdate\nSERVER LATEST: $serverLatestUpdateDate');
    if (localLatestUpdate == null ||
        (serverLatestUpdateDate != null &&
            serverFormat.parse(serverLatestUpdateDate).isAfter(localLatestUpdate))) {
      debugPrint('UPDATING MAPS...');
      final BuiltList<SimpleHealthcareProvider>? list = await _getAllHealthcareProvidersData();
      if (list == null) return Future.error('Could not fetch the data');
      await _db.healthcareProviders.updateAllData(list);
      await _db.users.updateMapDateUpdated(serverLatestUpdateDate == null
          ? DateTime.now()
          : serverFormat.parse(serverLatestUpdateDate));
    } else {
      debugPrint('MAPS ARE UP TO DATE');
    }
    return _db.healthcareProviders.getAll();
  }

  Future<BuiltList<SimpleHealthcareProvider>?> _getAllHealthcareProvidersData() async {
    final Response<Uint8List>? apiData;

    try {
      apiData = await _api.getProvidersApi().getProvidersAll();
    } on DioError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }

    final Uint8List? responseData = apiData.data;
    if (responseData == null) return null;

    // the response returns compressed zip file which contains serialized providers.json file
    final archive = ZipDecoder().decodeBytes(responseData);
    debugPrint(archive.toString());

    BuiltList<SimpleHealthcareProvider>? list;
    try {
      final jsonFile = archive.files.first.content as Uint8List;
      final content = utf8.decode(jsonFile);
      list = const SimpleHealthcareListConverter().fromJson(content);
    } catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  Stream<List<HealthcareProvider>> searchByCity(String query) {
    return _db.healthcareProviders.searchByCity(query);
  }
}
