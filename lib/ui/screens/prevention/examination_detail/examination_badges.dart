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

  bool get isPlannedDate => categorizedExamination.examination.plannedDate != null;

  DateTime get actualDate => DateTime.now();

  DateTime? get lastConfirmedDate => categorizedExamination.examination.lastConfirmedDate;

  int get recommendedIntervalInMonths =>
      categorizedExamination.examination.intervalYears.toInt() * 12;

  int get recommendedIntervalInMonthsMinusTwoMonths =>
      categorizedExamination.examination.intervalYears.toInt() * 12 - 2;

  String badgeCZ(BadgeType? type) {
    switch (type) {
      case BadgeType.COAT:
        return 'superhrdinský plášť';
      case BadgeType.TOP:
        return 'superhrdinský top';
      case BadgeType.BELT:
        return 'superhrdinský opasek';
      case BadgeType.SHOES:
        return 'superhrdinské boty';
      case BadgeType.GLOVES:
        return 'superhrdinské rukavice';
      case BadgeType.HEADBAND:
        return 'superhrdinskou čelenku';
      case BadgeType.GLASSES:
        return 'superhrdinské brýle';
      case BadgeType.SHIELD:
        return 'superhrdinský štít';
      case BadgeType.PAULDRONS:
        return 'superhrdinské nárameníky';
      default:
        return '';
    }
  }

  bool _showGreenBadge(Badge? data, int index) {
    final recommendedIntervalTransferToDate = DateTime(
      actualDate.year,
      actualDate.month - recommendedIntervalInMonthsMinusTwoMonths,
      actualDate.day,
    );

    /**
        if (isLastConfirmedDateOlder < 0)
        "is older than";
        else if (isLastConfirmedDateOlder == 0)
        "is the same time as";
        else
        "is newer (not older) than";
     */

    final isLastConfirmedDateOlder =
        lastConfirmedDate?.compareTo(recommendedIntervalTransferToDate);

    if (categorizedExamination.examination.state == ExaminationStatus.CONFIRMED &&
        !isPlannedDate &&
        ((isLastConfirmedDateOlder == 1) || (isLastConfirmedDateOlder == 0)) &&
        index + 1 == data?.level) {
      return true;
    } else {
      return false;
    }
  }

  bool _showRedBadge(Badge? data, [int? index]) {
    final recommendedIntervalTransferToDateMinusTwoMonths = DateTime(
      actualDate.year,
      actualDate.month - recommendedIntervalInMonthsMinusTwoMonths,
      actualDate.day,
    );
    final isLastConfirmedDateOlderMinusTwoMonths =
        lastConfirmedDate?.compareTo(recommendedIntervalTransferToDateMinusTwoMonths);
    final recommendedIntervalTransferToDate =
        DateTime(actualDate.year, actualDate.month - recommendedIntervalInMonths, actualDate.day);
    final isLastConfirmedDateOlder =
        lastConfirmedDate?.compareTo(recommendedIntervalTransferToDate);
    if (lastConfirmedDate != null &&
        !isPlannedDate &&
        isLastConfirmedDateOlderMinusTwoMonths! < 0 &&
        isLastConfirmedDateOlder! > 0 &&
        ((index == null) || (index + 1 == data?.level))) {
      return true;
    } else {
      return false;
    }
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
                          return Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              children: [
                                b.Badge(
                                  showBadge: _showRedBadge(badge, index),
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
                                          showBadge: _showGreenBadge(badge, index),
                                          badgeColor: LoonoColors.green,
                                          padding: const EdgeInsets.all(4),
                                          badgeContent: const Icon(
                                            Icons.check,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          position: b.BadgePosition.bottomEnd(bottom: -8, end: -24),
                                          child: Image.asset(
                                            'assets/badges_examination/${examinationType.toString().toLowerCase()}'
                                            '/level_${badge != null && badge.type.name == categorizedExamination.examination.badge?.name && badge.level >= index + 1 ? '${index + 1}.png' : '${index + 1}_disabled.png'}',
                                          ),
                                        ),
                                      ),
                                      if (_showRedBadge(badge, index))
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
                if (_showRedBadge(badge))
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
                              ' ${badgeCZ(categorizedExamination.examination.badge)}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (_showPointsText(badge) || badge == null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              context.l10n.examination_detail_rewards_get_badge_1,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            children: [
                              Text(
                                '${badgeCZ(categorizedExamination.examination.badge)} ',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${context.l10n.examination_detail_rewards_get_badge_2} ',
                                style: const TextStyle(fontSize: 12),
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
