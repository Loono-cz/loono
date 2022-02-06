import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/settings/app_bar.dart';
import 'package:loono/ui/widgets/settings/checkbox.dart';

import '../../../constants.dart';

class DeleteAccountScreen extends StatefulWidget {
  DeleteAccountScreen({Key? key}) : super(key: key);

  bool _isCheckedHistory = false;
  bool _isCheckedBadge = false;
  bool _isCheckedNotifications = false;
  VoidCallback? onCancel;

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
                  Checkbox_custom(
                    isChecked: widget._isCheckedHistory,
                    text: context.l10n.settings_delete_account_check_box_delete_history,
                    whatIsChecked: (val) {
                      widget._isCheckedHistory = val;
                      setState(() {});
                    },
                  ),
                  Checkbox_custom(
                    isChecked: widget._isCheckedBadge,
                    text: context.l10n.settings_delete_account_check_box_delete_badges,
                    whatIsChecked: (val) {
                      widget._isCheckedBadge = val;
                      setState(() {});
                    },
                  ),
                  Checkbox_custom(
                    isChecked: widget._isCheckedNotifications,
                    text: context.l10n.settings_delete_account_check_box_stop_notifications,
                    whatIsChecked: (val) {
                      widget._isCheckedNotifications = val;
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
                      if (widget._isCheckedBadge &
                          widget._isCheckedNotifications &
                          widget._isCheckedHistory) {
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
                    text: (!widget._isCheckedBadge ||
                            !widget._isCheckedNotifications ||
                            !widget._isCheckedHistory)
                        ? context.l10n.back
                        : context.l10n.remove_account_action,
                  ),
                ),
              ),
            ),
            if (widget._isCheckedBadge & widget._isCheckedNotifications & widget._isCheckedHistory)
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
