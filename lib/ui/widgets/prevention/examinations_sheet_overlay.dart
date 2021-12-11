import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_status.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/repositories/examination_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/prevention/examination_card.dart';
import 'package:loono/utils/registry.dart';

class ExaminationsSheetOverlay extends StatelessWidget {
  ExaminationsSheetOverlay({Key? key}) : super(key: key);

  final _examinationRepository = registry.get<ExaminationRepository>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FutureBuilder<List<ExaminationRecord>>(
        future: _examinationRepository.getExaminationRecords(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final categorized = snapshot.data!
                .map((e) => CategorizedExamination(examination: e, status: e.calculateStatus()))
                .toList();

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
                    itemCount: examinationStatusOrdering.length,
                    itemBuilder: (context, index) {
                      final examinationStatus = examinationStatusOrdering.elementAt(index);
                      final categorizedExaminations = categorized
                          .where((e) => e.status == examinationStatus)
                          .toList()
                        ..sortExaminations();

                      return categorizedExaminations.isEmpty
                          ? Column(
                              children: [
                                if (index == 0) _buildHandle(context),
                                const SizedBox.shrink(),
                              ],
                            )
                          : Column(
                              children: [
                                if (index == 0) _buildHandle(context),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Text(
                                          examinationStatus.getHeaderMessage(context),
                                          style: LoonoFonts.cardSubtitle.copyWith(
                                            color: LoonoColors.black,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: categorizedExaminations
                                            .mapIndexed(
                                              (index, e) => Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 6),
                                                child: ExaminationCard(
                                                  index: index,
                                                  categorizedExamination: e,
                                                  onTap: () => AutoRouter.of(context).navigate(
                                                      ExaminationDetailRoute(
                                                          categorizedExamination: e)),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: 4.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
