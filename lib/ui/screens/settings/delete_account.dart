import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/flushbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/ui/widgets/settings/checkbox.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool _isCheckedHistory = false;
  bool _isCheckedBadge = false;
  bool _isCheckedNotifications = false;

  bool get _areAllChecked => _isCheckedBadge & _isCheckedNotifications & _isCheckedHistory;

  Sex get _sex {
    final user = registry.get<DatabaseService>().users.user;
    return user?.sex ?? Sex.MALE;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(context),
      backgroundColor: LoonoColors.settingsBackground,
      body: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                height: 407,
                width: 297,
                child: SvgPicture.asset('assets/icons/delete_account_illustration.svg'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 34.0, left: 17),
            child: Text(
              context.l10n.settings_delete_account_we_will_miss_you,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 88.0),
            child: Wrap(
              direction: Axis.vertical,
              spacing: 40,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _isCheckedHistory = !_isCheckedHistory),
                  child: CheckboxCustom(
                    key: const Key('deleteAccountPage_checkBox_deleteCheckups'),
                    isChecked: _isCheckedHistory,
                    text: context.l10n.settings_delete_account_check_box_delete_history,
                    whatIsChecked: (val) => setState(() => _isCheckedHistory = val),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _isCheckedBadge = !_isCheckedBadge),
                  child: CheckboxCustom(
                    key: const Key('deleteAccountPage_checkBox_deleteBadges'),
                    isChecked: _isCheckedBadge,
                    text: context.l10n.settings_delete_account_check_box_delete_badges,
                    whatIsChecked: (val) => setState(() => _isCheckedBadge = val),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _isCheckedNotifications = !_isCheckedNotifications),
                  child: CheckboxCustom(
                    key: const Key('deleteAccountPage_checkBox_stopNotifications'),
                    isChecked: _isCheckedNotifications,
                    text: context.l10n.settings_delete_account_check_box_stop_notifications,
                    whatIsChecked: (val) => setState(() => _isCheckedNotifications = val),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Align(
              alignment: const Alignment(0.00, 0.60),
              child: SizedBox(
                height: 65,
                width: 339,
                child: LoonoButton(
                  onTap: () {
                    if (_areAllChecked) {
                      final gender = _sex;
                      showCupertinoDialog<void>(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          content: Text(
                            context.l10n.settings_delete_account_alert,
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          actions: <CupertinoDialogAction>[
                            CupertinoDialogAction(
                              key: const Key('deleteAccountPage_confirmationDialog_cancelBtn'),
                              onPressed: () {
                                AutoRouter.of(context).pop();
                              },
                              child: Text(context.l10n.cancel),
                            ),
                            CupertinoDialogAction(
                              key: const Key('deleteAccountPage_confirmationDialog_yesBtn'),
                              child: Text(context.l10n.settings_delete_account_delete),
                              onPressed: () async {
                                final res = await registry.get<UserRepository>().deleteAccount();
                                if (res) {
                                  showFlushBarSuccess(
                                    context,
                                    context.l10n.settings_after_deletion_deleted,
                                  );
                                  await AutoRouter.of(context).pop();
                                  await AutoRouter.of(context)
                                      .push(AfterDeletionRoute(sex: gender));
                                } else {
                                  await AutoRouter.of(context).pop();
                                  showFlushBarError(
                                    context,
                                    context.l10n.something_went_wrong,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      AutoRouter.of(context).pop();
                    }
                  },
                  text: (!_areAllChecked) ? context.l10n.back : context.l10n.remove_account_action,
                ),
              ),
            ),
          ),
          if (_areAllChecked)
            Positioned(
              child: Align(
                alignment: const Alignment(0.00, 0.85),
                child: SizedBox(
                  height: 65,
                  width: 339,
                  child: LoonoButton.light(
                    onTap: () {
                      AutoRouter.of(context).pop();
                    },
                    text: context.l10n.cancel,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
