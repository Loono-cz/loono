import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/app_clear.dart';
import 'package:loono/utils/registry.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final _userRepository = registry.get<UserRepository>();

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
                onTap: () async {
                  await _userRepository.createUser();
                  await AutoRouter.of(context)
                      .replaceAll([PreAuthMainRoute(overridenPreventionRoute: LoginRoute())]);
                },
              ),
              const SizedBox(height: 20),
              LoonoButton.light(
                text: context.l10n.use_app_without_account,
                onTap: () async {
                  await _userRepository.createUser();
                  await AutoRouter.of(context).replaceAll([PreAuthMainRoute()]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
