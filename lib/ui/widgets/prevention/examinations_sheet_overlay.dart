import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/prevention/examination_card.dart';
import 'package:loono/ui/widgets/prevention/self_examination/self_examination_card.dart';

import 'package:provider/provider.dart';

class ExaminationsSheetOverlay extends StatefulWidget {
  const ExaminationsSheetOverlay({Key? key}) : super(key: key);

  @override
  State<ExaminationsSheetOverlay> createState() => _ExaminationsSheetOverlayState();
}

class _ExaminationsSheetOverlayState extends State<ExaminationsSheetOverlay> {
  @override
  Widget build(BuildContext context) {
    final examinationsProvider = Provider.of<ExaminationsProvider>(context, listen: true);

    return SizedBox.expand(
      child: examinationsProvider.loading
          ? const Center(child: CircularProgressIndicator())
          : DraggableScrollableSheet(
              initialChildSize: 0.4,
              maxChildSize: 0.75,
              minChildSize: 0.15,
              builder: (context, scrollController) {
                if (examinationsProvider.examinations == null) {
                  return const Center(
                    child: Text('žádné záznamy'),
                  );
                }
                final categorized = examinationsProvider.examinations!.examinations
                    .map(
                      (e) => CategorizedExamination(
                        examination: e,
                        category: e.calculateStatus(),
                      ),
                    )
                    .toList();

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
                    itemCount: examinationCategoriesOrdering.length,
                    itemBuilder: (context, index) {
                      final examinationStatus = examinationCategoriesOrdering.elementAt(index);
                      final categorizedExaminations = categorized
                          .where((e) => e.category == examinationStatus)
                          .toList()
                        ..sortExaminations();

                      return categorizedExaminations.isEmpty
                          ? Column(
                              children: [
                                if (index == 0) ...[
                                  _buildHandle(context),
                                  if (examinationsProvider.examinations?.selfexaminations != null)
                                    Column(
                                      children: examinationsProvider.examinations!.selfexaminations
                                          .map(
                                            (selfExamination) => SelfExaminationCard(
                                              onTap: (sex) => AutoRouter.of(context).navigate(
                                                SelfExaminationDetailRoute(
                                                  sex: sex,
                                                  selfExamination: selfExamination,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                ],
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
                                                      categorizedExamination: e,
                                                    ),
                                                  ),
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
            ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: 4.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
