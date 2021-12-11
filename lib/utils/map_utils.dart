import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/constants.dart';

Future<void> animateToPos(
  Completer<GoogleMapController> mapController, {
  required CameraPosition cameraPosition,
}) async {
  final GoogleMapController controller = await mapController.future;
  await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return Geolocator.getCurrentPosition();
}

Future<BitmapDescriptor?> getMarkerBitmap(int size, {String? text}) async {
  final pictureRecorder = PictureRecorder();
  final canvas = Canvas(pictureRecorder);
  final paint1 = Paint()..color = LoonoColors.primaryLight;
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
          color: LoonoColors.primaryEnabled,
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
  final data = await img.toByteData(format: ImageByteFormat.png);
  if (data == null) return null;
  return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}
