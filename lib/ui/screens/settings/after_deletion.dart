import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/app_clear.dart';
import 'package:loono_api/loono_api.dart';
import 'package:url_launcher/url_launcher.dart';

class AfterDeletionScreen extends StatefulWidget {
  const AfterDeletionScreen({Key? key, required this.sex}) : super(key: key);
  final Sex sex;

  @override
  State<AfterDeletionScreen> createState() => _AfterDeletionScreenState();
}

class _AfterDeletionScreenState extends State<AfterDeletionScreen> {
  @override
  void initState() {
    super.initState();
    appClear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoonoColors.settingsBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  widget.sex == Sex.MALE
                      ? context.l10n.settings_after_deletion_what_we_can_do_male
                      : context.l10n.settings_after_deletion_what_we_can_do_female,
                  style: LoonoFonts.headerFontStyle,
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    widget.sex == Sex.MALE
                        ? context.l10n.settings_after_deletion_give_as_feetback_male
                        : context.l10n.settings_after_deletion_give_as_feetback_female,
                    style: LoonoFonts.paragraphFontStyle,
                  ),
                ),
              ),
              LoonoButton(
                text: context.l10n.settings_after_deletion_send_as_email,
                onTap: () {
                  launch('mailto:info@loono.cz');
                },
              ),
              const SizedBox(height: 20),
              LoonoButton.light(
                text: context.l10n.login_create_new_account,
                onTap: () => AutoRouter.of(context).replaceAll([const AppStartUpWrapperRoute()]),
              ),
              const SizedBox(height: 122),
            ],
          ),
        ),
      ),
    );
  }
}
