import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/repositories/user_repository.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/button.dart';
import 'package:loono/utils/registry.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final _userRepository = registry.get<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoonoColors.primaryLight,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/welcome-logo.svg',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      context.l10n.carousel_welcome_dialog,
                      textAlign: TextAlign.center,
                      style: LoonoFonts.headerFontStyle,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        _buildSponsor(
                            label: context.l10n.incubated,
                            logoAsset: LoonoAssets.cdLogo,
                            width: 105),
                        const SizedBox(
                          width: 45,
                        ),
                        _buildSponsor(
                          label: context.l10n.with_support,
                          logoAsset: LoonoAssets.ppfLogo,
                          height: 50,
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildSponsor(
                      label: context.l10n.technology_partner,
                      logoAsset: LoonoAssets.cgiLogo,
                      height: 50,
                    ),
                  ],
                ),
                Column(
                  children: [
                    LoonoButton(
                      text: context.l10n.carousel_start,
                      onTap: () async {
                        final autoRouter = AutoRouter.of(context);
                        await _userRepository.createUserIfNotExists();
                        await autoRouter.push(const IntroCarouselRoute());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () async {
                        final autoRouter = AutoRouter.of(context);
                        await _userRepository.createUserIfNotExists();

                        // ignore: unawaited_futures
                        autoRouter.replaceAll([
                          LoginRoute(),
                          PreAuthMainRoute(overridenPreventionRoute: LoginRoute()),
                        ]);
                      },
                      child: Text(
                        context.l10n.carousel_have_account,
                        style: LoonoFonts.fontStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSponsor({
    required String label,
    required String logoAsset,
    double? width,
    double? height,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: LoonoFonts.paragraphSmallFontStyle,
        ),
        const SizedBox(
          height: 9,
        ),
        _buildSponsorImage(asset: logoAsset, width: width, height: height),
      ],
    );
  }

  Widget _buildSponsorImage({
    required String asset,
    double? width,
    double? height,
  }) {
    if (width != null) {
      return SvgPicture.asset(
        asset,
        width: width,
      );
    } else if (height != null) {
      return SvgPicture.asset(
        asset,
        height: height,
      );
    }
    return const SizedBox();
  }
}
