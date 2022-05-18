import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/models/search_result.dart';
import 'package:loono/repositories/healthcare_repository.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/feedback/feedback_button.dart';
import 'package:loono/ui/widgets/find_doctor/bottom_sheet_overlay.dart';
import 'package:loono/ui/widgets/find_doctor/doctor_detail_sheet.dart';
import 'package:loono/ui/widgets/find_doctor/main_search_text_field.dart';
import 'package:loono/ui/widgets/find_doctor/map_preview.dart';
import 'package:loono/ui/widgets/find_doctor/specialization_chips_list.dart';
import 'package:loono/utils/map_utils.dart';
import 'package:loono/utils/memoized_stream.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class FindDoctorScreen extends StatefulWidget {
  const FindDoctorScreen({
    Key? key,
    this.onCancelTap,
  }) : super(key: key);

  final VoidCallback? onCancelTap;

  @override
  State<FindDoctorScreen> createState() => _FindDoctorScreenState();
}

class _FindDoctorScreenState extends State<FindDoctorScreen> {
  final _mapController = Completer<GoogleMapController>();
  final _sheetController = DraggableScrollableController();

  final healthcareProviderRepository = registry.get<HealthcareProviderRepository>();

  late final MapStateService mapState;

  bool _isHealthCareProvidersInMapService = false;
  double _mapOpacity = 1;

  Future<void> _setHealthcareProviders({bool tryFetchAgainData = false}) async {
    if (mapState.allHealthcareProviders.isEmpty) {
      final healthcareProviders = await healthcareProviderRepository.getHealthcareProviders();
      if (healthcareProviders != null && healthcareProviders.isNotEmpty) {
        mapState.addAll(healthcareProviders);
        setState(() => _isHealthCareProvidersInMapService = true);
      } else {
        if (tryFetchAgainData) {
          await healthcareProviderRepository.checkAndUpdateIfNeeded();
        }
      }
    } else {
      Future.delayed(Duration.zero, () async {
        setState(() => _isHealthCareProvidersInMapService = true);
      });
    }
  }

  void setMapOpacity(double opacity) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        _mapOpacity = opacity;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    mapState = context.read<MapStateService>();
  }

  @override
  Widget build(BuildContext context) {
    final currDoctorDetail =
        context.select<MapStateService, SimpleHealthcareProvider?>((value) => value.doctorDetail);
    final currSpec =
        context.select<MapStateService, SearchResult?>((value) => value.currSpecialization);

    return Scaffold(
      appBar: widget.onCancelTap != null
          ? AppBar(
              backgroundColor: LoonoColors.bottomSheetPrevention,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onCancelTap,
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: MemoizedStreamBuilder<HealthcareSyncState>(
          memoizedStream: healthcareProviderRepository.healthcareProvidersSyncStateStream,
          builder: (context, snapshot) {
            final healthcareSyncState = snapshot.data;
            if (healthcareSyncState == HealthcareSyncState.completed &&
                !_isHealthCareProvidersInMapService) {
              _setHealthcareProviders();
            }
            return Stack(
              children: [
                Opacity(
                  opacity: _mapOpacity,
                  child: MapPreview(
                    mapController: _mapController,
                  ),
                ),
                if (_isHealthCareProvidersInMapService) ...[
                  Visibility(
                    visible: currDoctorDetail == null,
                    maintainState: true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          SearchTextField(
                            onItemTap: (searchResult) async {
                              final provider = searchResult.data;
                              if (provider == null) return;
                              await animateToPos(
                                _mapController,
                                cameraPosition: CameraPosition(
                                  target: LatLng(provider.lat, provider.lng),
                                  zoom: searchResult.zoomLevel,
                                ),
                              );
                              _sheetController.jumpTo(MapVariables.MIN_SHEET_SIZE);
                              setMapOpacity(1);
                            },
                          ),
                          SpecializationChipsList(showDefaultSpecs: currSpec == null),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: currDoctorDetail == null,
                    maintainState: true,
                    child: MapSheetOverlay(
                      onItemTap: (healthcareProvider) async {
                        await animateToPos(
                          _mapController,
                          cameraPosition: CameraPosition(
                            target: LatLng(healthcareProvider.lat, healthcareProvider.lng),
                            zoom: MapVariables.DOCTOR_DETAIL_ZOOM,
                          ),
                        );
                        setMapOpacity(1);
                      },
                      setOpacity: setMapOpacity,
                      sheetController: _sheetController,
                    ),
                  ),
                ],
                if (!_isHealthCareProvidersInMapService)
                  if (healthcareSyncState == HealthcareSyncState.error) ...[
                    _buildErrorIndicator(),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 9, bottom: bottomGoogleLogoPadding),
                        child: FeedbackButton(),
                      ),
                    ),
                  ] else
                    _buildLoadingIndicator(),
                if (currDoctorDetail != null) ...[
                  const Positioned(
                    top: 23,
                    right: 15,
                    child: FeedbackButton(),
                  ),
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
                        doctor: currDoctorDetail,
                        closeDetail: () =>
                            mapState.setDoctorDetail(null, unblockOnMoveMapFiltering: false),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
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
    );
  }

  Widget _buildErrorIndicator() {
    return GestureDetector(
      onTap: () => _setHealthcareProviders(tryFetchAgainData: true),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: const LinearProgressIndicator(
                backgroundColor: LoonoColors.primaryWashed,
                minHeight: 70,
                value: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Chyba při načítání dat o lékařích.',
                      style: LoonoFonts.cardTitle.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.refresh, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
