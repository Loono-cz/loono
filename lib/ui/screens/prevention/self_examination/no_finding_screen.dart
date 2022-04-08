import 'package:auto_route/auto_route.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono_api/loono_api.dart';

class NoFindingScreen extends StatelessWidget {
  const NoFindingScreen({
    Key? key,
    required this.points,
    required this.history,
  }) : super(key: key);

  final int points;
  final BuiltList<SelfExaminationStatus> history;

  @override
  Widget build(BuildContext context) {
    final validResults = history.where((item) => item == SelfExaminationStatus.COMPLETED);
    final awardLevel = (validResults.length / 3).floor() + 1;
    final receivedShield = validResults.isEmpty || (validResults.length + 1) % 3 == 0;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (receivedShield)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: SvgPicture.asset('assets/badges/shield/reward_level_$awardLevel.svg'),
                  ),
                  Image.asset(
                    'assets/icons/prevention/award_shadow.png',
                    width: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 29, bottom: 10),
                    child: Text(
                      context.l10n.no_finding_getting,
                      style: const TextStyle(
                        fontSize: 14,
                        color: LoonoColors.grey,
                      ),
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const _SuccessIcon(),
                      const SizedBox(
                        width: 10,
                      ),
                      if (validResults.length % 3 == 0)
                        const _EmptyIcon()
                      else
                        const _SuccessIcon(),
                      const SizedBox(
                        width: 10,
                      ),
                      const _EmptyIcon(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(context.l10n.your_progress),
                  const SizedBox(
                    height: 125,
                  )
                ],
              ),
            Text(
              receivedShield
                  ? context.l10n.no_finding_header
                  : context.l10n.no_findings_progress_header,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: LoonoColors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 31),
              child: Text(
                receivedShield
                    ? context.l10n.no_finding_desc
                    : context.l10n.no_findings_progress_desc,
                style: const TextStyle(
                  fontSize: 14,
                  color: LoonoColors.grey,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                  width: 30,
                  child: SvgPicture.asset('assets/icons/logo-loono.svg'),
                ),
                Text(
                  points.toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: LoonoColors.primaryEnabled,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 58),
              child: LoonoButton(
                key: const Key('noFindingRewardPage_btn_continue'),
                text: context.l10n.continue_info,
                onTap: () {
                  AutoRouter.of(context).popUntilRouteWithName(MainRoute.name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: LoonoColors.greenSuccess,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

class _EmptyIcon extends StatelessWidget {
  const _EmptyIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 4, color: LoonoColors.primaryWashed),
      ),
    );
  }
}
