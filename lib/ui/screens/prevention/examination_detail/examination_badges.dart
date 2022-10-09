import 'package:badges/badges.dart' as b;
import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationBadges extends StatelessWidget {
  const ExaminationBadges({
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

  ///Minus 2 months
  DateTime get recommendedIntervalTransferToDate => DateTime(
        actualDate.year,
        actualDate.month - recommendedIntervalInMonthsMinusTwoMonths,
        actualDate.day,
      );

  bool get isLastConfirmedDateOlderMinusTwoMonths =>
      (lastConfirmedDate?.compareTo(
            recommendedIntervalTransferToDate,
          ) ??
          0) >=
      0;

  String _getBadgeName(BadgeType? type, BuildContext context) {
    switch (type) {
      case BadgeType.COAT:
        return context.l10n.examination_detail_rewards_badge_coat;
      case BadgeType.TOP:
        return context.l10n.examination_detail_rewards_badge_top;
      case BadgeType.BELT:
        return context.l10n.examination_detail_rewards_badge_belt;
      case BadgeType.SHOES:
        return context.l10n.examination_detail_rewards_badge_shoes;
      case BadgeType.GLOVES:
        return context.l10n.examination_detail_rewards_badge_gloves;
      case BadgeType.HEADBAND:
        return context.l10n.examination_detail_rewards_badge_headband;
      case BadgeType.GLASSES:
        return context.l10n.examination_detail_rewards_badge_glasses;
      case BadgeType.SHIELD:
        return context.l10n.examination_detail_rewards_badge_shield;
      case BadgeType.PAULDRONS:
        return context.l10n.examination_detail_rewards_badge_pauldrons;
      default:
        return '';
    }
  }

  bool _isBadgeLastInMonthOfValidity(Badge? badge, [int? index]) {
    return lastConfirmedDate != null &&
        !isPlannedDate &&
        !isLastConfirmedDateOlderMinusTwoMonths &&
        ((index == null) || (index + 1 == badge?.level));
  }

  BadgeState _getBadgeState(Badge? data, int index) {
    if (categorizedExamination.examination.state == ExaminationStatus.CONFIRMED &&
        !isPlannedDate &&
        (isLastConfirmedDateOlderMinusTwoMonths) &&
        index + 1 == data?.level) {
      return BadgeState.greenBadge;
    } else if (_isBadgeLastInMonthOfValidity(data, index)) {
      return BadgeState.redBadge;
    }
    return BadgeState.normalBadge;
  }

  bool _showPointsText(Badge? data) {
    final comparedDateMinusRecommendedInterval =
        DateTime(actualDate.year, actualDate.month - recommendedIntervalInMonths, actualDate.day);
    final isLastConfirmedDateOlder =
        lastConfirmedDate?.compareTo(comparedDateMinusRecommendedInterval);
    if (isPlannedDate || isLastConfirmedDateOlder == 1) {
      return true;
    } else {
      return false;
    }
  }

  ExaminationCategoryType? get examCategoryType =>
      categorizedExamination.examination.examinationCategoryType;

  RewardState _getRewardState(Badge? badge) {
    if (badge == null) {
      return RewardState.reward;
    } else if (_isBadgeLastInMonthOfValidity(badge)) {
      return RewardState.lastMonthValidity;
    } else if (_showPointsText(badge)) {
      return RewardState.reward;
    }
    return RewardState.invisible;
  }

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
            final badge = snapshot.data?.toList().firstWhereOrNull(
                  (element) => element?.type.name == categorizedExamination.examination.badge?.name,
                );
            final rewardState = _getRewardState(badge);
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
                      context.l10n.examination_detail_rewards_for_examination,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 10, bottom: 20),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final badgeState = _getBadgeState(badge, index);
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              children: [
                                b.Badge(
                                  showBadge: badgeState == BadgeState.redBadge,
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
                                          showBadge: badgeState == BadgeState.greenBadge,
                                          badgeColor: LoonoColors.green,
                                          padding: const EdgeInsets.all(4),
                                          badgeContent: const Icon(
                                            Icons.check,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          position: b.BadgePosition.bottomEnd(bottom: -8, end: -24),
                                          child: examCategoryType == ExaminationCategoryType.CUSTOM
                                              ? SvgPicture.asset(
                                                  'assets/badges_examination/custom_examination/badge'
                                                  '${badge != null && badge.level >= index + 1 ? '_award.svg' : '_disabled.svg'}',
                                                )
                                              : Image.asset(
                                                  'assets/badges_examination/${examinationType.toString().toLowerCase()}'
                                                  '/level_${badge != null && badge.type.name == categorizedExamination.examination.badge?.name && badge.level >= index + 1 ? '${index + 1}.png' : '${index + 1}_disabled.png'}',
                                                ),
                                        ),
                                      ),
                                      if (badgeState == BadgeState.redBadge)
                                        SvgPicture.asset('assets/icons/ellipse.svg'),
                                    ],
                                  ),
                                ),
                                if (badge != null &&
                                    snapshot.data != null &&
                                    badge.level >= index + 1)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: SvgPicture.asset('assets/icons/points.svg'),
                                        ),
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
                if (rewardState == RewardState.lastMonthValidity && !isCustomExam)
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            context.l10n.examination_detail_rewards_last_month_validity_1,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              context.l10n.examination_detail_rewards_last_month_validity_2,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' ${_getBadgeName(categorizedExamination.examination.badge, context)}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (rewardState == RewardState.reward)
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              isCustomExam
                                  ? context.l10n.examination_detail_cusotm_rewards_get_badge_1
                                  : context.l10n.examination_detail_rewards_get_badge_1,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            children: [
                              if (!isCustomExam)
                                Text(
                                  '${_getBadgeName(categorizedExamination.examination.badge, context)} ',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                )
                              else
                                Container(),
                              if (!isCustomExam)
                                Text(
                                  '${context.l10n.examination_detail_rewards_get_badge_2} ',
                                  style: const TextStyle(fontSize: 12),
                                )
                              else
                                Container(),
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
