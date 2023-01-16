import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/size_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/space.dart';

class FillOnboardingFormLaterScreen extends StatelessWidget {
  const FillOnboardingFormLaterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 249, 249, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: size.height * 0.2),
                Container(
                  constraints: BoxConstraints(maxHeight: size.height * 0.64),
                  width: double.infinity,
                  child: SvgPicture.asset(
                    LoonoAssets.person,
                    alignment: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: context.mediaQuery.compactSizeOf(40),
                          right: context.mediaQuery.compactSizeOf(size.width * 0.2),
                          left: context.mediaQuery.compactSizeOf(18),
                        ),
                        child: Column(
                          children: [
                            Text(
                              l10n.fill_formLater_title,
                              style: LoonoFonts.headerFontStyle,
                            ),
                            const CustomSpacer.vertical(20),
                            Text(
                              l10n.fill_formLater_text,
                              style: LoonoFonts.paragraphFontStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.mediaQuery.compactSizeOf(18.0),
                    vertical: context.mediaQuery.compactSizeOf(40),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LoonoButton(
                        text: context.l10n.fill_form_later_button_1,
                        onTap: () => AutoRouter.of(context).popForced(),
                      ),
                      const CustomSpacer.vertical(8),
                      LoonoButton.light(
                        text: context.l10n.fill_form_later_button_2,
                        onTap: () => AutoRouter.of(context).push(PreAuthMainRoute()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
