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
    this.firstSelectedSpecializationName,
  }) : super(key: key);

  final VoidCallback? onCancelTap;
  final String? firstSelectedSpecializationName;

  @override
  State<FindDoctorScreen> createState() => FindDoctorScreenState();
}

@visibleForTesting
class FindDoctorScreenState extends State<FindDoctorScreen> {
  @visibleForTesting
  final mapController = Completer<GoogleMapController>();
  final _sheetController = DraggableScrollableController();

  final _healthcareProviderRepository =
      registry.get<HealthcareProviderRepository>();

  late final MapStateService _mapState;

  bool _isFirstSelectedSpecializationSet = false;
  bool _canFirstSelectedSpecializationSet = false;

  bool _isHealthCareProvidersInMapService = false;
  double _mapOpacity = 1;

  Future<void> _setHealthcareProviders({bool tryFetchAgainData = false}) async {
    if (_mapState.allHealthcareProviders.isEmpty) {
      final healthcareProviders =
          await _healthcareProviderRepository.getHealthcareProviders();
      if (healthcareProviders != null && healthcareProviders.isNotEmpty) {
        _mapState.addAll(healthcareProviders);
        setState(() => _isHealthCareProvidersInMapService = true);
      } else {
        if (tryFetchAgainData) {
          await _healthcareProviderRepository.checkAndUpdateIfNeeded();
        }
      }
    } else {
      Future.delayed(Duration.zero, () async {
        setState(() => _isHealthCareProvidersInMapService = true);
      });
    }
  }

  void _setMapOpacity(double opacity) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        _mapOpacity = opacity;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _mapState = context.read<MapStateService>();
  }

  @override
  void dispose() {
    _isFirstSelectedSpecializationSet = false;
    super.dispose();
  }

  void _setFirstSelectedSpecialization() {
    if (!_isFirstSelectedSpecializationSet) {
      _isFirstSelectedSpecializationSet = true;

      final specializationName = widget.firstSelectedSpecializationName;
      if (specializationName != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          final specResult =
              _mapState.getSpecSearchResultByName(specializationName);
          _mapState.setSpecialization(specResult);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_canFirstSelectedSpecializationSet) {
      _setFirstSelectedSpecialization();
      _canFirstSelectedSpecializationSet = false;
    } else {
      _canFirstSelectedSpecializationSet = true;
    }
    final currDoctorDetail =
        context.select<MapStateService, SimpleHealthcareProvider?>(
      (value) => value.doctorDetail,
    );
    final currSpec = context.select<MapStateService, SearchResult?>(
      (value) => value.currSpecialization,
    );

    return Scaffold(
      appBar: widget.onCancelTap != null
          ? AppBar(
              backgroundColor: LoonoColors.bottomSheetPrevention,
              actions: [
                IconButton(
                  key: const Key('findDoctorPage_closeButton'),
                  icon: const Icon(Icons.close),
                  onPressed: widget.onCancelTap,
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: MemoizedStreamBuilder<HealthcareSyncState>(
          memoizedStream:
              _healthcareProviderRepository.healthcareProvidersSyncStateStream,
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
                    mapController: mapController,
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
                            key: const Key('findDoctorPage_mainSearchField'),
                            onItemTap: (searchResult) async {
                              final provider = searchResult.data;
                              if (provider == null) return;
                              await animateToPos(
                                mapController,
                                cameraPosition: CameraPosition(
                                  target: LatLng(provider.lat, provider.lng),
                                  zoom: searchResult.zoomLevel,
                                ),
                              );
                              _sheetController
                                  .jumpTo(MapVariables.MIN_SHEET_SIZE);
                              _setMapOpacity(1);
                            },
                          ),
                          SpecializationChipsList(
                            showDefaultSpecs: currSpec == null,
                          ),
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
                          mapController,
                          cameraPosition: CameraPosition(
                            target: LatLng(
                              healthcareProvider.lat,
                              healthcareProvider.lng,
                            ),
                            zoom: MapVariables.DOCTOR_DETAIL_ZOOM,
                          ),
                        );
                        _setMapOpacity(1);
                      },
                      setOpacity: _setMapOpacity,
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
                        padding: EdgeInsets.only(
                          left: 9,
                          bottom: bottomGoogleLogoPadding,
                        ),
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
                        key: const Key('findDoctorPage_doctorDetailSheet'),
                        doctor: currDoctorDetail,
                        closeDetail: () => _mapState.setDoctorDetail(
                          null,
                          unblockOnMoveMapFiltering: false,
                        ),
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
      key: const Key('findDoctorPage_loadingIndicator'),
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
      key: const Key('findDoctorPage_errorIndicator'),
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
