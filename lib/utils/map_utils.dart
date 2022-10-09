import 'dart:async';
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/constants.dart';
import 'package:loono/models/healthcare_item_place.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/utils/registry.dart';

Future<void> animateToPos(
  Completer<GoogleMapController> mapController, {
  required CameraPosition cameraPosition,
}) async {
  // ignore: omit_local_variable_types
  final GoogleMapController controller = await mapController.future;
  await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
}

Future<Position> determinePosition(LocationPermission permission) async {
  bool serviceEnabled;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // return Future.error('Location services are disabled.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  return Geolocator.getCurrentPosition();
}

Future<Marker> Function(
  Cluster<HealthcareItemPlace>,
  MapStateService mapState,
) get markerBuilder => (cluster, mapState) async {
      final healthcareRepository = registry.get<HealthcareProviderRepository>();

      final isClusterSelected = cluster.isMultiple &&
          mapState.onMoveMapFilteringBlocked &&
          (const DeepCollectionEquality.unordered().equals(
            cluster.items.map((e) => e.healthcareProvider.institutionId),
            mapState.currHealthcareProviders.map((e) => e.institutionId),
          ));

      final icon = cluster.isMultiple
          ? await getMarkerBitmap(
              125,
              text: cluster.isMultiple ? cluster.count.toString() : null,
              isClusterSelected: isClusterSelected,
            )
          : BitmapDescriptor.fromBytes(healthcareRepository.customMarkerIcon);

      return Marker(
        markerId: MarkerId(cluster.getId()),
        position: cluster.location,
        consumeTapEvents: !cluster.isMultiple,
        onTap: cluster.isMultiple
            ? isClusterSelected
                ? () {
                    mapState
                      ..setDoctorDetail(null)
                      ..applyFilter();
                  }
                : () => mapState.setActiveDoctors(cluster.items.map((e) => e.healthcareProvider))
            : () => mapState.setDoctorDetail(cluster.items.first.healthcareProvider),
        infoWindow: InfoWindow.noText,
        icon: icon ?? BitmapDescriptor.defaultMarker,
      );
    };

Future<BitmapDescriptor?> getMarkerBitmap(
  int size, {
  String? text,
  required bool isClusterSelected,
}) async {
  final pictureRecorder = ui.PictureRecorder();
  final canvas = Canvas(pictureRecorder);
  final paint1 = Paint()
    ..color = isClusterSelected ? LoonoColors.primaryEnabled : LoonoColors.primaryLight;
  final paint2 = Paint()..color = LoonoColors.primaryEnabled;

  canvas
    ..drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1)
    ..drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2)
    ..drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

  if (text != null) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter
      ..text = TextSpan(
        text: text,
        style: TextStyle(
          fontSize: size / 3,
          color: isClusterSelected ? Colors.white : LoonoColors.primaryEnabled,
          fontWeight: FontWeight.normal,
        ),
      )
      ..layout()
      ..paint(
        canvas,
        Offset(size / 2 - textPainter.width / 2, size / 2 - textPainter.height / 2),
      );
  }

  final img = await pictureRecorder.endRecording().toImage(size, size);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  if (data == null) return null;
  return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}

Future<ui.Image> loadUiImage(String imageAssetPath) async {
  final data = await rootBundle.load(imageAssetPath);
  final completer = Completer<ui.Image>();
  ui.decodeImageFromList(Uint8List.view(data.buffer), completer.complete);
  return completer.future;
}

Future<Uint8List> getMarkerIcon(int width, int height) async {
  final pictureRecorder = ui.PictureRecorder();
  final canvas = Canvas(pictureRecorder);
  final imaged = await loadUiImage('assets/icons/doctor_marker.png');
  canvas.drawImageRect(
    imaged,
    Rect.fromLTRB(0.0, 0.0, imaged.width.toDouble(), imaged.height.toDouble()),
    Rect.fromLTRB(0.0, 0.0, width.toDouble(), height.toDouble()),
    Paint(),
  );

  final img = await pictureRecorder.endRecording().toImage(width, height);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}
