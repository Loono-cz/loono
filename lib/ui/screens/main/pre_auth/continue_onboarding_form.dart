import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/onboarding_state_helpers.dart';
import 'package:loono/helpers/size_helpers.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/space.dart';
import 'package:loono/utils/registry.dart';

class ContinueOnboardingFormScreen extends StatelessWidget {
  ContinueOnboardingFormScreen({Key? key}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;
  final _examinationQuestionnairesDao =
      registry.get<DatabaseService>().examinationQuestionnaires;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.mediaQuery.compactSizeOf(20.0);
    final isScreenSmall = LoonoSizes.isScreenSmall(context);
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              color: LoonoColors.greenLight,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  SkipButton(
                    text: l10n.already_have_an_account_skip_button,
                    onPressed: () {
                      if (AutoRouter.of(context)
                          .isRouteActive(PreAuthMainRoute.name)) {
                        AutoRouter.of(context).popUntilRoot();
                      }
                      // a hacky way till https://github.com/Milad-Akarie/auto_route_library/issues/496 is solved
                      AutoRouter.of(context).replaceAll([
                        const OnboardingWrapperRoute(),
                        LoginRoute(),
                        PreAuthMainRoute(
                          overridenPreventionRoute: LoginRoute(),
                        ),
                      ]);
                    },
                  ),
                  Text(
                    l10n.continue_onboarding_title,
                    style: LoonoSizes.responsiveStyleScale(
                      context,
                      LoonoFonts.headerFontStyle,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _buildOnboardingFormProgressIndicator(),
                            const CustomSpacer.horizontal(10),
                            Text(
                              l10n.continue_onboarding_form_progress,
                              style: LoonoFonts.subtitleColoredFontStyle,
                            )
                          ],
                        ),
                        SvgPicture.asset(
                          LoonoAssets.doctor,
                          width: isScreenSmall ? 110 : null,
                          alignment: Alignment.bottomRight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: context.mediaQuery.compactSizeOf(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.continue_onboarding_text,
                    style: LoonoFonts.paragraphFontStyle,
                  ),
                  CustomSpacer.vertical(isScreenSmall ? 30 : 80),
                  LoonoButton(
                    text: l10n.continue_onboarding_form_button,
                    onTap: () => AutoRouter.of(context)
                        .push(const OnboardingWrapperRoute()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingFormProgressIndicator() {
    return StreamBuilder<User?>(
      stream: _usersDao.watchUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        return StreamBuilder<List<ExaminationQuestionnaire>>(
          stream: _examinationQuestionnairesDao.watchAll(),
          builder: (context, snapshot) {
            final progress = snapshot.data?.getOnboardingProgress(user);
            return CircularProgressIndicator(
              value: progress ?? 0,
              strokeWidth: 2.25,
              color: LoonoColors.primaryEnabled,
              backgroundColor: LoonoColors.primaryLight,
            );
          },
        );
      },
    );
  }
}
