import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:loono/helpers/healthcare_provider_type_converters.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono_api/loono_api.dart';

import '../services/api_service.dart';
import '../services/database_service.dart';

enum OperatinTypes { sync }

class HealtcareProvidersWorker {
  final ApiService _apiService;
  final DatabaseService _db;
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
  })  : _apiService = apiService,
        _db = databaseService {
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

  // --------------Main isolate side--------------
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

  Future<void> syncHealtcareProviders() async {
    await Future.delayed(const Duration(seconds: 5));
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

    debugPrint(
        'HEALTHCARE_PROVIDERS: LOCAL LATEST: $localLatestUpdate --- SERVER LATEST: $serverLatestUpdate');
    if (localLatestUpdate == null ||
        (serverLatestUpdate != null && serverLatestUpdate.isAfter(localLatestUpdate))) {
      debugPrint('HEALTHCARE_PROVIDERS: UPDATING DATA...');
      final BuiltList<SimpleHealthcareProvider>? list = await _fetchAllProvidersData(_apiService);
      if (list == null) return Future.error('Could not fetch the data');
      await _db.healthcareProviders.updateAllData(list);
      await _db.users.updateLatestMapServerUpdate(serverLatestUpdate ?? now.toDateTime());
      await _db.users.updateLatestMapUpdateCheck(now.toDateTime());
    } else {
      debugPrint('HEALTHCARE_PROVIDERS: DATA ARE UP TO DATE');
    }

    // _sendPort.send('test');
  }

  // --------------New Isolate side--------------
  static void _isolateEntry(dynamic message) {
    late SendPort sendPort;
    final receivePort = ReceivePort();

    receivePort.listen((message) async {
      if (message['operationType'] == 'A') {
        debugPrint('JSME TU');
        // debugPrint('JSME TU ${message["db"]}');
        // await _checkAndUpdateIfNeeded();
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

  static Future<BuiltList<SimpleHealthcareProvider>?> _fetchAllProvidersData(
      ApiService apiService) async {
    final healthcareApiResponse = await apiService.getProvidersAll();
    final Uint8List? responseData = healthcareApiResponse.mapOrNull(
      success: (response) => response.data,
    );
    if (responseData == null) return null;

    // the response returns compressed zip file which contains serialized providers.json file
    // final archive = ZipDecoder().decodeBytes(responseData);
    final archive = await compute<Uint8List, Archive>(hadleZip, responseData);
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

Archive hadleZip(Uint8List list) {
  return ZipDecoder().decodeBytes(list);
}
