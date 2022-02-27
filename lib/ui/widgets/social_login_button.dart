import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/helpers/social_login_helpers.dart';
import 'package:loono/ui/widgets/extend_inkwell.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton.apple({
    Key? key,
    required this.onPressed,
    this.text,
  })  : socialLoginButtonType = SocialLoginMethod.apple,
        border = const Border.fromBorderSide(BorderSide()),
        assetLogoPath = 'assets/icons/apple-logo.svg',
        buttonColor = LoonoColors.black,
        super(key: key);

  const SocialLoginButton.google({
    Key? key,
    required this.onPressed,
    this.text,
  })  : socialLoginButtonType = SocialLoginMethod.google,
        border = const Border.fromBorderSide(BorderSide(color: LoonoColors.googleLogInBlue)),
        assetLogoPath = 'assets/icons/google-logo.svg',
        buttonColor = LoonoColors.googleLogInBlue,
        super(key: key);

  final SocialLoginMethod socialLoginButtonType;
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
