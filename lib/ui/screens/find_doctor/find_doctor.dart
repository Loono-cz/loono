import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/find_doctor/bottom_sheet_overlay.dart';
import 'package:loono/ui/widgets/find_doctor/map_preview.dart';
import 'package:loono/ui/widgets/find_doctor/search_text_field.dart';
import 'package:loono/utils/map_utils.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

class FindDoctorScreen extends StatelessWidget {
  FindDoctorScreen({Key? key}) : super(key: key);

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  final _healthcareProviderRepository = registry.get<HealthcareProviderRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<HealthcareProvider>>(
          future: _healthcareProviderRepository.checkAndUpdateIfNeeded(),
          builder: (context, snapshot) {
            debugPrint(snapshot.data?.length.toString() ?? '');
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              return ChangeNotifierProvider<MapStateService>(
                create: (_) => MapStateService()..addAll(snapshot.data!),
                child: Stack(
                  children: [
                    MapPreview(mapController: _mapController),
                    SearchTextField(
                      onItemTap: (healthcareProvider) async => animateToPos(
                        _mapController,
                        cameraPosition: CameraPosition(
                            target: LatLng(healthcareProvider.lat, healthcareProvider.lng),
                            zoom: 17.0),
                      ),
                    ),
                    MapSheetOverlay(
                      onItemTap: (healthcareProvider) async => animateToPos(
                        _mapController,
                        cameraPosition: CameraPosition(
                            target: LatLng(healthcareProvider.lat, healthcareProvider.lng),
                            zoom: 17.0),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
