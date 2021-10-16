import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/user.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/ui/widgets/settings/update_profile_item.dart';
import 'package:loono/utils/registry.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  final _authService = registry.get<AuthService>();
  final _usersDao = registry.get<DatabaseService>().users;

  String _getUserSexValue(BuildContext context, {Sex? sex}) {
    switch (sex) {
      case Sex.male:
        return context.l10n.gender_male;
      case Sex.female:
        return context.l10n.gender_female;
      default:
        return '';
    }
  }

  String _getBirthdateValue(String? dateTimeRaw) {
    if (dateTimeRaw == null) return '';
    final dateTimeMap = jsonDecode(dateTimeRaw) as Map<String, dynamic>;
    final month = dateTimeMap['month'] as String?;
    final year = int.tryParse(dateTimeMap['year'].toString());
    if (month == null || year == null) return '';
    return '$month $year';
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
                          context.l10n.update_profile_photo,
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        LoonoAvatar(),
                        TextButton(
                          onPressed: () {
                            //
                          },
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
                      value: _getUserSexValue(context, sex: user?.sex),
                      route: const EditSexRoute(),
                    ),
                    itemSpacing,
                    UpdateProfileItem(
                      label: context.l10n.update_profile_birthdate,
                      value: _getBirthdateValue(user?.dateOfBirthRaw),
                      route: const EditBirthdateRoute(),
                    ),
                    const SizedBox(height: 80.0),
                    LoonoButton.light(
                      text: context.l10n.sign_out_action,
                      onTap: () async => _authService.signOut(),
                    ),
                    const SizedBox(height: 41.0),
                    Align(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              // TODO: Show 'Ochrana osobních údajů'
                            },
                            child: Text(
                              context.l10n.update_profile_privacy_action,
                              style: const TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 64.0),
                          TextButton(
                            onPressed: () {
                              // TODO: Remove account
                            },
                            child: Text(
                              context.l10n.remove_account_action,
                              style: const TextStyle(fontSize: 14, color: LoonoColors.redButton),
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
