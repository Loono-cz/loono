import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:provider/provider.dart';

class MapSheetOverlay extends StatelessWidget {
  const MapSheetOverlay({
    Key? key,
    required this.onItemTap,
  }) : super(key: key);

  final void Function(HealthcareProvider)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<MapStateService>(
      builder: (context, value, child) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.75,
          minChildSize: 0.15,
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
                itemCount: value.currHealthcareProviders.length,
                itemBuilder: (context, index) {
                  final item = value.currHealthcareProviders[index];

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
                                  'doktorů v okolí: ${value.currHealthcareProviders.length}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          elevation: 0.0,
                          child: InkWell(
                            onTap: () => onItemTap?.call(item),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 120.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.title),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
