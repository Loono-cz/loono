import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';

class GamificationIntroductionScreen extends StatelessWidget {
  const GamificationIntroductionScreen({Key? key}) : super(key: key);

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
                LoonoButton(
                  text: context.l10n.gamification_introduction_button,
                  onTap: () => AutoRouter.of(context).replaceAll([const MainScreenRouter()]),
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
