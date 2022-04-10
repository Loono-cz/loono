import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/find_doctor/search_doctor_card.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class MapSheetOverlay extends StatelessWidget {
  const MapSheetOverlay({
    Key? key,
    required this.onItemTap,
    required this.sheetController,
  }) : super(key: key);

  final ValueChanged<SimpleHealthcareProvider>? onItemTap;
  final DraggableScrollableController sheetController;

  @override
  Widget build(BuildContext context) {
    final mapState = context.watch<MapStateService>();
    final currHealthcareProviders = mapState.currHealthcareProviders;

    if (currHealthcareProviders.isNotEmpty) {
      if (!mapState.onMoveMapFilteringBlocked && currHealthcareProviders.length > 1000) {
        return const SizedBox.shrink();
      }
      return DraggableScrollableSheet(
        initialChildSize: MapVariables.MIN_SHEET_SIZE,
        minChildSize: MapVariables.MIN_SHEET_SIZE,
        maxChildSize: MapVariables.MAX_SHEET_SIZE,
        controller: sheetController,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: LoonoColors.bottomSheetPrevention,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: ListView.builder(
              controller: scrollController,
              itemCount: currHealthcareProviders.length,
              itemBuilder: (context, index) {
                final item = currHealthcareProviders[index];

                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0) ...[
                        Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 4.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${mapState.onMoveMapFilteringBlocked ? 'vybraní lékaři' : 'lékařů v okolí'}: ${mapState.currHealthcareProviders.length}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                      SearchDoctorCard(
                        item: item,
                        onTap: () {
                          onItemTap?.call(item);
                          mapState.setDoctorDetail(item, unblockOnMoveMapFiltering: false);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Flushbar<dynamic>(
          isDismissible: false,
          message: context.l10n.map_no_doctors_around_info_message,
          messageColor: LoonoColors.black,
          backgroundColor: LoonoColors.primaryWashed,
          flushbarStyle: FlushbarStyle.FLOATING,
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
