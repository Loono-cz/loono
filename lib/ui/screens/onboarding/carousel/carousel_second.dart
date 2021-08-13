import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loono/constants.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/onboarding/carousel/app_bar.dart';
import 'package:loono/ui/widgets/onboarding/carousel/button.dart';
import 'package:loono/ui/widgets/onboarding/carousel/carousel_content.dart';

class OnboardingSecondCarouselScreen extends StatelessWidget {
  const OnboardingSecondCarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 248, 253, 1),
      appBar: carouselAppBar(context),
      body: SafeArea(
        child: CarouselStatContent(
          statText: context.l10n.carousel_content_2_stat,
          statTextColor: LoonoColors.primaryEnabled,
          bodyText: context.l10n.carousel_content_2_body,
          button: CarouselButton(
            text: context.l10n.continue_info,
            onTap: () => Navigator.pushNamed(context, '/onboarding/carousel3'),
          ),
        ),
      ),
    );
  }
}
