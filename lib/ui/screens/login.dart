import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.l10n.login_header,
                  textAlign: TextAlign.left,
                  style: LoonoFonts.headerFontStyle,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/carousel_doctors.svg',
              width: MediaQuery.of(context).size.width,
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SocialLoginButton.apple(
                onPressed: () {
                  // TODO: Login with Apple (https://cesko-digital.atlassian.net/browse/LOON-176)
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SocialLoginButton.google(
                onPressed: () {
                  // TODO: Login with Google (https://cesko-digital.atlassian.net/browse/LOON-176)
                },
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => AutoRouter.of(context).pushNamed('welcome'),
              child: Text(
                context.l10n.login_start_over_button,
                style: LoonoFonts.paragraphFontStyle,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
