import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({
    Key? key,
    required this.changePage,
  }) : super(key: key);

  final Function(SettingsPage) changePage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.leaderboard,
                  style: const TextStyle(fontSize: 24),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: LoonoPointIcon(color: LoonoColors.primary, width: 20.0),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // TODO: Fetch and display real leaderboard values
            Flexible(
              child: ListView.separated(
                itemCount: 6,
                shrinkWrap: true,
                separatorBuilder: (_, i) => i == 2
                    ? Divider(
                        color: LoonoColors.leaderboardPrimary,
                        indent: MediaQuery.of(context).size.width / 4,
                        endIndent: MediaQuery.of(context).size.width / 4,
                      )
                    : const SizedBox.shrink(),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.only(left: 4.0, right: 16.0),
                    title: Row(
                      children: [
                        Text('${index + 1}.'),
                        const SizedBox(width: 10.0),
                        const CustomLoonoAvatar.network(radius: 27, url: ''),
                        const SizedBox(width: 10.0),
                        const Text('uživatel'),
                      ],
                    ),
                    trailing: Text(
                      '0',
                      style: LoonoFonts.headerFontStyle.copyWith(
                        color: LoonoColors.leaderboardPrimary,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            LoonoButton.light(
              text: context.l10n.leaderboard_points_help_button,
              onTap: () => changePage(SettingsPage.points),
            ),
          ],
        ),
      ),
    );
  }
}
