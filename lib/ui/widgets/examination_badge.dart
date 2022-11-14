import 'package:badges/badges.dart' as b;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/models/categorized_examination.dart';
import 'package:loono_api/loono_api.dart';

class ExaminationBadge extends StatelessWidget {
  const ExaminationBadge({
    Key? key,
    required this.categorizedExamination,
    required this.badgeState,
    this.badgeLevel = 1,
    this.disabled = false,
    this.showPoints = false,
    this.alignment = MainAxisAlignment.start,
  }) : super(key: key);

  final CategorizedExamination categorizedExamination;
  final BadgeState badgeState;
  final int badgeLevel;
  final bool disabled;
  final bool showPoints;
  final MainAxisAlignment alignment;

  ExaminationCategoryType? get examCategoryType =>
      categorizedExamination.examination.examinationCategoryType;

  ExaminationType get examinationType => categorizedExamination.examination.examinationType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: examCategoryType ==
                          ExaminationCategoryType
                              .CUSTOM //TODO: customExamCount is probably only for first examination.
                      ? SvgPicture.asset(
                          '${LoonoAssets.examinationCardSuccessIcon}'
                          '${disabled ? '_disabled.svg' : '_award.svg'}', //TODO Logic about custom exam rewards ??
                        )
                      : _buildIcon(),
                ),
              ),
              if (badgeState == BadgeState.redBadge) SvgPicture.asset('assets/icons/ellipse.svg'),
            ],
          ),
        ),
        if (showPoints)
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
    );
  }

  Widget _buildIcon() {
    final path = 'assets/badges_examination/${examinationType.toString().toLowerCase()}/level_';
    return disabled
        ? Image.asset('$path${badgeLevel}_disabled.png')
        : SizedBox(
            width: 40,
            height: 40,
            child: SvgPicture.asset(
              '$path$badgeLevel.svg',
            ),
          );
  }
}

enum BadgeState { normalBadge, greenBadge, redBadge }
