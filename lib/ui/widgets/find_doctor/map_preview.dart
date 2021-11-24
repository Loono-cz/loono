import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/helpers/map_variables.dart';

class MapPreview extends StatefulWidget {
  const MapPreview({Key? key}) : super(key: key);

  @override
  _MapPreviewState createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  final _mapController = Completer<GoogleMapController>();

  static const _initialCameraPos = CameraPosition(
    target: MapVariables.INITIAL_COORDS,
    zoom: MapVariables.DEFAULT_ZOOM,
  );

  Future<void> _animateToPos(CameraPosition cameraPosition) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Set<Marker> _createMarkers() {
    final markers = <Marker>{};
    markers.add(
      const Marker(
        markerId: MarkerId('0'),
        position: MapVariables.INITIAL_COORDS,
        infoWindow: InfoWindow(title: 'Zatím tu nic k vidění není 🙂'),
      ),
    );
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPos,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        markers: _createMarkers(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, MediaQuery.of(context).size.height * 0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.white,
              child: Icon(Icons.filter_alt, color: Colors.black87),
            ),
            FloatingActionButton(
              onPressed: () async {
                final currentPos = await _determinePosition();
                final latLng = LatLng(currentPos.latitude, currentPos.longitude);
                await _animateToPos(CameraPosition(target: latLng, zoom: 17.0));
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.my_location, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Position> _determinePosition() async {
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
