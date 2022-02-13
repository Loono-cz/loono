import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';

class FillOnboardingFormLaterScreen extends StatelessWidget {
  const FillOnboardingFormLaterScreen({Key? key}) : super(key: key);

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
                  'Z kina odcházíš taky dvě minuty před koncem?\n\nTODO: screen UI',
                  textAlign: TextAlign.center,
                  style: LoonoFonts.bigFontStyle,
                ),
                const Spacer(),
                LoonoButton(
                  text: context.l10n.fill_form_later_button_1,
                  onTap: () => AutoRouter.of(context).popForced(),
                ),
                const SizedBox(height: 8),
                LoonoButton.light(
                  text: context.l10n.fill_form_later_button_2,
                  onTap: () => AutoRouter.of(context).push(PreAuthMainRoute()),
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
