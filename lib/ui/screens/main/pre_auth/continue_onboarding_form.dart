import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/skip_button.dart';

class ContinueOnboardingFormScreen extends StatelessWidget {
  const ContinueOnboardingFormScreen({Key? key}) : super(key: key);
  final horizontalPadding = 18.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: const Color.fromRGBO(241, 249, 249, 1),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  SkipButton(
                    text: l10n.already_have_an_account_skip_button,
                    onPressed: () {
                      if (AutoRouter.of(context).isRouteActive(PreAuthMainRoute().routeName)) {
                        AutoRouter.of(context).popUntilRoot();
                      }
                      AutoRouter.of(context)
                          .push(PreAuthMainRoute(overridenPreventionRoute: LoginRoute()));
                    },
                  ),
                  Text(
                    l10n.continue_onboarding_title,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircularProgressIndicator(
                            color: LoonoColors.red,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            l10n.continue_onboarding_form_button,
                            style: const TextStyle(
                              fontSize: 16,
                              color: LoonoColors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/icons/a_doctor.svg',
                        alignment: Alignment.bottomRight,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.continue_onboarding_text,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 80),
                  LoonoButton(
                    text: l10n.continue_onboarding_form_button,
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
