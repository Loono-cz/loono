import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';

enum SocialLoginButtonType { apple, google, facebook }

extension SocialLoginButtonTypeExt on SocialLoginButtonType {
  String getButtonText(BuildContext context) {
    switch (this) {
      case SocialLoginButtonType.apple:
        return context.l10n.sign_in_with_apple;
      case SocialLoginButtonType.google:
        return context.l10n.sign_in_with_google_account;
      case SocialLoginButtonType.facebook:
        return context.l10n.sign_in_with_facebook_account;
    }
  }
}

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton.apple({
    Key? key,
    required this.onPressed,
    this.text,
  })  : socialLoginButtonType = SocialLoginButtonType.apple,
        border = const Border.fromBorderSide(BorderSide()),
        assetLogoPath = 'assets/icons/apple-logo.svg',
        buttonColor = LoonoColors.black,
        super(key: key);

  const SocialLoginButton.google({
    Key? key,
    required this.onPressed,
    this.text,
  })  : socialLoginButtonType = SocialLoginButtonType.google,
        border = const Border.fromBorderSide(BorderSide(color: LoonoColors.googleLogInBlue)),
        assetLogoPath = 'assets/icons/google-logo.svg',
        buttonColor = LoonoColors.googleLogInBlue,
        super(key: key);

  const SocialLoginButton.facebook({
    Key? key,
    required this.onPressed,
    this.text,
  })  : socialLoginButtonType = SocialLoginButtonType.facebook,
        border = const Border.fromBorderSide(BorderSide(color: LoonoColors.facebookLogInBlue)),
        assetLogoPath = 'assets/icons/facebook-logo.svg',
        buttonColor = LoonoColors.facebookLogInBlue,
        super(key: key);

  final SocialLoginButtonType socialLoginButtonType;
  final VoidCallback onPressed;
  final BoxBorder border;
  final String assetLogoPath;
  final String? text;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return ExtendedInkWell(
      onTap: onPressed,
      splashColor: buttonColor.withOpacity(0.15),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(child: Center(child: SvgPicture.asset(assetLogoPath, width: 21))),
            Expanded(
              flex: 3,
              child: Text(
                text ?? socialLoginButtonType.getButtonText(context),
                style: TextStyle(color: buttonColor, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
