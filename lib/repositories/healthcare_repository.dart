// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:loono/helpers/type_converters.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono_api/loono_api.dart';
import 'package:moor/moor.dart';

class HealthcareProviderRepository {
  const HealthcareProviderRepository({
    required ApiService apiService,
    required DatabaseService databaseService,
  })  : _apiService = apiService,
        _db = databaseService;

  final ApiService _apiService;
  final DatabaseService _db;

  static const int UPDATE_CHECK_INTERVAL_IN_DAYS = 21;

  /// Updates [HealthcareProviders] with new [SimpleHealthcareProvider] data if the current local
  /// data are not up to date or not fetched yet.
  ///
  /// If the data are up to date, returns cached healthcare providers data.
  Future<List<HealthcareProvider>> checkAndUpdateIfNeeded() async {
    final now = Date.now();
    final localLatestUpdateCheck = _db.users.user?.latestMapUpdateCheck;
    final localLatestUpdate = _db.users.user?.latestMapUpdate;

    // check for a new server update if it is more than 21 days since the last check
    Future<DateTime?>? serverLatestUpdateData;
    if (localLatestUpdateCheck != null &&
        now.toDateTime().difference(localLatestUpdateCheck).inDays.abs() >
            UPDATE_CHECK_INTERVAL_IN_DAYS) {
      debugPrint('HEALTHCARE_PROVIDERS: IT IS MORE THAN 21 DAYS SINCE LATEST UPDATE DATA CHECK');
      // server data are updated usually on the 2nd day month of each month
      final serverLatestUpdateResponse = await _apiService.getProvidersLastUpdate();
      serverLatestUpdateData = serverLatestUpdateResponse.map(
        success: (response) async {
          debugPrint('HEALTHCARE_PROVIDERS: SERVER UPDATE CHECK WAS SUCCESSFUL');
          await _db.users.updateLatestMapUpdateCheck(now.toDateTime());
          return response.data.lastUpdate.toDateTime();
        },
        failure: (_) async {
          // API update check was unsuccessful, try the next day
          debugPrint('HEALTHCARE_PROVIDERS: SERVER UPDATE CHECK WAS UNSUCCESSFUL');
          await _db.users
              .updateLatestMapUpdateCheck(now.toDateTime().subtract(const Duration(days: 19)));
          return null;
        },
      );
    }

    final serverLatestUpdate = await serverLatestUpdateData;

    // update if data are outdated or completely missing
    debugPrint(
        'HEALTHCARE_PROVIDERS: LOCAL LATEST: $localLatestUpdate --- SERVER LATEST: $serverLatestUpdate');
    if (localLatestUpdate == null ||
        (serverLatestUpdate != null && serverLatestUpdate.isAfter(localLatestUpdate))) {
      debugPrint('HEALTHCARE_PROVIDERS: UPDATING DATA...');
      final BuiltList<SimpleHealthcareProvider>? list = await _fetchAllProvidersData();
      if (list == null) return Future.error('Could not fetch the data');
      await _db.healthcareProviders.updateAllData(list);
      await _db.users.updateLatestMapServerUpdate(serverLatestUpdate ?? now.toDateTime());
      await _db.users.updateLatestMapUpdateCheck(now.toDateTime());
    } else {
      debugPrint('HEALTHCARE_PROVIDERS: DATA ARE UP TO DATE');
    }
    return _db.healthcareProviders.getAll();
  }

  Future<BuiltList<SimpleHealthcareProvider>?> _fetchAllProvidersData() async {
    final healthcareApiResponse = await _apiService.getProvidersAll();
    final Uint8List? responseData = healthcareApiResponse.mapOrNull(
      success: (response) => response.data,
    );
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
}
