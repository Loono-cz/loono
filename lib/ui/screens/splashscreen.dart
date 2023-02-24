import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/loono_sponsors.dart';

import 'package:loono/ui/widgets/space.dart';

class Splashscreen extends StatelessWidget{
  const Splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: LoonoColors.primaryLight,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          LoonoAssets.welcomeLogo,
                        ),
                        const CustomSpacer.vertical(35),
                        Text(
                          context.l10n.carousel_welcome_dialog,
                          textAlign: TextAlign.center,
                          style: LoonoFonts.headerLightFontStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                const LoonoSponsors(),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}