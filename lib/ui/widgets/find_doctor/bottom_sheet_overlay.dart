import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/map_variables.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:loono/ui/widgets/feedback/feedback_button.dart';
import 'package:loono/ui/widgets/find_doctor/search_doctor_card.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

// To not overlap the Google logo, which might be against ToS.
const bottomGoogleLogoPadding = 50.0;

class MapSheetOverlay extends StatelessWidget {
  const MapSheetOverlay({
    Key? key,
    required this.onItemTap,
    required this.sheetController,
    required this.setOpacity,
  }) : super(key: key);

  final ValueChanged<SimpleHealthcareProvider>? onItemTap;
  final DraggableScrollableController sheetController;
  final Function(double) setOpacity;

  @override
  Widget build(BuildContext context) {
    final mapState = context.watch<MapStateService>();
    final currHealthcareProviders = mapState.currHealthcareProviders;

    if (currHealthcareProviders.isNotEmpty) {
      if (!mapState.onMoveMapFilteringBlocked && currHealthcareProviders.length > 1000) {
        return const Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 9, bottom: bottomGoogleLogoPadding),
            child: FeedbackButton(),
          ),
        );
      }
      return NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          setOpacity(
            (((notification.extent - MapVariables.MIN_SHEET_SIZE) /
                        (MapVariables.MAX_SHEET_SIZE - MapVariables.MIN_SHEET_SIZE)) -
                    1) *
                -1,
          );
          return false;
        },
        child: DraggableScrollableSheet(
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
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    titleSpacing: 0,
                    toolbarHeight: 40,
                    automaticallyImplyLeading: false,
                    title: Container(
                      decoration: const BoxDecoration(
                        color: LoonoColors.bottomSheetPrevention,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 18.0,
                            bottom: 18.0,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 4.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final item = currHealthcareProviders[index];
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (index == 0) ...[
                                Column(
                                  children: [
                                    if (kDebugMode)
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
                      childCount: currHealthcareProviders.length,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, bottomGoogleLogoPadding),
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
