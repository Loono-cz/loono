import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/skip_button.dart';

class StartNewQuestionnaireScreen extends StatelessWidget {
  const StartNewQuestionnaireScreen({Key? key}) : super(key: key);
  final horizontalPading = 18.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: const Color.fromRGBO(241, 249, 249, 1),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SkipButton(
                    text: context.l10n.already_have_an_account_skip_button,
                    onPressed: () {
                      if (AutoRouter.of(context).isRouteActive(PreAuthMainRoute().routeName)) {
                        AutoRouter.of(context).popUntilRoot();
                      }
                      AutoRouter.of(context).replaceAll([
                        LoginRoute(),
                        PreAuthMainRoute(overridenPreventionRoute: LoginRoute()),
                      ]);
                    },
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPading),
                    child: Text(
                      l10n.carousel_content_3_welcome_hero,
                      textAlign: TextAlign.start,
                      style: LoonoFonts.headerFontStyle,
                    ),
                  ),
                  SvgPicture.asset('assets/icons/people.svg'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPading),
              child: Column(
                children: [
                  Text(l10n.carousel_content_3_text, style: LoonoFonts.paragraphFontStyle),
                  const SizedBox(height: 40),
                  LoonoButton(
                    text: l10n.start_new_questionnaire_button,
                    onTap: () => AutoRouter.of(context).push(const OnboardingWrapperRoute()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
