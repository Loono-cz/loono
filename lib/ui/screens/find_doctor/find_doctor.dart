import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/find_doctor/bottom_sheet_overlay.dart';
import 'package:loono/ui/widgets/find_doctor/doctor_detail_sheet.dart';
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

  @override
  State<FindDoctorScreen> createState() => _FindDoctorScreenState();
}

class _FindDoctorScreenState extends State<FindDoctorScreen> {
  bool _isHealthCareProvidersInMapService = false;
  final _sheetController = DraggableScrollableController();

  //final mapStateService = MapStateService();

  Future<void> _setHealthcareProviders(MapStateService mapStateService) async {
    final healthcareProviders =
        await registry.get<HealthcareProviderRepository>().getHealthcareProviders();

    if (healthcareProviders != null && healthcareProviders.isNotEmpty) {
      mapStateService.addAll(healthcareProviders);
      setState(() {
        _isHealthCareProvidersInMapService = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapStateService = Provider.of<MapStateService>(context, listen: true);

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
                !_isHealthCareProvidersInMapService) {
              _setHealthcareProviders(mapStateService);
            }
            return ChangeNotifierProvider.value(
              value: mapStateService,
              child: Stack(
                children: [
                  MapPreview(mapController: widget.mapController),
                  if (_isHealthCareProvidersInMapService)
                    SearchTextField(
                      onItemTap: (searchResult) async => animateToPos(
                        widget.mapController,
                        cameraPosition: CameraPosition(
                          target: LatLng(searchResult.data.lat, searchResult.data.lng),
                          zoom: searchResult.zoomLevel,
                        ),
                      ),
                    ),
                  if (_isHealthCareProvidersInMapService)
                    MapSheetOverlay(
                      onItemTap: (healthcareProvider) async => animateToPos(
                        widget.mapController,
                        cameraPosition: CameraPosition(
                          target: LatLng(healthcareProvider.lat, healthcareProvider.lng),
                          zoom: MapVariables.DOCTOR_DETAIL_ZOOM,
                        ),
                      ),
                      sheetController: _sheetController,
                      mapStateService: mapStateService,
                    ),
                  if (!_isHealthCareProvidersInMapService)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: const LinearProgressIndicator(
                              backgroundColor: Color.fromRGBO(104, 170, 123, 1),
                              color: LoonoColors.greenSuccess,
                              minHeight: 70,
                              value: null,
                            ),
                          ),
                          Text(
                            'Načítám informace o lékařích ...',
                            style: LoonoFonts.cardTitle.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  if (mapStateService.doctorDetail != null)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              LoonoColors.greenLight,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                        ),
                        height: 370,
                        child: DoctorDetailSheet(
                          doctor: mapStateService.doctorDetail!,
                          closeDetail: () => mapStateService.setDoctorDetail(null),
                        ),
                      ),
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
