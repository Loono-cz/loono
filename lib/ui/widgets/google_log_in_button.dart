import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';

class GoogleLogInButton extends StatelessWidget {
  final void Function() onPressed;

  const GoogleLogInButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: LoonoColors.googleLogInBlue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(child: Center(child: SvgPicture.asset('assets/icons/google-logo.svg', width: 21))),
            Expanded(
              flex: 3,
              child: Text(
                context.l10n.sign_in_with_google_account,
                style: const TextStyle(color: LoonoColors.googleLogInBlue, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
