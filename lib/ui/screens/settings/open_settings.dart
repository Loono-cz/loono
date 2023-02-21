import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/services/notification_service.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/confirmation_dialog.dart';
import 'package:loono/ui/widgets/feedback/email_feedback_button.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/ui/widgets/settings/points_display.dart';
import 'package:loono/utils/app_clear.dart';
import 'package:loono/utils/registry.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: LoonoAvatar(radius: 60.0),
                      ),
                      const SizedBox(height: 24.0),
                      if (userNickname != null)
                        Flexible(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userNickname,
                                style: const TextStyle(fontSize: 24),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                              const SizedBox(height: 12.0),
                              PointsDisplay(),
                              const SizedBox(height: 12.0),
                              Text(
                                context.l10n.points_your_points_desc.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: LoonoColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 36.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: LoonoButton.light(
                          text: context.l10n.leaderboard,
                          onTap: () {
                            changePage(SettingsPage.SettingsLeaderboardPage);
                          },
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: LoonoButton.light(
                          text: context.l10n.settings_edit_account_button,
                          onTap: () {
                            changePage(SettingsPage.SettingsEditPage);
                          },
                        ),
                      ),
                    ],
                  ),
                  if (LoonoSizes.isScreenSmall(context))
                    const SizedBox(height: 36.0)
                  else
                    const SizedBox(height: 48.0),
                  if (!Platform.isIOS) ...[
                    Text(
                      context.l10n.donate_label_desc,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: LoonoButton(
                        text: context.l10n.donate_label_btn,
                        onTap: () async {
                          if (await canLaunchUrlString(LoonoStrings.donateUrl)) {
                            await launchUrlString(LoonoStrings.donateUrl);
                          }
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 28.0),
                  Align(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () async {
                            await showAdaptiveConfirmationDialog(
                              context,
                              description: context.l10n.logout_confirmation_dialog_content,
                              confirmationButtonLabel: context.l10n.continue_info,
                              onConfirm: () {
                                appClear().then((value) {
                                  registry.get<NotificationService>().enableNotifications(false);
                                  Provider.of<ExaminationsProvider>(context, listen: false)
                                      .clearExaminations();
                                  AutoRouter.of(context).replaceAll(
                                    [const LogoutRoute()],
                                  );
                                });
                              },
                            );
                          },
                          child: Text(context.l10n.sign_out_action, style: LoonoFonts.fontStyle),
                        ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () async {
                            if (await canLaunchUrlString(LoonoStrings.privacyUrl)) {
                              await launchUrlString(LoonoStrings.privacyUrl);
                            }
                          },
                          child: Text(
                            context.l10n.update_profile_privacy_action,
                            style: LoonoFonts.fontStyle,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () async {
                            if (await canLaunchUrlString(LoonoStrings.termsUrl)) {
                              await launchUrlString(LoonoStrings.termsUrl);
                            }
                          },
                          child: Text(
                            context.l10n.terms_and_conditions,
                            style: LoonoFonts.fontStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 38.0),
                  const EmailFeedbackButton(),
                  const SizedBox(height: 24.0),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
