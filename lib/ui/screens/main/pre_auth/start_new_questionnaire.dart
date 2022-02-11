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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: const Color.fromRGBO(241, 249, 249, 1),
                child: Column(
                  children: [
                    SkipButton(
                      text: context.l10n.already_have_an_account_skip_button,
                      onPressed: () {
                        if (AutoRouter.of(context).isRouteActive(PreAuthMainRoute().routeName)) {
                          AutoRouter.of(context).popUntilRoot();
                        }
                        AutoRouter.of(context)
                            .push(PreAuthMainRoute(overridenPreventionRoute: LoginRoute()));
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.carousel_content_3_welcome_hero,
                      textAlign: TextAlign.start,
                      style: LoonoFonts.headerFontStyle,
                    ),
                    SvgPicture.asset('assets/icons/people.svg'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Column(
                  children: [
                    Text(l10n.carousel_content_3_text),
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
      ),
    );
  }
}
