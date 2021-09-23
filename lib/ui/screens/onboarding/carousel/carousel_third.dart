import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/onboarding/carousel/app_bar.dart';
import 'package:loono/ui/widgets/onboarding/carousel/button.dart';
import 'package:loono/ui/widgets/onboarding/carousel/carousel_content.dart';

class OnboardingThirdCarouselScreen extends StatelessWidget {
  const OnboardingThirdCarouselScreen({Key? key, this.onNext, this.onBack}) : super(key: key);

  final VoidCallback? onNext;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onBack?.call();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(241, 249, 249, 1),
        appBar: carouselAppBar(context),
        body: SafeArea(
          child: CarouselImageContent(
            headerText: context.l10n.carousel_content_3_header,
            bodyText: context.l10n.carousel_content_3_body,
            image: SvgPicture.asset(
              'assets/icons/carousel_doctors.svg',
              width: MediaQuery.of(context).size.width,
            ),
            button: CarouselButton(
              text: context.l10n.carousel_content_3_button,
              // onTap: () => AutoRouter.of(context).pushNamed('onboarding/gender'),
              onTap: () => AutoRouter.of(context).pushNamed('onboarding'),
            ),
            bottomText: context.l10n.carousel_content_3_bottom,
          ),
        ),
      ),
    );
  }
}
