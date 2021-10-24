import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/utils/registry.dart';

class OpenSettingsScreen extends StatelessWidget {
  OpenSettingsScreen({Key? key}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(context, showBackButton: false),
      backgroundColor: LoonoColors.settingsBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 18.0),
          child: SingleChildScrollView(
            child: StreamBuilder<User?>(
              stream: _usersDao.watchUser(),
              builder: (context, snapshot) {
                final userNickname = snapshot.data?.nickname;

                return Column(
                  children: [
                    const LoonoAvatar(radius: 60.0),
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
                        AutoRouter.of(context).push(UpdateProfileRoute());
                      },
                    ),
                    const SizedBox(height: 104.0),
                    Row(
                      children: [
                        const Spacer(),
                        SvgPicture.asset('assets/icons/logo-loono.svg'),
                        const SizedBox(width: 16.0),
                        const Text(
                          '100', // TODO: user points
                          style: LoonoFonts.primaryColorStyle,
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      context.l10n.settings_user_points_label.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        color: LoonoColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 48.0),
                    Row(
                      children: [
                        Expanded(
                          child: LoonoButton.light(
                            text: context.l10n.settings_user_points_help_button,
                            onTap: () {
                              print(
                                  'user points help screen'); // TODO: navigate to screen https://cesko-digital.atlassian.net/browse/LOON-236
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: LoonoButton.light(
                            text: context.l10n.settings_leaderboard_button,
                            onTap: () {
                              print(
                                  'leaderboard screen'); // TODO: navigate to screen https://cesko-digital.atlassian.net/browse/LOON-236
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
