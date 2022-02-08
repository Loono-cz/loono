import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/auth/auth_service.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/registry.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final _authService = registry.get<AuthService>();
  final _userRepository = registry.get<UserRepository>();

  @override
  void initState() {
    super.initState();
    _authService.signOut();
    registry.get<DatabaseService>().clearDb();
    // clears saved user avatar and other app's temp data
    registry.get<DefaultCacheManager>().emptyCache();
    // TODO: Calling this after adding the firebase_messaging package in order to delete a fcm token
    // FirebaseMessaging.instance.deleteToken()
  }

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
                onTap: () async {
                  await _userRepository.createUser();
                  await AutoRouter.of(context).push(PreAuthMainRoute());
                },
              ),
              const SizedBox(height: 20),
              LoonoButton.light(
                text: context.l10n.use_app_without_account,
                onTap: () async {
                  await _userRepository.createUser();
                  await AutoRouter.of(context).push(PreAuthMainRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
