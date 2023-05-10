// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:loono/services/api_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/save_directories.dart';
import 'package:loono/utils/map_utils.dart';
import 'package:loono/utils/memoized_stream.dart';
import 'package:loono/utils/my_logger.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

enum HealthcareSyncState { started, fetching, parsing, storing, completed, error }

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

  late final Uint8List _customMarkerIcon;

  Uint8List get customMarkerIcon => _customMarkerIcon;

  Future<void> init() async {
    _customMarkerIcon = await getMarkerIcon(31 * 3, 40 * 3);
  }

  final healthcareProvidersSyncMemoryStorage = MemoryStorage<HealthcareSyncState>(
    onStateChanged: (state) {
      MyLogger().writeToFile('HEALTHCARE_PROVIDERS STREAM VALUE: $state');
      debugPrint('HEALTHCARE_PROVIDERS STREAM VALUE: $state');
    },
  );

  MemoizedStream<HealthcareSyncState> get healthcareProvidersSyncStateStream =>
      healthcareProvidersSyncMemoryStorage.stateStream;

  HealthcareSyncState? get _syncState => healthcareProvidersSyncMemoryStorage.state;

  /// Updates [SimpleHealthcareProvider] with new data if the current local
  /// data are not up to date or not fetched yet.
  ///
  /// If the data are up to date, returns cached healthcare providers data.
  Future<void> checkAndUpdateIfNeeded() async {
    await _waitForExistingUser();
    // check whether the check is already running
    if (_syncState != null &&
        _syncState != HealthcareSyncState.completed &&
        _syncState != HealthcareSyncState.error) return;

    healthcareProvidersSyncMemoryStorage.setState(HealthcareSyncState.started);
    await MyLogger().writeToFile('HEALTHCARE_PROVIDERS: check started');
    debugPrint('HEALTHCARE_PROVIDERS: check started');
    final localLatestUpdateCheck = _db.users.user?.latestMapUpdateCheck;
    final localLatestUpdate = _db.users.user?.latestMapUpdate;
    final serverLatestUpdate = await _getServerLatestUpdate(localLatestUpdateCheck);
    await MyLogger().writeToFile(
      'HEALTHCARE_PROVIDERS: LOCAL LATEST: $localLatestUpdate | SERVER LATEST: $serverLatestUpdate',
    );
    debugPrint(
      'HEALTHCARE_PROVIDERS: LOCAL LATEST: $localLatestUpdate | SERVER LATEST: $serverLatestUpdate',
    );
    if (localLatestUpdate == null ||
        (serverLatestUpdate != null && serverLatestUpdate.isAfter(localLatestUpdate))) {
      final data = await _fetchAllProvidersData();
      if (data == null) {
        return healthcareProvidersSyncMemoryStorage.setState(HealthcareSyncState.error);
      }
      await _storeList(data, serverLatestUpdate);
    } else {
      await MyLogger().writeToFile('HEALTHCARE_PROVIDERS: DATA ARE UP TO DATE');
      debugPrint('HEALTHCARE_PROVIDERS: DATA ARE UP TO DATE');
    }
    healthcareProvidersSyncMemoryStorage.setState(HealthcareSyncState.completed);
  }

  Future<Iterable<SimpleHealthcareProvider>?> getHealthcareProviders() async {
    if (!_providersFile.existsSync()) return null;
    final content = await _providersFile.readAsString();
    final list = (json.decode(content) as Iterable<dynamic>).map(
      (dynamic e) => standardSerializers.deserializeWith(
        SimpleHealthcareProvider.serializer,
        e,
      ),
    );
    return list.whereType<SimpleHealthcareProvider>();
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
      await MyLogger().writeToFile(
        'HEALTHCARE_PROVIDERS: IT IS MORE THAN 21 DAYS SINCE LATEST UPDATE DATA CHECK',
      );
      debugPrint('HEALTHCARE_PROVIDERS: IT IS MORE THAN 21 DAYS SINCE LATEST UPDATE DATA CHECK');
      // server data are updated usually on the 2nd day month of each month
      final serverLatestUpdateResponse = await _apiService.getProvidersLastUpdate();
      serverLatestUpdateData = serverLatestUpdateResponse.map(
        success: (response) async {
          await MyLogger().writeToFile('HEALTHCARE_PROVIDERS: SERVER UPDATE CHECK WAS SUCCESSFUL');
          debugPrint('HEALTHCARE_PROVIDERS: SERVER UPDATE CHECK WAS SUCCESSFUL');
          await _db.users.updateLatestMapUpdateCheck(now.toDateTime());
          return response.data.lastUpdate.toDateTime();
        },
        failure: (_) async {
          // API update check was unsuccessful, try the next day
          await MyLogger()
              .writeToFile('HEALTHCARE_PROVIDERS: SERVER UPDATE CHECK WAS UNSUCCESSFUL');
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
    healthcareProvidersSyncMemoryStorage.setState(HealthcareSyncState.fetching);
    final healthcareApiResponse = await _apiService.getProvidersAll();
    // ignore: omit_local_variable_types
    final Uint8List? responseData = healthcareApiResponse.mapOrNull(
      success: (response) => response.data,
    );

    if (responseData == null) return null;
    // the response returns compressed zip file which contains serialized providers.json file
    healthcareProvidersSyncMemoryStorage.setState(HealthcareSyncState.parsing);
    final result = ZipDecoder().decodeBytes(responseData).first.content as Uint8List;
    return result;
  }

  Future<void> _storeList(
    Uint8List data,
    DateTime? serverLatestUpdate,
  ) async {
    healthcareProvidersSyncMemoryStorage.setState(HealthcareSyncState.storing);
    await _providersFile.writeAsString(utf8.decode(data));
    await _db.users.updateLatestMapServerUpdate(serverLatestUpdate ?? DateTime.now());
    await _db.users.updateLatestMapUpdateCheck(DateTime.now());
  }
}
