import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/prevention/progress_bar/progress_icons.dart';
import 'package:loono_api/loono_api.dart';

Future<void> showSelfExamBadgesSheet(
  BuildContext context,
  int points,
  BuiltList<SelfExaminationStatus> history,
  double progress,
  SelfExaminationType examinationType,
) async {
  await showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    backgroundColor: LoonoColors.settingsBackground,
    builder: (BuildContext context) {
      final validStatuses = history.where(
        (item) => (item == SelfExaminationStatus.COMPLETED),
      );
      final showShieldLevel = (validStatuses.length / 3).floor();
      return SizedBox(
        height: 250,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  context.l10n.self_examination_rewards,
                  style: const TextStyle(
                    fontSize: 16,
                    color: LoonoColors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 78,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, badgeIndex) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: badgeIndex == 0 ? 18 : 0,
                        right: badgeIndex == 4 ? 18 : 0,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 8,
                            ),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: badgeIndex <= showShieldLevel
                                  ? Center(
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: SvgPicture.asset(
                                          _getEnabledBadgeAsset(
                                            examinationType,
                                            badgeIndex + 1,
                                          ),
                                        ),
                                      ),
                                    )
                                  : _getDisabledBadge(
                                      examinationType,
                                      badgeIndex + 1,
                                      40,
                                      40,
                                    ),
                            ),
                          ),
                          if (badgeIndex <= showShieldLevel)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  3,
                                  (iconIndex) {
                                    final absIndex = (badgeIndex * 3) + iconIndex;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 1.5,
                                      ),
                                      child: absIndex < validStatuses.length
                                          ? const SuccessIcon()
                                          : absIndex < validStatuses.length + 1
                                              ? ProgressIcon(
                                                  progress: progress,
                                                )
                                              : const EmptyIcon(),
                                    );
                                  },
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 12, height: 1.5),
                    children: [
                      TextSpan(
                        text: context.l10n.self_examination_reward_description_start,
                      ),
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 7.0),
                          child: LoonoPointIcon(),
                        ),
                      ),
                      TextSpan(
                        text: points.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: LoonoColors.primaryEnabled,
                        ),
                      ),
                      TextSpan(
                        text: _getRewardDescriptionEnd(examinationType, context),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

String _getDisabledBadgeAsset(SelfExaminationType type, int level) {
  switch (type) {
    case SelfExaminationType.SKIN:
      return 'assets/badges/pauldrons/disabled_level_$level.svg';
    default:
      return 'assets/badges/shield/shield_disabled.png';
  }
}

Widget _getDisabledBadge(
  SelfExaminationType type,
  int level,
  double width,
  double height,
) {
  final asset = _getDisabledBadgeAsset(type, level);
  return asset.contains('.svg')
      ? SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
            asset,
          ),
        )
      : Image.asset(
          asset,
          width: width,
          height: height,
        );
}

String _getEnabledBadgeAsset(SelfExaminationType type, int level) {
  var path = 'assets/badges/';
  switch (type) {
    case SelfExaminationType.SKIN:
      path += 'pauldrons';
      break;
    default:
      path += 'shield';
      break;
  }
  return '$path/reward_level_$level.svg';
}

String _getRewardDescriptionEnd(
  SelfExaminationType type,
  BuildContext context,
) {
  switch (type) {
    case SelfExaminationType.SKIN:
      return context.l10n.self_examination_reward_description_end_pauldrons;
    default:
      return context.l10n.self_examination_reward_description_end_shield;
  }
}
