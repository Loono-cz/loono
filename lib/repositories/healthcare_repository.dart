// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/save_directories.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:moor/moor.dart';

enum HealtCareSyncState { started, fetching, parsing, storing, completed, error }

class HealthcareProviderRepository {
  HealthcareProviderRepository({
    required ApiService apiService,
    required DatabaseService databaseService,
  })  : _apiService = apiService,
        _db = databaseService;

  File get _providersFile =>
      File('${registry.get<SaveDirectories>().supportDir.path}/HealthcareProviders');

  final ApiService _apiService;
  final DatabaseService _db;
  static const int UPDATE_CHECK_INTERVAL_IN_DAYS = 21;

  final _streamController = StreamController<HealtCareSyncState>.broadcast();
  Stream<HealtCareSyncState> get healtcareProvidersStream => _streamController.stream;
  HealtCareSyncState? _lastStreamValue;
  HealtCareSyncState? get lastStreamValue => _lastStreamValue;

  void _emitStreamValue(HealtCareSyncState state) {
    _streamController.sink.add(state);
    _lastStreamValue = state;
    debugPrint('HEALTHCARE_PROVIDERS STREAM VALUE $state ');
  }

  /// Updates [HealthcareProviders] with new [SimpleHealthcareProvider] data if the current local
  /// data are not up to date or not fetched yet.
  ///
  /// If the data are up to date, returns cached healthcare providers data.
  Future<void> checkAndUpdateIfNeeded() async {
    await _waitForExistingUser();
    _emitStreamValue(HealtCareSyncState.started);
    final localLatestUpdateCheck = _db.users.user?.latestMapUpdateCheck;
    final localLatestUpdate = _db.users.user?.latestMapUpdate;
    final serverLatestUpdate = await _getServerLatestUpdate(localLatestUpdateCheck);
    debugPrint(
      'HEALTHCARE_PROVIDERS: LOCAL LATEST: $localLatestUpdate | SERVER LATEST: $serverLatestUpdate',
    );
    if (localLatestUpdate == null ||
        (serverLatestUpdate != null && serverLatestUpdate.isAfter(localLatestUpdate))) {
      final data = await _fetchAllProvidersData();
      if (data == null) return _emitStreamValue(HealtCareSyncState.error);
      await _storeList(data, serverLatestUpdate);
    } else {
      debugPrint('HEALTHCARE_PROVIDERS: DATA ARE UP TO DATE');
    }
    _emitStreamValue(HealtCareSyncState.completed);
  }

  Future<void> _waitForExistingUser() async {
    try {
      if (_db.users.user != null) return;
    } catch (e) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      await _waitForExistingUser();
    }
  }

  Future<DateTime?>? _getServerLatestUpdate(DateTime? localLatestUpdateCheck) async {
    final now = Date.now();
    Future<DateTime?>? serverLatestUpdateData;
    // check for a new server update if it is more than 21 days since the last check
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
    return serverLatestUpdateData;
  }

  Future<Uint8List?> _fetchAllProvidersData() async {
    _emitStreamValue(HealtCareSyncState.fetching);
    final healthcareApiResponse = await _apiService.getProvidersAll();
    // ignore: omit_local_variable_types
    final Uint8List? responseData = healthcareApiResponse.mapOrNull(
      success: (response) => response.data,
    );

    if (responseData == null) return null;
    // the response returns compressed zip file which contains serialized providers.json file
    _emitStreamValue(HealtCareSyncState.parsing);

    final result = await compute<Uint8List, Uint8List>(
      (Uint8List data) => ZipDecoder().decodeBytes(data).first.content as Uint8List,
      responseData,
    );
    return result;
  }

  Future<void> _storeList(
    Uint8List data,
    DateTime? serverLatestUpdate,
  ) async {
    _emitStreamValue(HealtCareSyncState.storing);
    await _providersFile.writeAsBytes(data);
    await _db.users.updateLatestMapServerUpdate(serverLatestUpdate ?? DateTime.now());
    await _db.users.updateLatestMapUpdateCheck(DateTime.now());
  }
}
