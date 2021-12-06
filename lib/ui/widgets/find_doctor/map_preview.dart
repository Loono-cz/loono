import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/models/healthcare_item_place.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/utils/map_utils.dart';
import 'package:provider/provider.dart';

class MapPreview extends StatefulWidget {
  const MapPreview({Key? key}) : super(key: key);

  @override
  _MapPreviewState createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  final _mapController = Completer<GoogleMapController>();

  late final MapStateService mapStateService;
  late ClusterManager clusterManager;
  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    mapStateService = context.read<MapStateService>();
    clusterManager = _initClusterManager();
  }

  ClusterManager _initClusterManager() => ClusterManager<HealthcareItemPlace>(
        <HealthcareItemPlace>[],
        _updateMarkers,
        markerBuilder: _markerBuilder,
      );

  static const _initialCameraPos = CameraPosition(
    target: MapVariables.INITIAL_COORDS,
    zoom: MapVariables.DEFAULT_ZOOM,
  );

  void _updateMarkers(Set<Marker> markers) {
    setState(() {
      this.markers
        ..clear()
        ..addAll(markers);
    });
  }

  Future<void> _animateToPos(CameraPosition cameraPosition) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<Marker> Function(Cluster<HealthcareItemPlace>) get _markerBuilder => (cluster) async {
        final icon = await getMarkerBitmap(
          cluster.isMultiple ? 125 : 75,
          text: cluster.isMultiple ? cluster.count.toString() : null,
        );

        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            //
          },
          infoWindow: cluster.isMultiple
              ? InfoWindow.noText
              : InfoWindow(
                  title:
                      'institutionId: ${cluster.items.firstOrNull?.healthcareProvider.institutionId}',
                  snippet:
                      '${cluster.items.firstOrNull?.healthcareProvider.title} (${cluster.items.firstOrNull?.healthcareProvider.specialization})',
                  onTap: () {
                    //
                  },
                ),
          icon: icon ?? BitmapDescriptor.defaultMarker,
        );
      };

  @override
  Widget build(BuildContext context) {
    return Consumer<MapStateService>(
      builder: (context, value, child) {
        return Scaffold(
          body: GoogleMap(
            initialCameraPosition: _initialCameraPos,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) async {
              _mapController.complete(controller);
              final latLngBounds = await controller.getVisibleRegion();
              mapStateService.setVisibleRegion(latLngBounds);
              clusterManager
                ..setMapId(controller.mapId)
                ..setItems(
                    value.allHealthcareProviders.map((e) => HealthcareItemPlace(e)).toList());
            },
            onCameraMove: clusterManager.onCameraMove,
            onCameraIdle: () async {
              final GoogleMapController controller = await _mapController.future;
              final latLngBounds = await controller.getVisibleRegion();
              mapStateService.setVisibleRegion(latLngBounds);
              clusterManager.updateMap();
            },
            markers: markers,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding:
                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, MediaQuery.of(context).size.height * 0.5),
            child: FloatingActionButton(
              onPressed: () async {
                final currentPos = await determinePosition();
                final latLng = LatLng(currentPos.latitude, currentPos.longitude);
                await _animateToPos(CameraPosition(target: latLng, zoom: 17.0));
              },
              backgroundColor: Colors.white,
              child: const Icon(Icons.my_location, color: Colors.black87),
            ),
          ),
        );
      },
    );
  }
}
