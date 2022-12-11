import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/sex_extensions.dart';
import 'package:loono/helpers/size_helpers.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/services/database_service.dart';
import 'package:loono/services/db/database.dart';
import 'package:loono/ui/widgets/badges/badge_composer.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/ui/widgets/loono_point.dart';
import 'package:loono/ui/widgets/space.dart';
import 'package:loono/utils/registry.dart';
import 'package:loono_api/loono_api.dart';

class BadgeOverviewScreen extends StatelessWidget {
  BadgeOverviewScreen({
    Key? key,
    this.onButtonTap,
  }) : super(key: key);

  final VoidCallback? onButtonTap;

  final _usersDao = registry.get<DatabaseService>().users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding: EdgeInsets.only(
                      left: context.mediaQuery.compactSizeOf(24.0),
                      top: context.mediaQuery.compactSizeOf(100),
                    ),
                    child: SvgPicture.asset(
                      LoonoAssets.heroBackground,
                      width: double.infinity,
                      height: context.mediaQuery.size.width * 0.735,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomSpacer.vertical(24),
                      Text(
                        '${sex == Sex.MALE ? context.l10n.gamification_introduction_header_male : context.l10n.gamification_introduction_header_female} ${user?.nickname ?? (sex?.getNicknameHintLabel(context)) ?? ''}',
                        textAlign: TextAlign.center,
                        style: LoonoFonts.headerFontStyle,
                      ),
                      const CustomSpacer.vertical(18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const LoonoPointIcon(color: LoonoColors.primaryEnabled, width: 16.0),
                          const CustomSpacer.horizontal(7),
                          Text(
                            '${user?.points ?? 0} ${context.l10n.gamification_introduction_points.toUpperCase()}',
                            style: LoonoFonts.subtitleFontStyle.copyWith(
                              color: LoonoColors.primaryEnabled,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Scrollbar(
                              thumbVisibility: true,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  const BadgeComposer(),
                                  const CustomSpacer.vertical(10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.mediaQuery.compactSizeOf(18),
                                    ),
                                    child: _buildDescContainer(context),
                                  ),
                                  SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
                                  SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.mediaQuery.compactSizeOf(18),
                                  ),
                                  child: LoonoButton(
                                    key: const Key('badgeOverviewPage_btn_continue'),
                                    text: context.l10n.gamification_introduction_button,
                                    onTap: onButtonTap ??
                                        () => AutoRouter.of(context)
                                            .replaceAll([const MainScreenRouter()]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
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
        padding: EdgeInsets.all(context.mediaQuery.compactSizeOf(18)),
        child: Text(
          context.l10n.gamification_introduction_desc,
          style: LoonoFonts.paragraphFontStyle,
        ),
      ),
    );
  }
}
