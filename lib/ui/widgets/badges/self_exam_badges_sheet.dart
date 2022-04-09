import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/prevention/progress_bar/mini_progress_ring.dart';
import 'package:loono_api/loono_api.dart';

Future<void> showSelfExamBadgesSheet(
  BuildContext context,
  int points,
  BuiltList<SelfExaminationStatus> history,
  double progress,
) async {
  await showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    backgroundColor: LoonoColors.beigeLighter,
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
                                          'assets/badges/shield/reward_level_${badgeIndex + 1}.svg',
                                        ),
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/badges/shield/shield_disabled.png',
                                      width: 40,
                                      height: 40,
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
                                      padding: const EdgeInsets.symmetric(horizontal: 1.5),
                                      child: absIndex < validStatuses.length
                                          ? const _SuccessIcon()
                                          : absIndex < validStatuses.length + 1
                                              ? _ProgressIcon(
                                                  progress: progress,
                                                )
                                              : const _EmptyIcon(),
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
                      TextSpan(text: context.l10n.self_examination_reward_description_start),
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
                      TextSpan(text: context.l10n.self_examination_reward_description_end),
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

class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: LoonoColors.greenSuccess,
        borderRadius: BorderRadius.circular(9),
      ),
      child: const Icon(
        Icons.check,
        size: 14,
        color: Colors.white,
      ),
    );
  }
}

class _EmptyIcon extends StatelessWidget {
  const _EmptyIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(width: 2, color: LoonoColors.primaryWashed),
      ),
    );
  }
}

class _ProgressIcon extends StatelessWidget {
  const _ProgressIcon({Key? key, required this.progress}) : super(key: key);

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18,
      height: 18,
      child: CustomPaint(
        painter: MiniProgressRing(
          backgroundColor: LoonoColors.primaryWashed,
          progress: progress,
        ),
      ),
    );
  }
}
