import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/constants.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/find_doctor/bottom_sheet_overlay.dart';
import 'package:loono/ui/widgets/find_doctor/map_preview.dart';
import 'package:loono/ui/widgets/find_doctor/search_text_field.dart';
import 'package:loono/utils/map_utils.dart';
import 'package:loono/utils/registry.dart';
import 'package:provider/provider.dart';

class FindDoctorScreen extends StatefulWidget {
  FindDoctorScreen({
    Key? key,
    this.cancelRouteName,
  }) : super(key: key);

  final PageRouteInfo? cancelRouteName;
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  final healthcareProviderRepository = registry.get<HealthcareProviderRepository>();
  final mapStateService = MapStateService();

  @override
  State<FindDoctorScreen> createState() => _FindDoctorScreenState();
}

class _FindDoctorScreenState extends State<FindDoctorScreen> {
  bool _isHealtCareProvidersInMapService = false;

  Future<void> _setHealtcareProviders() async {
    final healtcareProviders =
        await registry.get<HealthcareProviderRepository>().getHealthcareProviders();

    if (healtcareProviders != null && healtcareProviders.isNotEmpty) {
      widget.mapStateService.addAll(healtcareProviders);
      setState(() {
        _isHealtCareProvidersInMapService = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.cancelRouteName != null
          ? AppBar(
              backgroundColor: LoonoColors.bottomSheetPrevention,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => AutoRouter.of(context)
                      .popUntilRouteWithName(widget.cancelRouteName!.routeName),
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: StreamBuilder<HealtCareSyncState>(
          stream: widget.healthcareProviderRepository.healtcareProvidersStream,
          initialData: widget.healthcareProviderRepository.lastStreamValue,
          builder: (context, snapshot) {
            if (snapshot.data == HealtCareSyncState.completed &&
                !_isHealtCareProvidersInMapService) {
              _setHealtcareProviders();
            }
            return ChangeNotifierProvider.value(
              value: widget.mapStateService,
              child: Stack(
                children: [
                  MapPreview(mapController: widget.mapController),
                  if (_isHealtCareProvidersInMapService)
                    SearchTextField(
                      onItemTap: (healthcareProvider) async => animateToPos(
                        widget.mapController,
                        cameraPosition: CameraPosition(
                          target: LatLng(healthcareProvider.lat, healthcareProvider.lng),
                          zoom: 17.0,
                        ),
                      ),
                    ),
                  if (_isHealtCareProvidersInMapService)
                    MapSheetOverlay(
                      onItemTap: (healthcareProvider) async => animateToPos(
                        widget.mapController,
                        cameraPosition: CameraPosition(
                          target: LatLng(healthcareProvider.lat, healthcareProvider.lng),
                          zoom: 17.0,
                        ),
                      ),
                    ),
                  if (!_isHealtCareProvidersInMapService)
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: 70,
                      width: double.infinity,
                      color: Colors.green,
                      child: const Text('loading indicator placeholder'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
