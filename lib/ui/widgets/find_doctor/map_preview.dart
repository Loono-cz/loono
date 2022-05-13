import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/models/healthcare_item_place.dart';
import 'package:loono/router/app_router.gr.dart';
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
    zoom: MapVariables.INITIAL_ZOOM,
  );

  @override
  Widget build(BuildContext context) {
    final mapState = context.watch<MapStateService>();

    bool _locationDenied(LocationPermission permission) {
      return [LocationPermission.denied, LocationPermission.deniedForever].contains(permission);
    }

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPos,
        myLocationEnabled: [LocationPermission.always, LocationPermission.whileInUse]
            .contains(mapState.locationPermission),
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        rotateGesturesEnabled: false,
        onMapCreated: (GoogleMapController mapController) async {
          await mapController.setMapStyle(
            await rootBundle.loadString('assets/maps/map-style.json'),
          );
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
        padding: EdgeInsets.fromLTRB(0, 0, 16.0, MediaQuery.of(context).size.height * 0.15),
        child: FloatingActionButton(
          onPressed: () async {
            var permission = await Geolocator.checkPermission();

            if (_locationDenied(permission)) {
              await AutoRouter.of(context).push(const NoPermissionsRoute());
            }

            permission = await Geolocator.checkPermission();
            if (!_locationDenied(permission)) {
              final currentPos = await determinePosition(permission);
              final latLng = LatLng(currentPos.latitude, currentPos.longitude);
              await animateToPos(
                _mapController,
                cameraPosition: CameraPosition(target: latLng, zoom: 17.0),
              );

              /// from unknown reason I need to reassign this permission to display blue dot on map
              permission = await Geolocator.checkPermission();
              mapState.setLocationPermission(permission);
            }
          },
          backgroundColor: Colors.white,
          child: SvgPicture.asset('assets/icons/navigation.svg'),
        ),
      ),
    );
  }
}
