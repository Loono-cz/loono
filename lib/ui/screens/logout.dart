import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/snackbar_message.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/routers/auth_router.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/auth/failures.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/confirmation_dialog.dart';
import 'package:loono/utils/registry.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final _authService = registry.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoonoButton(
                text: context.l10n.logout_screen_success_message,
                onTap: () {},
                enabledColor: LoonoColors.greenSuccess,
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.logout_screen_header,
                style: LoonoFonts.headerFontStyle,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Text(
                  context.l10n.logout_screen_content,
                  style: LoonoFonts.paragraphFontStyle,
                ),
              ),
              LoonoButton(
                text: context.l10n.login,
                onTap: () => AutoRouter.of(context).push(LoginRoute()),
              ),
              const SizedBox(height: 20),
              LoonoButton(
                text: context.l10n.use_app_without_account,
                enabled: false,
                textColor: LoonoColors.black,
                onTap: () async {
                  final authUserResult = await _authService.signInAnonymously();
                  authUserResult.fold(
                    (failure) {
                      failure.maybeWhen(
                        network: (_) => showConfirmationDialog(
                          context,
                          onConfirm: () => AutoRouter.of(context).pop(),
                          confirmationButtonLabel: context.l10n.ok_action,
                          content: context.l10n.create_account_anonymous_login_connection_error,
                        ),
                        orElse: () =>
                            showSnackBarError(context, message: failure.getMessage(context)),
                      );
                    },
                    (authUser) => AutoRouter.of(context).push(NicknameRoute()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
