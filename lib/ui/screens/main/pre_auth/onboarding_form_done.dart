import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/ui_helpers.dart';
import 'package:loono/ui/widgets/social_login_button.dart';

class OnboardingFormDoneScreen extends StatelessWidget {
  const OnboardingFormDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Přihlaš se a získej osobní seznam preventivních prohlídek\n\nTODO: screen UI',
                textAlign: TextAlign.center,
                style: LoonoFonts.bigFontStyle,
              ),
              const SizedBox(height: 24),
              const Text('✔ Vstupní dotazník máš úspěšně hotový'),
              const Spacer(),
              SocialLoginButton.apple(
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              SocialLoginButton.google(
                onPressed: () {},
              ),
              SizedBox(height: LoonoSizes.buttonBottomPadding(context)),
            ],
          ),
        ),
      ),
    );
  }
}
