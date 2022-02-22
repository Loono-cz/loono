import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class AfterDeletionScreen extends StatelessWidget {
  const AfterDeletionScreen({Key? key}) : super(key: key);

  Sex get _sex {
    final user = registry.get<DatabaseService>().users.user;
    return user?.sex ?? Sex.MALE;
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
                  _sex == Sex.MALE
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
                    _sex == Sex.MALE
                        ? context.l10n.settings_after_deletion_give_as_feetback_male
                        : context.l10n.settings_after_deletion_give_as_feetback_female,
                    style: LoonoFonts.paragraphFontStyle,
                  ),
                ),
              ),
              LoonoButton(
                text: context.l10n.settings_after_deletion_send_as_email,
                onTap: () {
                  // TODO: Send email.
                },
              ),
              const SizedBox(height: 20),
              LoonoButton.light(
                text: context.l10n.login_create_new_account,
                onTap: () {
                  AutoRouter.of(context).push(const AppStartUpWrapperRoute());
                },
              ),
              const SizedBox(height: 122),
            ],
          ),
        ),
      ),
    );
  }
}
