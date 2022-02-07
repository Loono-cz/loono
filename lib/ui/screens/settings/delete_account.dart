import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/ui/widgets/settings/checkbox.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key, this.onCancel}) : super(key: key);

  static late bool _isCheckedHistory = false;
  static late bool _isCheckedBadge = false;
  static late bool _isCheckedNotifications = false;
  final VoidCallback? onCancel;

  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingsAppBar(context),
      backgroundColor: LoonoColors.settingsBackground,
      body: Container(
        child: Stack(
          children: [
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
                  CheckboxCustom(
                    isChecked: DeleteAccountScreen._isCheckedHistory,
                    text: context.l10n.settings_delete_account_check_box_delete_history,
                    whatIsChecked: (val) {
                      DeleteAccountScreen._isCheckedHistory = val;
                      setState(() {});
                    },
                  ),
                  CheckboxCustom(
                    isChecked: DeleteAccountScreen._isCheckedBadge,
                    text: context.l10n.settings_delete_account_check_box_delete_badges,
                    whatIsChecked: (val) {
                      DeleteAccountScreen._isCheckedBadge = val;
                      setState(() {});
                    },
                  ),
                  CheckboxCustom(
                    isChecked: DeleteAccountScreen._isCheckedNotifications,
                    text: context.l10n.settings_delete_account_check_box_stop_notifications,
                    whatIsChecked: (val) {
                      DeleteAccountScreen._isCheckedNotifications = val;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
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
            Positioned(
              child: Align(
                alignment: const Alignment(0.00, 0.60),
                child: SizedBox(
                  height: 65,
                  width: 339,
                  child: LoonoButton(
                    onTap: () {
                      if (DeleteAccountScreen._isCheckedBadge &
                          DeleteAccountScreen._isCheckedNotifications &
                          DeleteAccountScreen._isCheckedHistory) {
                        showCupertinoDialog<void>(
                          context: context,
                          builder: (BuildContext context) => CupertinoAlertDialog(
                            content: Text(
                              context.l10n.settings_delete_account_alert,
                              style: const TextStyle(fontSize: 17),
                            ),
                            actions: <CupertinoDialogAction>[
                              CupertinoDialogAction(
                                child: Text(context.l10n.cancel),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text(context.l10n.settings_delete_account_delete),
                                onPressed: () {
                                  // TODO: Call API to delete account.
                                },
                              )
                            ],
                          ),
                        );
                      } else {
                        AutoRouter.of(context).pop();
                      }
                    },
                    text: (!DeleteAccountScreen._isCheckedBadge ||
                            !DeleteAccountScreen._isCheckedNotifications ||
                            !DeleteAccountScreen._isCheckedHistory)
                        ? context.l10n.back
                        : context.l10n.remove_account_action,
                  ),
                ),
              ),
            ),
            if (DeleteAccountScreen._isCheckedBadge &
                DeleteAccountScreen._isCheckedNotifications &
                DeleteAccountScreen._isCheckedHistory)
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
      ),
    );
  }
}
