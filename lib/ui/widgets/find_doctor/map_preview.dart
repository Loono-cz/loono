import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/models/healthcare_item_place.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/utils/map_utils.dart';
import 'package:provider/provider.dart';

class MapPreview extends StatelessWidget {
  const MapPreview({
    Key? key,
    required Completer<GoogleMapController> mapController,
  })  : _mapController = mapController,
        super(key: key);

  final Completer<GoogleMapController> _mapController;

  static const _initialCameraPos = CameraPosition(
    target: MapVariables.INITIAL_COORDS,
    zoom: MapVariables.DEFAULT_ZOOM,
  );

  @override
  Widget build(BuildContext context) {
    final mapState = context.watch<MapStateService>();

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPos,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController mapController) async {
          _mapController.complete(mapController);
          final latLngBounds = await mapController.getVisibleRegion();
          mapState.setVisibleRegion(latLngBounds);
          mapState.clusterManager
            ..setMapId(mapController.mapId)
            ..setItems(mapState.allHealthcareProviders.map((e) => HealthcareItemPlace(e)).toList());
        },
        onCameraMove: mapState.clusterManager.onCameraMove,
        onCameraIdle: () async {
          // ignore: omit_local_variable_types
          final GoogleMapController controller = await _mapController.future;
          final latLngBounds = await controller.getVisibleRegion();
          mapState.setVisibleRegion(latLngBounds);
          mapState.clusterManager.updateMap();
        },
        markers: mapState.markers,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, MediaQuery.of(context).size.height * 0.5),
        child: FloatingActionButton(
          onPressed: () async {
            final currentPos = await determinePosition();
            final latLng = LatLng(currentPos.latitude, currentPos.longitude);
            await animateToPos(
              _mapController,
              cameraPosition: CameraPosition(target: latLng, zoom: 17.0),
            );
          },
          backgroundColor: Colors.white,
          child: SvgPicture.asset('assets/icons/navigation.svg'),
        ),
      ),
    );
  }
}
