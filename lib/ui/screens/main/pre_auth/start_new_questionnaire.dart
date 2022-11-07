import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/size_helpers.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/space.dart';

class StartNewQuestionnaireScreen extends StatelessWidget {
  const StartNewQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isScreenSmall = LoonoSizes.isScreenSmall(context);
    final horizontalPadding = context.mediaQuery.compactSizeOf(18.0);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context, isScreenSmall, horizontalPadding),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.mediaQuery
                            .compactSizeOf(isScreenSmall ? 10 : 30),
                        horizontal: horizontalPadding,
                      ),
                      child: Text(
                        l10n.carousel_content_3_text,
                        style: LoonoFonts.paragraphFontStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomSpacer.vertical(isScreenSmall ? 20 : 40),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical:
                context.mediaQuery.compactSizeOf(isScreenSmall ? 10 : 30),
                horizontal: horizontalPadding,
              ),
              child: LoonoButton(
                text: l10n.start_new_questionnaire_button,
                onTap: () =>
                    AutoRouter.of(context).push(const OnboardingWrapperRoute()),
              ),
            ),
            if (!isScreenSmall) const CustomSpacer.vertical(20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, bool isScreenSmall, double horizontalPadding,) {
    return Container(
      color: const Color.fromRGBO(241, 249, 249, 1),
      child: Column(
        children: [
          const CustomSpacer.vertical(10),
          SkipButton(
            text: context.l10n.already_have_an_account_skip_button,
            onPressed: () {
              if (AutoRouter.of(context).isRouteActive(PreAuthMainRoute.name)) {
                AutoRouter.of(context).popUntilRoot();
              }
              AutoRouter.of(context).replaceAll([
                LoginRoute(),
                PreAuthMainRoute(overridenPreventionRoute: LoginRoute()),
              ]);
            },
          ),
          CustomSpacer.vertical(isScreenSmall ? 6 : 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              context.l10n.carousel_content_3_welcome_hero,
              textAlign: TextAlign.start,
              style: LoonoSizes.responsiveStyleScale(
                context,
                LoonoFonts.headerFontStyle,
              ),
            ),
          ),
          SizedBox(
            width: context.mediaQuery.size.width * 0.9,
            child: SvgPicture.asset(LoonoAssets.people),
          ),
        ],
      ),
    );
  }
}
