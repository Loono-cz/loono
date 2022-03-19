import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono_api/loono_api.dart';

class LeaderboardTile extends StatelessWidget {
  const LeaderboardTile({Key? key, required this.user, required this.position}) : super(key: key);

  final LeaderboardUser user;
  final int position;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 4.0, right: 16.0),
      title: Row(
        children: [
          Text('$position.'),
          const SizedBox(width: 10.0),
          if (user.profileImageUrl != null)
            CustomLoonoAvatar.network(
              radius: 27,
              url: user.profileImageUrl,
              borderWidth: 3,
            )
          else
            const LoonoAvatarWrapper(
              borderWidth: 3,
              child: DefaultLoonoCircleAvatar(radius: 27),
            ),
          const SizedBox(width: 10.0),
          Flexible(child: Text(user.name)),
          if (user.isThisMe == true) ...[
            const SizedBox(width: 10.0),
            Container(
              key: const Key('leaderboardPage_leaderboardTile_isThisMeCircle'),
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: LoonoColors.primaryEnabled,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
      trailing: Text(
        user.points.toString(),
        style: LoonoFonts.headerFontStyle.copyWith(
          color: LoonoColors.leaderboardPrimary,
        ),
      ),
    );
  }
}
