import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/date_without_day.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/models/donate_user_info.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/services/examinations_service.dart';
import 'package:loono/services/secure_storage_service.dart';
import 'package:loono/ui/screens/settings/settings_bottom_sheet.dart';
import 'package:loono/ui/widgets/settings/avatar.dart';
import 'package:loono/ui/widgets/settings/update_profile_item.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({
    Key? key,
    required this.changePage,
    this.expandNotSection,
  }) : super(key: key);
  final Function(SettingsPage) changePage;
  final bool? expandNotSection;
  @override
  UpdateProfileScreenState createState() => UpdateProfileScreenState();
}

class UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _usersDao = registry.get<DatabaseService>().users;
  final registryDonate = registry.get<SecureStorageService>();
  DonateUserInfo? donateInfo;
  bool? isNotificationSwitched = true;
  User? user;
  bool? expandNotSection;

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
  void initState() {
    registryDonate.getDonateInfoData().then((value) {
      setState(() {
        donateInfo = value;
        isNotificationSwitched = donateInfo != null ? donateInfo?.showNotification : true;
        user = null;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<User?>(
        stream: _usersDao.watchUser(),
        builder: (context, snapshot) {
          user = snapshot.data;
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
                  userSettingSection(
                    const Key(''),
                    context,
                    user,
                    birthDateWithoutDay,
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  notificationSection(context),
                  const SizedBox(height: 80.0),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget userSettingSection(
    Key key,
    BuildContext context,
    User? user,
    DateWithoutDay? birthDateWithoutDay,
  ) {
    const itemSpacing = SizedBox(height: 16.0);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: const Key('ExpansionTileUserDataSection'),
          textColor: Colors.black,
          iconColor: Colors.black,
          backgroundColor: LoonoColors.expandTileColor,
          collapsedBackgroundColor: LoonoColors.expandTileColor,
          title: Text(
            context.l10n.user_data_label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: LoonoAvatar(),
                        ),
                        TextButton(
                          onPressed: () => widget.changePage(SettingsPage.SettingsPhotoPage),
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget notificationSection(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: widget.expandNotSection ?? false,
          key: const Key('ExpansionTileNotificationSection'),
          textColor: Colors.black,
          iconColor: Colors.black,
          backgroundColor: LoonoColors.expandTileColor,
          collapsedBackgroundColor: LoonoColors.expandTileColor,
          title: Text(
            context.l10n.notification_settings_label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Výzva k darování'),
                    Switch(
                      value: isNotificationSwitched!,
                      onChanged: (value) async {
                        await registryDonate.storeDonateInfoData(
                          DonateUserInfo(
                            lastOpened: donateInfo?.lastOpened ?? DateTime.now(),
                            showNotification: value,
                          ),
                        );
                        setState(() {
                          isNotificationSwitched = value;
                        });
                      },
                      activeTrackColor: LoonoColors.donateColor,
                      activeColor: Colors.white,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
