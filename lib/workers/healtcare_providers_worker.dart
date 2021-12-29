import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:loono/helpers/healthcare_provider_type_converters.dart';
import 'package:loono_api/loono_api.dart';

import '../services/api_service.dart';
import '../services/database_service.dart';

enum OperatinTypes { sync }

class HealtcareProvidersWorker {
  static late ApiService _apiService;
  static late DatabaseService _db;
  late SendPort _sendPort;
  late Isolate _isolate;
  final _isolateReady = Completer<void>();
  final _syncCompleted = Completer<void>();
  Future<void> get isReady => _isolateReady.future;
  Future<void> get isSyncCompleted => _syncCompleted.future;

  // ignore: constant_identifier_names
  static const int UPDATE_CHECK_INTERVAL_IN_DAYS = 21;

  HealtcareProvidersWorker({
    required ApiService apiService,
    required DatabaseService databaseService,
  }) {
    _apiService = apiService;
    _db = databaseService;
    init();
  }

  void dispose() {
    _isolate.kill();
  }

  Future<void> init() async {
    final receivePort = ReceivePort();
    final errorPort = ReceivePort();
    // ignore: avoid_print
    errorPort.listen(print);

    receivePort.listen(_handleMessage);
    _isolate = await Isolate.spawn(
      _isolateEntry,
      receivePort.sendPort,
      onError: errorPort.sendPort,
    );
  }

  // entry point of created isolates
  static void _isolateEntry(dynamic message) {
    late SendPort sendPort;
    final receivePort = ReceivePort();

    receivePort.listen((dynamic message) async {
      if (message == OperatinTypes.sync) {
        await _checkAndUpdateIfNeeded(_db, _apiService);
        sendPort.send(OperatinTypes.sync);
      }
    });

    if (message is SendPort) {
      sendPort = message;
      sendPort.send(receivePort.sendPort);
      return;
    }
  }

  // handle messages from created isolate
  void _handleMessage(dynamic message) {
    if (message is SendPort) {
      _sendPort = message;
      _isolateReady.complete();
      return;
    }
    if (message == OperatinTypes.sync) {
      _syncCompleted.complete();
      return;
    }
    throw UnimplementedError('Undefined behavior for message: $message');
  }

  void syncHealtcareProviders() {
    _sendPort.send(OperatinTypes.sync);
  }

  static Future<void> _checkAndUpdateIfNeeded(DatabaseService db, ApiService apiService) async {
    final now = Date.now();
    final localLatestUpdateCheck = db.users.user?.latestMapUpdateCheck;
    final localLatestUpdate = db.users.user?.latestMapUpdate;

    // check for a new server update if it is more than 21 days since the last check
    Future<DateTime?>? serverLatestUpdateData;
    if (localLatestUpdateCheck != null &&
        now.toDateTime().difference(localLatestUpdateCheck).inDays.abs() >
            UPDATE_CHECK_INTERVAL_IN_DAYS) {
      debugPrint('HEALTHCARE_PROVIDERS: IT IS MORE THAN 21 DAYS SINCE LATEST UPDATE DATA CHECK');
      // server data are updated usually on the 2nd day month of each month
      final serverLatestUpdateResponse = await apiService.getProvidersLastUpdate();
      serverLatestUpdateData = serverLatestUpdateResponse.map(
        success: (response) async {
          debugPrint('HEALTHCARE_PROVIDERS: SERVER UPDATE CHECK WAS SUCCESSFUL');
          await db.users.updateLatestMapUpdateCheck(now.toDateTime());
          return response.data.lastUpdate.toDateTime();
        },
        failure: (_) async {
          // API update check was unsuccessful, try the next day
          debugPrint('HEALTHCARE_PROVIDERS: SERVER UPDATE CHECK WAS UNSUCCESSFUL');
          await db.users
              .updateLatestMapUpdateCheck(now.toDateTime().subtract(const Duration(days: 19)));
          return null;
        },
      );
    }

    final serverLatestUpdate = await serverLatestUpdateData;

    debugPrint(
        'HEALTHCARE_PROVIDERS: LOCAL LATEST: $localLatestUpdate --- SERVER LATEST: $serverLatestUpdate');
    if (localLatestUpdate == null ||
        (serverLatestUpdate != null && serverLatestUpdate.isAfter(localLatestUpdate))) {
      debugPrint('HEALTHCARE_PROVIDERS: UPDATING DATA...');
      final BuiltList<SimpleHealthcareProvider>? list = await _fetchAllProvidersData(apiService);
      if (list == null) return Future.error('Could not fetch the data');
      await db.healthcareProviders.updateAllData(list);
      await db.users.updateLatestMapServerUpdate(serverLatestUpdate ?? now.toDateTime());
      await db.users.updateLatestMapUpdateCheck(now.toDateTime());
    } else {
      debugPrint('HEALTHCARE_PROVIDERS: DATA ARE UP TO DATE');
    }
  }

  static Future<BuiltList<SimpleHealthcareProvider>?> _fetchAllProvidersData(
      ApiService apiService) async {
    final healthcareApiResponse = await apiService.getProvidersAll();
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
