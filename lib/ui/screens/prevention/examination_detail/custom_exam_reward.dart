import 'package:badges/badges.dart' as b;
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class CustomExamReward extends StatelessWidget {
  const CustomExamReward({
    Key? key,
    required this.examinationType,
    required this.categorizedExamination,
  }) : super(key: key);

  final ExaminationType examinationType;
  final CategorizedExamination categorizedExamination;

  DateTime get actualDate => DateTime.now();

  DateTime? get plannedDate {
    final date = categorizedExamination.examination.plannedDate;
    if (date == null) return null;
    return date.isBefore(actualDate) ? null : date;
  }

  bool get isPlannedDate => plannedDate != null;

  DateTime? get lastConfirmedDate => categorizedExamination.examination.lastConfirmedDate;

  int get recommendedIntervalInMonths =>
      categorizedExamination.examination.intervalYears.toInt() * 12;

  int get recommendedIntervalInMonthsMinusTwoMonths =>
      categorizedExamination.examination.intervalYears.toInt() * 12 - 2;

  bool get isCustomExam =>
      categorizedExamination.examination.examinationCategoryType == ExaminationCategoryType.CUSTOM;

  int get customExamCount => categorizedExamination.examination.count;

  ExaminationCategoryType? get examCategoryType =>
      categorizedExamination.examination.examinationCategoryType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: LoonoColors.greenLight,
        ),
        child: FutureBuilder<BuiltList<Badge?>?>(
          future: registry.get<UserRepository>().getBadges(),
          builder: (context, snapshot) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      context.l10n.examination_detail_rewards_for_custom_examination,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 10),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              children: [
                                b.Badge(
                                  showBadge: false,
                                  badgeColor: LoonoColors.red,
                                  position: b.BadgePosition.topStart(top: -10, start: 27),
                                  padding: const EdgeInsets.all(4),
                                  badgeContent: const Icon(
                                    Icons.close,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
                                        backgroundColor: Colors.white,
                                        child: b.Badge(
                                          showBadge: customExamCount >= index + 1,
                                          badgeColor: LoonoColors.green,
                                          padding: const EdgeInsets.all(4),
                                          badgeContent: const Icon(
                                            Icons.check,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          position: b.BadgePosition.bottomEnd(bottom: -8, end: -24),
                                          child: SvgPicture.asset(
                                            'assets/badges_examination/custom_examination/badge'
                                            '${customExamCount >= index + 1 ? '_award.svg' : '_disabled.svg'}',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (customExamCount >= index + 1)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 7.0),
                                          child: Text(
                                            categorizedExamination.examination.points.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 11,
                                              color: LoonoColors.checkBoxMark,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            context.l10n.examination_detail_cusotm_rewards_get_badge_1,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: SvgPicture.asset('assets/icons/points.svg'),
                      ),
                      Text(
                        ' ${categorizedExamination.examination.points.toString()} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          color: LoonoColors.checkBoxMark,
                        ),
                      ),
                      Text(
                        context.l10n.examination_detail_rewards_get_badge_3,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

enum RewardState { reward, lastMonthValidity, invisible }

enum BadgeState { normalBadge, greenBadge, redBadge }
