import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';

class NoFindingScreen extends StatelessWidget {
  const NoFindingScreen({Key? key, required this.points}) : super(key: key);

  final int points;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: SvgPicture.asset('assets/icons/prevention/award.svg'),
            ),
            SvgPicture.asset('assets/icons/prevention/award_shadow.svg'),
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
            Text(
              context.l10n.no_finding_header,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: LoonoColors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 31),
              child: Text(
                context.l10n.no_finding_desc,
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
