import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/confirmation_dialog.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/ui/widgets/settings/update_profile_item.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({
    Key? key,
    required this.changePage,
  }) : super(key: key);
  final Function(SettingsPage) changePage;

  final _usersDao = registry.get<DatabaseService>().users;

  final termsUrl = 'https://www.loono.cz/podminky-uzivani-mobilni-aplikace';
  final privacyUrl = 'https://www.loono.cz/zasady-ochrany-osobnich-udaju-mobilni-aplikace';

  String _getUserSexValue(BuildContext context, {required Sex? sex}) {
    if (sex == null) return '';
    late final String value;
    switch (sex) {
      case Sex.MALE:
        value = context.l10n.gender_male;
        break;
      case Sex.FEMALE:
        value = context.l10n.gender_female;
        break;
    }
    return value;
  }

  String _getBirthdateValue(DateWithoutDay? dateWithoutDay) {
    if (dateWithoutDay == null) return '';
    final date = DateTime(dateWithoutDay.year, dateWithoutDay.month.index + 1);
    final formattedDate = DateFormat.yMMMM('cs-CZ').format(date);
    return formattedDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    const itemSpacing = SizedBox(height: 10.0);

    return Expanded(
      child: StreamBuilder<User?>(
        stream: _usersDao.watchUser(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          final birthDateWithoutDay = user?.dateOfBirth;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.update_profile_header,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 28.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.photo_header,
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      LoonoAvatar(),
                      TextButton(
                        onPressed: () => changePage(SettingsPage.SettingsPhotoPage),
                        child: Text(
                          context.l10n.action_change,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  UpdateProfileItem(
                    key: const Key('updateProfilePage_updateProfileItem_nickname'),
                    label: context.l10n.update_profile_nickname,
                    value: user?.nickname ?? '',
                    route: EditNicknameRoute(user: user),
                  ),
                  itemSpacing,
                  UpdateProfileItem(
                    key: const Key('updateProfilePage_updateProfileItem_email'),
                    label: context.l10n.update_profile_email,
                    value: user?.email ?? '',
                    route: EditEmailRoute(user: user),
                  ),
                  itemSpacing,
                  UpdateProfileItem(
                    key: const Key('updateProfilePage_updateProfileItem_sex'),
                    label: context.l10n.update_profile_sex,
                    value: _getUserSexValue(context, sex: user?.sex),
                    route: null,
                    enabled: false,
                    messageTitle: context.l10n.update_profile_can_not_edit_sex_title,
                    messageText: context.l10n.update_profile_can_not_edit_sex_message,
                  ),
                  itemSpacing,
                  UpdateProfileItem(
                    key: const Key('updateProfilePage_updateProfileItem_birthdate'),
                    label: context.l10n.update_profile_birthdate,
                    value: _getBirthdateValue(birthDateWithoutDay),
                    route: null,
                    enabled: false,
                    messageTitle: context.l10n.update_profile_can_not_edit_birthday_title,
                    messageText: context.l10n.update_profile_can_not_edit_birthday_message,
                  ),
                  const SizedBox(height: 80.0),
                  Align(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () async {
                            showConfirmationDialog(
                              context,
                              onConfirm: () {
                                AutoRouter.of(context).pushAndPopUntil(
                                  // TODO: After updating a routes do logout processes here instead of in LogoutScreen
                                  const LogoutRoute(),
                                  predicate: (_) => false,
                                );
                                Provider.of<ExaminationsProvider>(context, listen: false)
                                    .clearExaminations();
                              },
                              onCancel: () => AutoRouter.of(context).pop(),
                              content: context.l10n.logout_confirmation_dialog_content,
                            );
                          },
                          child: Text(context.l10n.sign_out_action, style: LoonoFonts.fontStyle),
                        ),
                        const SizedBox(height: 32.0),
                        TextButton(
                          onPressed: () async {
                            if (await canLaunch(privacyUrl)) {
                              await launch(privacyUrl);
                            }
                          },
                          child: Text(
                            context.l10n.update_profile_privacy_action,
                            style: LoonoFonts.fontStyle,
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        TextButton(
                          onPressed: () async {
                            if (await canLaunch(termsUrl)) {
                              await launch(termsUrl);
                            }
                          },
                          child: Text(
                            context.l10n.terms_and_conditions,
                            style: LoonoFonts.fontStyle,
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        TextButton(
                          onPressed: () {
                            AutoRouter.of(context).push(const DeleteAccountRoute());
                            Provider.of<ExaminationsProvider>(context, listen: false)
                                .clearExaminations();
                          },
                          child: Text(
                            context.l10n.remove_account_action,
                            style: LoonoFonts.fontStyle.copyWith(color: LoonoColors.redButton),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                      ],
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
