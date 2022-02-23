import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/examination_types.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/screens/prevention/self_examination/self_faq_section.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/prevention/progress_bar/self_examination_ring.dart';
import 'package:loono/ui/widgets/prevention/self_examination/how_it_went_sheet.dart';
import 'package:loono_api/loono_api.dart';

class SelfExaminationDetailScreen extends StatelessWidget {
  const SelfExaminationDetailScreen({
    Key? key,
    required this.sex,
    required this.selfExamination,
  }) : super(key: key);
  final Sex sex;
  final SelfExaminationPreventionStatus selfExamination;

  Widget _calendarRow(String text, {VoidCallback? onTap}) => GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/prevention/calendar.svg'),
            const SizedBox(width: 5),
            Text(
              text,
              style: LoonoFonts.cardSubtitle,
            ),
          ],
        ),
      );

  Widget get _selfExaminationAsset => SvgPicture.asset(selfExamination.type.assetPath, width: 180);

  double _selfExaminationProgress() {
    if (selfExamination.plannedDate?.toDateTime() != null) {
      final date = selfExamination.plannedDate?.toDateTime() as DateTime;
      final planedDate = selfExamination.plannedDate?.toDateTime().millisecondsSinceEpoch;
      final startDate = DateTime(date.year, date.month - 1, date.day).millisecondsSinceEpoch;
      final todayDate = DateTime.now().millisecondsSinceEpoch;
      final total = planedDate! - startDate;
      final current = todayDate - startDate;
      final percentage = (current / total) * 100;
      return percentage.clamp(0, 1);
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 16.0,
                ),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 16),
                            child: IconButton(
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
                                  selfExamination.type.l10n_name,
                                  style: LoonoFonts.headerFontStyle.copyWith(
                                    color: LoonoColors.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _calendarRow(
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
                            color: selfExamination.history.last.name ==
                                    SelfExaminationStatus.COMPLETED.name
                                ? LoonoColors.greenSuccess
                                : LoonoColors.grey,
                          ),
                          child: selfExamination.history.last.name ==
                                  SelfExaminationStatus.COMPLETED.name
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
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: CustomPaint(
                              painter: SelfExaminationRing(
                                backgroundColor: LoonoColors.primaryWashed,
                                progress: _selfExaminationProgress(),
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
                          border: Border.all(color: LoonoColors.primaryWashed, width: 4),
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
                          text: sex == Sex.MALE
                              ? context.l10n.self_examination_done_male
                              : context.l10n.self_examination_done_female,
                          enabled: selfExamination.plannedDate == null ||
                              (selfExamination.plannedDate != null &&
                                  DateTime.now().isAfter(
                                    selfExamination.plannedDate?.toDateTime() as DateTime,
                                  )),
                          onTap: () {
                            showHowItWentSheet(context, sex);
                          },
                        ),
                      ),
                      const SizedBox(width: 19),
                      Expanded(
                        child: LoonoButton.light(
                          text: context.l10n.how_to_self_examination,
                          onTap: () => AutoRouter.of(context).push(EducationalVideoRoute(sex: sex)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SelfFaqSection(
                  selfExaminationType: selfExamination.type,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
