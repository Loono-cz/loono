import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/ui/widgets/settings/points_display.dart';
import 'package:loono/utils/registry.dart';
import 'package:package_info_plus/package_info_plus.dart';

class OpenSettingsScreen extends StatelessWidget {
  OpenSettingsScreen({Key? key, required this.changePage}) : super(key: key);

  final Function(SettingsPage) changePage;
  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<User?>(
        stream: _usersDao.watchUser(),
        builder: (context, snapshot) {
          final userNickname = snapshot.data?.nickname;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  LoonoAvatar(radius: 60.0),
                  const SizedBox(height: 24.0),
                  if (userNickname != null)
                    Column(
                      children: [
                        Text(
                          userNickname,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  LoonoButton.light(
                    text: context.l10n.settings_edit_account_button,
                    onTap: () {
                      changePage(SettingsPage.edit);
                    },
                  ),
                  if (LoonoSizes.isScreenSmall(context))
                    const SizedBox(height: 36.0)
                  else
                    const SizedBox(height: 104.0),
                  PointsDisplay(),
                  const SizedBox(height: 12.0),
                  Text(
                    context.l10n.points_your_points_desc.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: LoonoColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (LoonoSizes.isScreenSmall(context))
                    const SizedBox(height: 20.0)
                  else
                    const SizedBox(height: 48.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: LoonoButton.light(
                          text: context.l10n.settings_user_points_help_button,
                          onTap: () {
                            changePage(SettingsPage.points);
                          },
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: LoonoButton.light(
                          text: context.l10n.leaderboard,
                          onTap: () {
                            changePage(SettingsPage.leaderboard);
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 60.0),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, AsyncSnapshot<PackageInfo> snapshot) => Text(
                        '${context.l10n.settings_version} ${snapshot.data?.version ?? ' '}',
                        style: const TextStyle(fontSize: 12, height: -1.2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
