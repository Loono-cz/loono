import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/apple_log_in_button.dart';
import 'package:loono/ui/widgets/google_log_in_button.dart';
import 'package:loono/ui/widgets/skip_button.dart';

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
                      onPressed: () => Navigator.pushNamed(context, '/fallback_account/name'),
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
                      style: LoonoFonts.fontStyle,
                    ),
                    const SizedBox(height: 25),
                    AppleLogInButton(onPressed: () => print('Sign in with apple')),
                    const SizedBox(height: 15),
                    GoogleLogInButton(onPressed: () => print('Sign in with google')),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                          onPressed: () => print('click'),
                          child: Text(
                            context.l10n.by_logging_in_you_agree_to_the_terms_of_privacy,
                            style: LoonoFonts.fontStyle,
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
