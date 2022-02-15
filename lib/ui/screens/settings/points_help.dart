import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/points_display.dart';

class PointsHelpScreen extends StatelessWidget {
  const PointsHelpScreen({Key? key, required this.changePage}) : super(key: key);

  final Function(SettingsPage) changePage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(context.l10n.points, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 20),
            Text(context.l10n.points_info, style: LoonoFonts.fontStyle),
            const Spacer(flex: 3),
            PointsDisplay(),
            const SizedBox(height: 13.0),
            Text(
              context.l10n.points_your_points_desc.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                color: LoonoColors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(flex: 2),
            LoonoButton.light(
              text: context.l10n.leaderboard,
              onTap: () => changePage(SettingsPage.leaderboard),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
