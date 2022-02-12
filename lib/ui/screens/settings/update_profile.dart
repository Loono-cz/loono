import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/confirmation_dialog.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/ui/widgets/settings/update_profile_item.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart' hide User;

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;

  String _getUserSexValue(BuildContext context, {required Sex sex}) {
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

  DateWithoutDay? _getBirthdateDate(String? dateTimeRaw) {
    if (dateTimeRaw == null) return null;
    final dateTimeMap = jsonDecode(dateTimeRaw) as Map<String, dynamic>;
    final dateWithoutDay = DateWithoutDay.fromJson(dateTimeMap);
    return dateWithoutDay;
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

    return Scaffold(
      appBar: settingsAppBar(context),
      backgroundColor: LoonoColors.settingsBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: StreamBuilder<User?>(
              stream: _usersDao.watchUser(),
              builder: (context, snapshot) {
                final user = snapshot.data;
                final birthDateWithoutDay = _getBirthdateDate(user?.dateOfBirthRaw);

                return Column(
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
                          onPressed: () => AutoRouter.of(context).push(EditPhotoRoute()),
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
                      label: context.l10n.update_profile_nickname,
                      value: user?.nickname ?? '',
                      route: EditNicknameRoute(user: user),
                    ),
                    itemSpacing,
                    UpdateProfileItem(
                      label: context.l10n.update_profile_email,
                      value: user?.email ?? '',
                      route: EditEmailRoute(user: user),
                    ),
                    itemSpacing,
                    UpdateProfileItem(
                      label: context.l10n.update_profile_sex,
                      value: _getUserSexValue(context, sex: user?.sex ?? Sex.MALE),
                      route: null,
                      enabled: false,
                    ),
                    itemSpacing,
                    UpdateProfileItem(
                      label: context.l10n.update_profile_birthdate,
                      value: _getBirthdateValue(birthDateWithoutDay),
                      route: null,
                      enabled: false,
                    ),
                    const SizedBox(height: 80.0),
                    Align(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              showConfirmationDialog(
                                context,
                                onConfirm: () => AutoRouter.of(context).pushAndPopUntil(
                                  // TODO: After updating a routes do logout processes here instead of in LogoutScreen
                                  const LogoutRoute(),
                                  predicate: (_) => false,
                                ),
                                onCancel: () => AutoRouter.of(context).pop(),
                                content: context.l10n.logout_confirmation_dialog_content,
                              );
                            },
                            child: Text(context.l10n.sign_out_action, style: LoonoFonts.fontStyle),
                          ),
                          const SizedBox(height: 41.0),
                          TextButton(
                            onPressed: () {
                              // TODO: Show 'Ochrana osobních údajů'
                            },
                            child: Text(
                              context.l10n.update_profile_privacy_action,
                              style: LoonoFonts.fontStyle,
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          TextButton(
                            onPressed: () => AutoRouter.of(context).push(DeleteAccountRoute()),
                            child: Text(
                              context.l10n.remove_account_action,
                              style: LoonoFonts.fontStyle.copyWith(color: LoonoColors.redButton),
                            ),
                          ),
                        ],
                      ),
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
