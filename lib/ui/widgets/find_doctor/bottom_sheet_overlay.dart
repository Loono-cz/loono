import 'package:flutter/material.dart';
import 'package:loono/services/map_state_sevice.dart';
import 'package:provider/provider.dart';

class MapSheetOverlay extends StatelessWidget {
  const MapSheetOverlay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MapStateService>(
      builder: (context, value, child) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.75,
          minChildSize: 0.05,
          builder: (context, scrollController) {
            return Container(
              color: const Color.fromRGBO(190, 88, 23, 1),
              child: ListView.builder(
                controller: scrollController,
                itemCount: value.healthcareProviders.length,
                itemBuilder: (context, index) {
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
                                  'doktorů v okolí: ${value.healthcareProviders.length}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                        Card(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 98.0,
                            child: Center(child: Text('Doktor ${index + 1}')),
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
