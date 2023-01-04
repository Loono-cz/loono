import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/categorized_examination_converter.dart';
import 'package:loono/helpers/examination_category.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/self_examination_category.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/widgets/avatar_bubble_notifier.dart';
import 'package:loono/ui/widgets/consultancy/consultancy_card.dart';
import 'package:loono/ui/widgets/prevention/examination_card.dart';
import 'package:loono/ui/widgets/prevention/self_examination/self_examination_card.dart';
import 'package:loono/ui/widgets/space.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class ExaminationsSheetOverlay extends StatelessWidget {
  const ExaminationsSheetOverlay({Key? key, required this.convertExtent}) : super(key: key);

  final Function(double?) convertExtent;

  @override
  Widget build(BuildContext context) {
    final examinationsProvider = Provider.of<ExaminationsProvider>(context, listen: true);

    return SizedBox.expand(
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          convertExtent(notification.extent);
          return false;
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.75,
          minChildSize: 0.15,
          // controller: scrollDragController,
          builder: (context, scrollController) {
            if (examinationsProvider.loading && examinationsProvider.examinations == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: LoonoColors.primaryEnabled,
                ),
              );
            } else if (examinationsProvider.examinations == null) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(context.l10n.prevention_retry_no_records),
                      TextButton(
                        onPressed: examinationsProvider.fetchExaminations,
                        child: Text(context.l10n.prevention_retry_try_again),
                      ),
                    ],
                  ),
                ),
              );
            }

            final categorized = CategorizedExaminationConverter.convert(
              examinationsProvider.examinations!.examinations.toList(),
            );

            return AvatarBubbleNotifier(
              convertExtent: convertExtent,
              child: Container(
                height: MediaQuery.of(context).size.height * .5,
                decoration: const BoxDecoration(
                  color: LoonoColors.bottomSheetPrevention,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  controller: scrollController,
                  itemCount: examinationCategoriesOrdering.length + 1,
                  // this prevents card flashing/repositioning when there's ongoing sorting on scroll
                  cacheExtent: SelfExaminationType.values.length * EXAMINATION_CARD_HEIGHT +
                      ExaminationType.values.length * EXAMINATION_CARD_HEIGHT,
                  itemBuilder: (context, index) {
                    final itemCount = examinationCategoriesOrdering.length;

                    if (index <= itemCount - 1) {
                      final examinationStatus = examinationCategoriesOrdering.elementAt(index);

                      final categorizedExaminations =
                          categorized.where((e) => e.category == examinationStatus).toList();

                      return Column(
                        children: [
                          if (index == 0) ...[
                            _buildHandle(context),
                            _buildSelfExaminationCategory(
                              context,
                              CardPosition.first,
                              examinationsProvider.examinations!.selfexaminations
                                  .where(
                                    (exam) => exam.calculateStatus().position == CardPosition.first,
                                  )
                                  .toBuiltList(),
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
                              examinationsProvider.examinations!.selfexaminations
                                  .where(
                                    (exam) => exam.calculateStatus().position == CardPosition.last,
                                  )
                                  .toBuiltList(),
                            ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          _buildPlaceholderCard(context, categorized),
                          const CustomSpacer.vertical(20),
                          const ConsultancyCard.prevention(),
                          const CustomSpacer.vertical(68),
                        ],
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
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
            key: ValueKey<String>('exam_category_column_$header'),
            children: categorizedExaminations
                .mapIndexed(
                  (index, e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: ExaminationCard(
                      key: ValueKey<ExaminationType>(e.examination.examinationType),
                      index: index,
                      categorizedExamination: e,
                      onTap: () {
                        AutoRouter.of(context).navigate(
                          ExaminationDetailRoute(
                            categorizedExamination: e,
                          ),
                        );
                      },
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
    final category = positionedExaminations.first.calculateStatus();
    final categoryHeaderName = category.getHeaderMessage(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        key: ValueKey<String>('selfExam_category_column_$categoryHeaderName'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryHeader(categoryHeaderName),
          Column(
            children: selfExaminations
                .map(
                  (selfExamination) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SelfExaminationCard(
                      key: ValueKey<SelfExaminationType>(selfExamination.type),
                      // TODO: different route based on the category
                      selfExamination: selfExamination,
                      onTap: (sex) {
                        final category = selfExamination.calculateStatus();
                        if (category == const SelfExaminationCategory.hasFinding() ||
                            category == const SelfExaminationCategory.hasFindingExpectingResult()) {
                          AutoRouter.of(context).navigate(
                            ResultFromDoctorRoute(
                              sex: sex,
                              selfExamination: selfExamination,
                            ),
                          );
                        } else {
                          AutoRouter.of(context).navigate(
                            SelfExaminationDetailRoute(
                              sex: sex,
                              selfExamination: selfExamination,
                            ),
                          );
                        }
                      },
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
        key: key,
        style: const TextStyle(
          color: LoonoColors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
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
            padding: const EdgeInsets.only(top: 20.0),
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

  Widget _buildPlaceholderCard(BuildContext context, List<CategorizedExamination> categorized) {
    final customExamCount = 10 -
        categorized
            .where(
              (element) =>
                  element.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM,
            )
            .length;
    Widget buildFullExamColumn(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(context.l10n.your_list_of_exam_is_full_warning),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              context.l10n.your_list_of_exam_is_full_disclaimer,
            ),
          ),
        ],
      );
    }

    String getExamLabel(int count) {
      if (count >= 5) {
        return context.l10n.five_more_examinations;
      } else if (count > 1) {
        return context.l10n.less_then_five_exams;
      }

      return context.l10n.only_one_exam;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 26.0),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          DottedBorder(
            color: LoonoColors.primaryEnabled,
            radius: const Radius.circular(20),
            borderType: BorderType.RRect,
            padding: const EdgeInsets.all(0),
            dashPattern: const [4, 5],
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white24,
              ),
              height: 120,
              child: Center(
                child: customExamCount <= 0
                    ? buildFullExamColumn(context)
                    : Text(
                        '${context.l10n.your_list_of_exam_info(customExamCount)} ${getExamLabel(customExamCount)}',
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
