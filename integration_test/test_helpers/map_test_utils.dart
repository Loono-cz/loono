// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/ui/screens/find_doctor/find_doctor.dart';
import 'package:loono_api/loono_api.dart';

import 'e2e_action_logging.dart';

extension ProviderLatLngExt on SimpleHealthcareProvider {
  LatLng get latLng => LatLng(lat, lng);
}

class MapTestUtils {
  const MapTestUtils(this.tester);

  final WidgetTester tester;

  Future<void> _waitForMapToLoad(Completer<GoogleMapController> mapControllerCompleter) async {
    final timer = Timer(const Duration(seconds: 4), () {});
    await Future.doWhile(
      () {
        if (mapControllerCompleter.isCompleted) {
          return false;
        }
        if (!timer.isActive) {
          return false;
        }
        return true;
      },
    );
  }

  Future<GoogleMapController> _getMapController(WidgetTester tester) async {
    final findDoctorState = tester.state<FindDoctorScreenState>(find.byType(FindDoctorScreen));
    final mapController = findDoctorState.mapController;
    await _waitForMapToLoad(mapController);
    if (mapController.isCompleted) {
      return mapController.future;
    }
    throw (Exception('GoogleMapController Completer has not completed yet.'));
  }

  Future<void> waitForCameraToStop([GoogleMapController? controller]) async {
    final mapController = controller ?? await _getMapController(tester);
    final timer = Timer(const Duration(seconds: 4), () {});
    await Future.doWhile(
      () async {
        final cameraPos1 = await mapController.getVisibleRegion();
        await tester.pump(const Duration(milliseconds: 0));
        final cameraPos2 = await mapController.getVisibleRegion();
        if (cameraPos1 == cameraPos2) {
          logCustomTestEvent('Map camera move done');
          await tester.pump(const Duration(seconds: 2));
          return false;
        }
        if (!timer.isActive) {
          logCustomTestEvent('Map camera timeouted');
          return false;
        }
        logCustomTestEvent('Map camera is moving...');
        return true;
      },
    );
  }

  Future<void> animateToLocation({required LatLng latLng, required String locationName}) async {
    logTestEvent('Map camera is moving to city: "$locationName"');
    final mapController = await _getMapController(tester);
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: MapVariables.CITY_ZOOM),
      ),
    );
    await waitForCameraToStop(mapController);
  }

  Future<void> verifyVisibleAreaProviderState(
    SimpleHealthcareProvider provider, {
    required bool isVisible,
  }) async {
    if (isVisible) {
      logTestEvent(
        'Verify currently visible Map region contains doctor: "${provider.title} (from: ${provider.city}"',
      );
    } else {
      logTestEvent(
        'Verify currently visible Map region does not contain doctor: "${provider.title} (from: ${provider.city}"',
      );
    }
    final mapController = await _getMapController(tester);
    final visibleArea = await mapController.getVisibleRegion();
    expect(visibleArea.contains(provider.latLng), isVisible);
  }
}
