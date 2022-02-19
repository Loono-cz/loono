import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/self_examination_category.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/prevention/examination_card.dart';
import 'package:loono/ui/widgets/prevention/self_examination/self_examination_card.dart';
import 'package:loono_api/loono_api.dart';
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
                    cacheExtent: 1000,
                    itemBuilder: (context, index) {
                      final examinationStatus = examinationCategoriesOrdering.elementAt(index);
                      final categorizedExaminations = categorized
                          .where((e) => e.category == examinationStatus)
                          .toList()
                        ..sortExaminations();

                      return Column(
                        children: [
                          if (index == 0) ...[
                            _buildHandle(context),
                            _buildSelfExaminationCategory(
                              context,
                              CardPosition.first,
                              examinationsProvider.examinations!.selfexaminations,
                            ),
                          ],
                          if (categorizedExaminations.isNotEmpty)
                            _buildExaminationCategory(
                              context,
                              examinationStatus.getHeaderMessage(context),
                              categorizedExaminations,
                            )
                          else
                            const SizedBox.shrink(),
                          if (index == examinationCategoriesOrdering.length - 1)
                            _buildSelfExaminationCategory(
                              context,
                              CardPosition.last,
                              examinationsProvider.examinations!.selfexaminations,
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

  Widget _buildExaminationCategory(
    BuildContext context,
    String header,
    List<CategorizedExamination> categorizedExaminations,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryHeader(header),
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
    );
  }

  Widget _buildSelfExaminationCategory(
    BuildContext context,
    CardPosition cardPosition,
    BuiltList<SelfExaminationPreventionStatus> selfExaminations,
  ) {
    if (selfExaminations.isEmpty) return const SizedBox.shrink();
    final positionedExaminations = selfExaminations.where(
      (selfExamination) => selfExamination.calculateStatus().position == cardPosition,
    );
    if (positionedExaminations.isEmpty) return const SizedBox.shrink();
    final header = positionedExaminations.first.calculateStatus().getHeaderMessage();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryHeader(header),
          Column(
            children: selfExaminations
                .map(
                  (selfExamination) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SelfExaminationCard(
                      onTap: (sex) => AutoRouter.of(context).navigate(
                        SelfExaminationDetailRoute(
                          sex: sex,
                          selfExamination: selfExamination,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String header) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Text(
        header,
        style: const TextStyle(
          color: LoonoColors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
        ),
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
