import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/badges/badge_composer.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class GamificationIntroductionScreen extends StatelessWidget {
  GamificationIntroductionScreen({Key? key}) : super(key: key);

  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: StreamBuilder<User?>(
              stream: _usersDao.watchUser(),
              builder: (context, snapshot) {
                final user = snapshot.data;
                final sex = user?.sex;

                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0, top: 100),
                      child: SvgPicture.asset(
                        'assets/icons/hero_background.svg',
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.735,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          '${sex == Sex.MALE ? context.l10n.gamification_introduction_header_male : context.l10n.gamification_introduction_header_female} ${user?.nickname ?? (sex?.getNicknameHintLabel(context)) ?? ''}',
                          textAlign: TextAlign.center,
                          style: LoonoFonts.headerFontStyle,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const LoonoPointIcon(color: LoonoColors.primaryEnabled, width: 16.0),
                            const SizedBox(width: 7),
                            Text(
                              '${user?.points ?? 0} ${context.l10n.gamification_introduction_points.toUpperCase()}',
                              style: LoonoFonts.subtitleFontStyle.copyWith(
                                color: LoonoColors.primaryEnabled,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        if (LoonoSizes.isScreenSmall(context))
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                const BadgeComposer(),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  child: _buildDescContainer(context),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18),
                                  child: LoonoButton(
                                    key: const Key('gamificationIntroductionPage_btn_continue'),
                                    text: context.l10n.gamification_introduction_button,
                                    onTap: () => AutoRouter.of(context).replaceAll(
                                      [const MainScreenRouter()],
                                    ),
                                  ),
                                ),
                                SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
                              ],
                            ),
                          )
                        else ...[
                          const BadgeComposer(),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: _buildDescContainer(context),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: LoonoButton(
                              key: const Key('gamificationIntroductionPage_btn_continue'),
                              text: context.l10n.gamification_introduction_button,
                              onTap: () =>
                                  AutoRouter.of(context).replaceAll([const MainScreenRouter()]),
                            ),
                          ),
                          const Spacer(flex: 2),
                        ],
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescContainer(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: LoonoColors.bottomSheetPrevention,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          context.l10n.gamification_introduction_desc,
          style: LoonoFonts.paragraphFontStyle,
        ),
      ),
    );
  }
}
