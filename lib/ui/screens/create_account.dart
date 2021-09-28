import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/router/app_router.gr.dart';
import 'package:loono/ui/widgets/skip_button.dart';
import 'package:loono/ui/widgets/social_login_button.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              color: const Color(0xFFEDF8FD),
              child: SafeArea(
                child: Column(
                  children: [
                    SkipButton(
                      text: context.l10n.skip,
                      onPressed: () => AutoRouter.of(context).push(const NicknameRoute()),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        context.l10n.only_a_small_step_remains_and_you_have,
                        style: LoonoFonts.headerFontStyle,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: -12,
                          top: -5,
                          child: SvgPicture.asset('assets/icons/create-account-ellipse.svg', width: 290),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            context.l10n.prevention_in_your_hands,
                            style: LoonoFonts.headerFontStyle,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: SvgPicture.asset('assets/icons/create-account-arrow.svg'))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: Column(
                  children: [
                    Text(
                      context.l10n.create_an_account_so_you_can_track_your_progress,
                      style: LoonoFonts.paragraphFontStyle,
                    ),
                    const SizedBox(height: 25),
                    SocialLoginButton.apple(onPressed: () => print('Sign in with apple')),
                    const SizedBox(height: 15),
                    SocialLoginButton.google(onPressed: () => print('Sign in with google')),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed: () => print('click'),
                          child: Text(
                            context.l10n.by_logging_in_you_agree_to_the_terms_of_privacy,
                            style: LoonoFonts.paragraphSmallFontStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
