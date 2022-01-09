import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/utils/registry.dart';

class FindDoctorScreen extends StatelessWidget {
  FindDoctorScreen({Key? key}) : super(key: key);

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  final _healthcareProviderRepository = registry.get<HealthcareProviderRepository>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HealtCareSyncState>(
      stream: _healthcareProviderRepository.healtcareProvidersStream,
      initialData: HealtCareSyncState.started,
      builder: (context, snapshot) {
        print(snapshot.data);
        return Container();
      },
    ); // TODO: jakb bude dopracovaný isolate => vrátit
    // return Scaffold(
    //   body: SafeArea(
    //     child: FutureBuilder<List<HealthcareProvider>>(
    //       future: _healthcareProviderRepository.checkAndUpdateIfNeeded(),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
    //           return ChangeNotifierProvider<MapStateService>(
    //             create: (_) => MapStateService()..addAll(snapshot.data!),
    //             child: Stack(
    //               children: [
    //                 MapPreview(mapController: _mapController),
    //                 SearchTextField(
    //                   onItemTap: (healthcareProvider) async => animateToPos(
    //                     _mapController,
    //                     cameraPosition: CameraPosition(
    //                         target: LatLng(healthcareProvider.lat, healthcareProvider.lng),
    //                         zoom: 17.0),
    //                   ),
    //                 ),
    //                 MapSheetOverlay(
    //                   onItemTap: (healthcareProvider) async => animateToPos(
    //                     _mapController,
    //                     cameraPosition: CameraPosition(
    //                         target: LatLng(healthcareProvider.lat, healthcareProvider.lng),
    //                         zoom: 17.0),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         }
    //         return const Center(child: CircularProgressIndicator());
    //       },
    //     ),
    //   ),
    // );
  }
}
