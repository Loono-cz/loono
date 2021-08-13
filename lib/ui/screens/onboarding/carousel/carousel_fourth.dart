import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loono/l10n/ext.dart';
import 'package:loono/ui/widgets/onboarding/carousel/app_bar.dart';
import 'package:loono/ui/widgets/onboarding/carousel/button.dart';
import 'package:loono/ui/widgets/onboarding/carousel/carousel_content.dart';

class OnboardFourthCarouselScreen extends StatelessWidget {
  const OnboardFourthCarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 249, 249, 1),
      appBar: carouselAppBar(context),
      body: SafeArea(
        child: CarouselBaseContent(
          headerText: context.l10n.carousel_content_4_header,
          bodyText: context.l10n.carousel_content_4_body,
          bottomText: context.l10n.carousel_content_4_bottom,
          image: SvgPicture.asset(
            'assets/icons/carousel_4.svg',
            width: MediaQuery.of(context).size.width,
          ),
          button: CarouselButton(
            text: context.l10n.carousel_content_4_button,
            onTap: () => Navigator.pushNamed(context, '/onboarding/gender'),
          ),
        ),
      ),
    );
  }
}
