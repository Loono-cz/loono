import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/async_button.dart';
import 'package:loono/utils/registry.dart';

class GamificationIntroductionScreen extends StatelessWidget {
  GamificationIntroductionScreen({
    Key? key,
    required this.nickname,
    required this.email,
  }) : super(key: key);

  final String nickname;
  final String email;

  final _userRepository = registry.get<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Superhrdinka Ema\n\nTODO: screen UI',
                  textAlign: TextAlign.center,
                  style: LoonoFonts.bigFontStyle,
                ),
                const Spacer(),
                AsyncLoonoApiButton(
                  text: context.l10n.gamification_introduction_button,
                  asyncCallback: () async {
                    // TODO: temporary - waiting for new Onboarding API, there will be one API call and if it success then continue
                    await _userRepository.updateEmail(email);
                    await _userRepository.updateNickname(nickname);
                    await AutoRouter.of(context).push(const MainScreenRouter());
                    return null;
                  },
                ),
                SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
