import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_detail_helpers.dart';
import 'package:loono/helpers/examination_extensions.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/helpers/self_examination_category.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/screens/prevention/self_examination/self_faq_section.dart';
import 'package:loono/ui/widgets/badges/self_exam_badges_sheet.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/consultancy/consultancy_card.dart';
import 'package:loono/ui/widgets/consultancy/consultancy_topic.dart';
import 'package:loono/ui/widgets/feedback/feedback_button.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/prevention/harm_disclosure.dart';
import 'package:loono/ui/widgets/prevention/progress_bar/self_examination_ring.dart';
import 'package:loono/ui/widgets/prevention/self_examination/how_it_went_sheet.dart';
import 'package:loono/ui/widgets/space.dart';
import 'package:loono_api/loono_api.dart';

class SelfExaminationDetailScreen extends StatelessWidget {
  const SelfExaminationDetailScreen({
    Key? key,
    required this.sex,
    required this.selfExamination,
  }) : super(key: key);
  final Sex sex;
  final SelfExaminationPreventionStatus selfExamination;

  Widget _buildInterval(String text) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/icons/prevention/calendar.svg'),
          const SizedBox(width: 5),
          Text(
            text.toUpperCase(),
            key: const Key('selfExaminationDetailPage_text_interval'),
            style: LoonoFonts.cardSubtitle,
          ),
        ],
      );

  Widget get _selfExaminationAsset => SvgPicture.asset(
        selfExamination.type.assetPath,
        key: const Key('selfExaminationDetailPage_image'),
        width: 180,
      );

  SelfExaminationStatus? get _lastResultWithoutPlanned =>
      selfExamination.history.lastWhereOrNull((item) => item != SelfExaminationStatus.PLANNED);

  @override
  Widget build(BuildContext context) {
    final currentProgress = selfExaminationProgress(selfExamination.plannedDate);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              SizedBox(
                height: 207,
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(107),
                        child: Container(
                          color: LoonoColors.beigeLighter,
                          width: 207,
                          height: 207,
                          child: _selfExaminationAsset,
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 4,
                      right: 15,
                      child: FeedbackButton(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 21),
                          child: IconButton(
                            key: const Key('selfExaminationDetailPage_backBtn'),
                            onPressed: () {
                              AutoRouter.of(context).pop();
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/arrow_back.svg',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 18),
                              Text(
                                selfExamination.type.l10n_name.replaceFirst(' ', '\n'),
                                key: const Key(
                                  'selfExaminationDetailPage_text_header',
                                ),
                                style: LoonoFonts.headerFontStyle.copyWith(
                                  color: LoonoColors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildInterval(
                                '${context.l10n.once_per} ${context.l10n.month}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                key: const Key('selfExaminationDetailPage_rewardProgressArea'),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selfExamination.history.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _lastResultWithoutPlanned == SelfExaminationStatus.COMPLETED
                              ? LoonoColors.greenSuccess
                              : LoonoColors.grey,
                        ),
                        child: _lastResultWithoutPlanned == SelfExaminationStatus.COMPLETED
                            ? const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 26,
                              )
                            : null,
                      ),
                    ),
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () => showSelfExamBadgesSheet(
                            context,
                            selfExamination.points,
                            selfExamination.history,
                            currentProgress,
                            selfExamination.type,
                          ),
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: CustomPaint(
                              painter: SelfExaminationRing(
                                backgroundColor: LoonoColors.primaryWashed,
                                progress: currentProgress,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const LoonoPointIcon(width: 16.0),
                                  const SizedBox(width: 6.0),
                                  Text(
                                    selfExamination.points.toString(),
                                    style: LoonoFonts.primaryColorStyle.copyWith(
                                      color: LoonoColors.primaryEnabled,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (selfExamination.plannedDate == null)
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: LoonoColors.redButton,
                                  ),
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: LoonoColors.primaryWashed,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Container(
                            color: Colors.white,
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 11,
              ),
              if (selfExamination.plannedDate == null)
                Text(
                  context.l10n.start_with_self_examination.toUpperCase(),
                  style: LoonoFonts.cardSubtitle,
                )
              else if (DateTime.now()
                  .isAfter(selfExamination.plannedDate?.toDateTime() as DateTime))
                Text(
                  context.l10n.do_self_examination.toUpperCase(),
                  style: LoonoFonts.cardSubtitle,
                )
              else
                Text(
                  "${context.l10n.next_self_examination.toUpperCase()} ${DateFormat('d. M. yyyy', 'cs-CZ').format(selfExamination.plannedDate?.toDateTime() as DateTime)}",
                  style: LoonoFonts.cardSubtitle,
                ),
              const SizedBox(
                height: 34,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Expanded(
                      child: LoonoButton(
                        key: const Key('selfExaminationDetailPage_button_selfExamPerformed'),
                        text: sex == Sex.MALE
                            ? context.l10n.self_examination_done_male
                            : context.l10n.self_examination_done_female,
                        enabled: selfExamination.calculateStatus() ==
                                const SelfExaminationCategory.active() ||
                            selfExamination.plannedDate?.toDateTime().isBefore(DateTime.now()) ==
                                true ||
                            selfExamination.calculateStatus() ==
                                const SelfExaminationCategory.first(),
                        onTap: () {
                          showHowItWentSheet(context, sex, selfExamination);
                        },
                      ),
                    ),
                    const SizedBox(width: 19),
                    Expanded(
                      child: LoonoButton.light(
                        key: const Key('selfExaminationDetailPage_button_howToSelfExam'),
                        text: context.l10n.how_to_self_examination,
                        onTap: () => AutoRouter.of(context).push(
                          EducationalVideoRoute(sex: sex, selfExamination: selfExamination),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SelfFaqSection(
                key: const Key('selfExaminationDetailPage_faqSection'),
                selfExaminationType: selfExamination.type,
              ),
              const CustomSpacer.vertical(20),
              ConsultancyCard(
                topic: ConsultancyTopic.selfExamination(selfExaminationType: selfExamination.type),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
                child: harmDisclosureWidget(context, selfExamination.type),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
